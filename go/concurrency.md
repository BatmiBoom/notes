- [CONCURRENCY](#CONCURRENCY)
  - [CHANNELS](#CHANNELS)
    - [CREATE A CHANNEL](#CREATE A CHANNEL)
    - [SEND DATA TO A CHANNEL](#SEND DATA TO A CHANNEL)
    - [RECEIVE DATA FROM A CHANNEL](#RECEIVE DATA FROM A CHANNEL)
    - [BLOCKING AND DEADLOCKS](#BLOCKING AND DEADLOCKS)
    - [BUFFERED CHANNELS](#BUFFERED CHANNELS)
      - [CREATING A CHANNEL WITH A BUFFER](#CREATING A CHANNEL WITH A BUFFER)
    - [CLOSING CHANNELS](#CLOSING CHANNELS)
      - [CHECKING IF A CHANNEL IS CLOSED](#CHECKING IF A CHANNEL IS CLOSED)
    - [RANGE](#RANGE)
    - [SELECT](#SELECT)
    - [SELECT DEFAULT CASE](#SELECT DEFAULT CASE)
    - [READ-ONLY CHANNELS](#READ-ONLY CHANNELS)
    - [WRITE-ONLY CHANNELS](#WRITE-ONLY CHANNELS)
    - [TIPS](#TIPS)
    - [EXAMPLE:](#EXAMPLE:)

# CONCURRENCY

Concurrency is the ability to perform multiple tasks at the same time. Typically, our code is executed one line at a time, one after the other. This is called sequential execution or synchronous execution.

```text
    SYNCHRONOUS EXECUTION
    ---------->---------->
        task1   task2

    CONCURRENT EXECUTION
    -------------> task1
    -------------> task2
```

If the computer we're running our code on has multiple cores, we can even execute multiple tasks at exactly the same time. If we're running on a single core, a single core executes code at almost the same time by switching between tasks very quickly. Either way, the code we write looks the same in Go and takes advantage of whatever resources are available.

**HOW DOES CONCURRENCY WORK IN GO?**

Go was designed to be concurrent, which is a trait fairly unique to Go. It excels at performing many tasks simultaneously safely using a simple syntax.

There isn't a popular programming language in existence where spawning concurrent execution is quite as elegant, at least in my opinion.

Concurrency is as simple as using the go keyword when calling a function:

`go doSomething()`

In the example above, `doSomething()` will be executed concurrently with the rest of the code in the function. The `go` keyword is used to spawn a new `goroutine`.

Suppose we have a function call `f(s)`. Here’s how we’d call that in the usual way, running it `synchronously`.

A `goruoutine` is a lightweight thread of execution. To invoke this function in a `goroutine`, use `go` `f(s)`. This new `goroutine` will execute concurrently with the calling one

```go
import (
    "fmt"
    "time"
)

func f(from string) {
    for i := 0; i < 3; i++ {
        fmt.Println(from, ":", i)
    }
}
func main() {
    f("direct")

    go f("goroutine")

    go func(msg string) {
        fmt.Println(msg)
    }("going")

    time.Sleep(time.Second)
    fmt.Println("done")
}
```

## CHANNELS

Channels are a typed, thread-safe queue. Channels allow different `goroutines` to communicate with each other.

Empty `structs` are often used as `tokens` in Go programs. In this context, a token is a unary value. In other words, we don't care what is passed through the channel.

We care _when_ and _if_ it is passed.

### CREATE A CHANNEL

Like maps and slices, channels must be created before use. They also use the same `make` keyword.

```go
ch := make(chan int)
```

### SEND DATA TO A CHANNEL

```go
ch <- 69
```

The `<-` operator is called the channel operator. Data flows in the direction of the arrow. This operation will block until another `goroutine` is ready to receive the value.

### RECEIVE DATA FROM A CHANNEL

```go
v := <- ch
```

This reads and removes a value from the channel and saves it into the variable `v`. This operation will **block** until there is a value in the channel to be read.

### BLOCKING AND DEADLOCKS

A **deadlock** is when a group of `goroutines` are all blocking so none of them can continue. This is a **common bug** that you need to watch out for in concurrent programming.

We can block and wait until something is sent on a channel using the following syntax

`<- ch`

This will block until it pops a single item off the channel, then continue, discarding the item.

### BUFFERED CHANNELS

Channels can optionally be buffered.

#### CREATING A CHANNEL WITH A BUFFER

You can provide a buffer length as the second argument to make() to create a buffered channel:

`ch := make(chan int, 100)`

Sending on a buffered channel only blocks when the buffer is full.

Receiving blocks only when the buffer is empty.

```go
func addEmailsToQueue(emails []string) chan string {
	ch := make(chan string, len(emails))

	for i := 0; i < len(emails); i++ {
		ch <- emails[i]
	}

	return ch
```

### CLOSING CHANNELS

Channels can be explicitly closed by a sender:

```go
ch := make(chan int)

close(ch)
```

#### CHECKING IF A CHANNEL IS CLOSED

Similar to the `ok` value when accessing data in a `map`, receivers can check the `ok` value when receiving from a channel to test if a channel was closed.

```go
v, ok := <- ch
```

`ok` is false if the channel is _empty_ and _closed_.

**DON'T SEND ON A CLOSED CHANNEL**

Sending on a closed channel will cause a panic. A panic on the main `goroutine` will cause the entire program to crash, and a panic in any other `goroutine` will cause that `goroutine` to crash.

Closing isn't necessary. There's nothing wrong with leaving channels open, they'll still be garbage collected if they're unused. You should close channels to indicate explicitly to a receiver that nothing else is going to come across.

```go
func countReports(numSentCh chan int) int {
	count := 0
	for {
		v, ok := <- numSentCh

		if ok == false {
			break
		}

		count += v
	}

	return count
}

func sendReports(numBatches int, ch chan int) {
	for i := 0; i < numBatches; i++ {
		numReports := i*23 + 32%17
		ch <- numReports
	}
	close(ch)
}
```

### RANGE

Similar to slices and maps, channels can be ranged over.

```go
for item := range ch {
    // item is the next value received from the channel
}
```

This example will receive values over the channel (blocking at each iteration if nothing new is there) and will exit only when the channel is closed.

- Example:

```go
func concurrentFib(n int) []int {
	ch := make(chan int)

	go fibonacci(n, ch)

	result := []int{}
	for value := range ch {
		result = append(result, value)
	}

	return result
}

func fibonacci(n int, ch chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		ch <- x
		x, y = y, x+y
	}
	close(ch)
}
```

### SELECT

Sometimes we have a single `goroutine` listening to multiple channels and want to process data in the order it comes through each channel.

A `select` statement is used to listen to multiple channels at the same time. It is similar to `switch` statement but for channels.

```go
select {
case i, ok := <- chInts:
    fmt.Println(i)
case s, ok := <- chStrings:
    fmt.Println(s)
}
```

The first channel with a value ready to be received will fire and its body will execute. If multiple channels are ready at the same time one is chosen randomly. The `ok` variable in the example above refers to whether or not the channel has been closed by the sender yet.

### SELECT DEFAULT CASE

The `default` case in a `default` statement executes _immediately_ if no other channel has a value ready. A `default` case stops the `select` statement from blocking

```go
select {
case v := <-ch:
    // use v
default:
    // receiving from ch would block
    // so do something else
}
```

```go
func waitForDBs(numDBs int, dbChan chan struct{}) {
	for i := 0; i < numDBs; i++ {
		<-dbChan
	}
}

func getDBsChannel(numDBs int) (chan struct{}, *int) {
	count := 0
	ch := make(chan struct{})

	go func() {
		for i := 0; i < numDBs; i++ {
			ch <- struct{}{}
			fmt.Printf("Database %v is online\n", i+1)
			count++
		}
	}()

	return ch, &count
}

dbChan, count := getDBsChannel(numDBs)
waitForDBs(numDBs, dbChan)
for *count != test.numDBs {
    fmt.Println("...")
}
```

```go
import (
	"time"
)

type email struct {
	body string
	date time.Time
}

func checkEmailAge(emails [3]email) [3]bool {
	isOldChan := make(chan bool)

	go sendIsOld(isOldChan, emails)

	isOld := [3]bool{}
	isOld[0] = <-isOldChan
	isOld[1] = <-isOldChan
	isOld[2] = <-isOldChan
	return isOld
}

// don't touch below this line

func sendIsOld(isOldChan chan<- bool, emails [3]email) {
	for _, e := range emails {
		if e.date.Before(time.Date(2020, 0, 0, 0, 0, 0, 0, time.UTC)) {
			isOldChan <- true
			continue
		}
		isOldChan <- false
	}
}
```

### READ-ONLY CHANNELS

A channel can be marked as read-only by casting it from `chan` to a `<-chan` type.

```go
func main() {
    ch := make(chan int)
    readCh(ch)
}

func readCh(ch <-chan int) {
    // ch can only be read from
    // in this function
}
```

### WRITE-ONLY CHANNELS

The same goes for write-only channels, but the arrow's position moves.

```go
func writeCh(ch chan<- int) {
    // ch can only be written to
    // in this function
}

```

### TIPS

**SEND TO A NIL CHANNEL BLOCKS FOREVER** [ The sender will block forever ]

```go
var c chan string // c is nil
c <- "let's get started" // blocks
```

**RECEIVE FROM A NIL CHANNEL BLOCKS FOREVER** [ The reciever block forever ]

```go
var c chan string // c is nil
fmt.Println(<-c) // blocks
```

**SEND TO A CLOSED CHANNEL PANICS**

```go
var c = make(chan int, 100)
close(c)
c <- 1 // panic: send on closed channel
```

**A RECEIVE FROM A CLOSED CHANNEL RETURNS THE ZERO VALUE IMMEDIATELY**

```go
var c = make(chan int, 100)
close(c)
fmt.Println(<-c) // 0
```

### EXAMPLE:

```go
import (
	"time"
)

func saveBackups(snapshotTicker, saveAfter <-chan time.Time, logChan chan string) {
	for {
		select {
		case <-snapshotTicker:
			takeSnapshot(logChan)
		case <-saveAfter:
			saveSnapshot(logChan)
			return
		default:
			waitForData(logChan)
			time.Sleep(500 * time.Millisecond)
		}
	}
}

func takeSnapshot(logChan chan string) {
	logChan <- "Taking a backup snapshot..."
}

func saveSnapshot(logChan chan string) {
	logChan <- "All backups saved!"
	close(logChan)
}

func waitForData(logChan chan string) {
	logChan <- "Nothing to do, waiting..."
}
```

```go
func processMessages(messages []string) []string {
	ch := make(chan string, len(messages))
	for _, msg := range messages {
		go func(m string) {
			ch <- m + "-processed"
		}(msg)
	}

	result := make([]string, len(messages))

	for i:= 0; i < len(messages); i++ {
		result[i] = <-ch
	}

	return result
}
```

```go
func waitForDBs(numDBs int, dbChan chan struct{}) {
	for i := 0; i < numDBs; i++ {
		<-dbChan
	}
}

func getDBsChannel(numDBs int) (chan struct{}, *int) {
	count := 0
	ch := make(chan struct{})

	go func() {
		for i := 0; i < numDBs; i++ {
			ch <- struct{}{}
			fmt.Printf("Database %v is online\n", i+1)
			count++
		}
	}()

	return ch, &count
}

dbChan, count := getDBsChannel(numDBs)
waitForDBs(numDBs, dbChan)
for *count != test.numDBs {
    fmt.Println("...")
}
```

```go
import (
	"time"
)

type email struct {
	body string
	date time.Time
}

func checkEmailAge(emails [3]email) [3]bool {
	isOldChan := make(chan bool)

	go sendIsOld(isOldChan, emails)

	isOld := [3]bool{}
	isOld[0] = <-isOldChan
	isOld[1] = <-isOldChan
	isOld[2] = <-isOldChan
	return isOld
}

// don't touch below this line

func sendIsOld(isOldChan chan<- bool, emails [3]email) {
	for _, e := range emails {
		if e.date.Before(time.Date(2020, 0, 0, 0, 0, 0, 0, time.UTC)) {
			isOldChan <- true
			continue
		}
		isOldChan <- false
	}
}
```
