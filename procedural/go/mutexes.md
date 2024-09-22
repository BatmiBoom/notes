# MUTEXES

Allow us to _lock_ access to data. This ensures that we can control which `goroutines` can access certain data at which time.

The principle problem that `mutexes` help us avoid is the _concurrent read/write problem_. This problem arises when one thread is writing to a variable while another thread is reading from that same variable _at the same time_

When this happens, a Go program will panic because the reader could be reading bad data while it's being mutated in place.

```text
                          MUTEX
|--------|  Wait    |--------------------|  Wait    |--------|
| Thread | <----->  |   Shared Resources | <----->  | Thread |
|________| Release  |____________________| Release  |________|


```

Go's standard library provides a built-in implementation of a `mutex` with the `sync.Mutex` type and its two methods:

- `Lock()`
- `Unlock()`

Mutex is short for [mutual exclusion](https://en.wikipedia.org/wiki/Mutual_exclusion), and the conventional name for the data structure that provides it is "mutex", often abbreviated to "mu"

We can protect a block of code by surrounding it with a call to `Lock` and `Unlock` as shown on the protected() method below.

It's good practice to structure the protected code within a function so that defer can be used to ensure that we never forger to unlock the mutex.

```go
func protected() {
    mu.Lock()
    defer mu.Unlock()

    // the rest of the function is protected
    // any other calls to `mu.Lock()` will block
}
```

## MAPS ARE NOT THREAD-SAFE

Maps are not safe for concurrent use! If you have multiple `goroutines` accessing the same map, and at least one of them is writing to the map, you must lock your maps with a `mutex`.

```go
import (
	"sync"
)

type safeCounter struct {
	counts map[string]int
	mu     *sync.Mutex
}

func (sc safeCounter) inc(key string) {
	sc.mu.Lock()
	defer sc.mu.Unlock()

	sc.counts[key] += 1
}

func (sc safeCounter) val(key string) int {
	sc.mu.Lock()
	defer sc.mu.Unlock()

	return sc.counts[key]
}
```

## EXAMPLE

```go
import (
	"fmt"
)

func main() {
	m := map[int]int{}
	go writeLoop(m)
	go readLoop(m)

	// stop program from exiting, must be killed
	block := make(chan struct{})
	<-block
}

func writeLoop(m map[int]int) {
	for {
		for i := 0; i < 100; i++ {
			m[i] = i
		}
	}
}

func readLoop(m map[int]int) {
	for {
		for k, v := range m {
			fmt.Println(k, "-", v)
		}
	}
}
```

The example above creates a map, then starts two `goroutines` which each have access to the map. One `goroutine` continuously mutates the values stored in the map, while the other prints the values it finds in the map.

If we run the program on a multi-core machine, we get the following output: `fatal error: concurrent map iteration and map write`

In Go, it isn’t safe to read from and write to a map at the same time.

```go
import (
	"fmt"
	"sync"
)

func main() {
	m := map[int]int{}

	mu := &sync.Mutex{}

	go writeLoop(m, mu)
	go readLoop(m, mu)

	// stop program from exiting, must be killed
	block := make(chan struct{})
	<-block
}

func writeLoop(m map[int]int, mu *sync.Mutex) {
	for {
		for i := 0; i < 100; i++ {
			mu.Lock()
			m[i] = i
			mu.Unlock()
		}
	}
}

func readLoop(m map[int]int, mu *sync.Mutex) {
	for {
		mu.Lock()
		for k, v := range m {
			fmt.Println(k, "-", v)
		}
		mu.Unlock()
	}
}
```

In this example, we added a `sync.Mutex{}` and named it `mu`. In the write loop, the `Lock()` method is called before writing, and then the `Unlock()` is called when we're done. This Lock/Unlock sequence ensures that no other threads can `Lock()` the `mutex` while we have it locked – any other threads attempting to `Lock()` will block and wait until we `Unlock()`.

In the reader, we `Lock()` before iterating over the map, and likewise `Unlock()` when we're done. Now the threads share the memory safely!

## RW MUTEX

The standard library also exposes a `sync.RWMutex`

In addition to these methods:

- Lock()
- Unlock()

The `sync.RWMutex` also has these methods:

- RLock()
- RUnlock()

The `sync.RWMutex` can help with performance if we have a read-intensive process. Many `goroutines` can safely read from the map at the same time (multiple `RLock()` calls can happen simultaneously). However, only one `goroutine` can hold a `Lock()` and all `RLock()'s` will also be excluded.

```go
import (
	"sync"
)

type safeCounter struct {
	counts map[string]int
	mu     *sync.RWMutex
}

func (sc safeCounter) inc(key string) {
	sc.mu.Lock()
	defer sc.mu.Unlock()
	sc.slowIncrement(key)
}

func (sc safeCounter) val(key string) int {
	sc.mu.RLock()
	defer sc.mu.RUnlock()
	return sc.counts[key]
}
```
