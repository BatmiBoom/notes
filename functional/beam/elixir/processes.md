# Processes

All code runs inside processes. Characteristics:

- Are isolated from each other
- Run concurrent to one another
- Communicate via message passing.

They are not the same as operating system processes. This are extremely lightweight in terms of memory and CPU.

## Spawning processes

The basic mechanism for spawning new processes is the auto-imported `spawn/1` function that returns a `PID`:

```elixir
spawn(fn -> 1 + 2 end) #PID<0.43.0>
```

We can use the `PID` to retrieve data about the process

```elixir
pid = spawn(fn -> 1 + 2 end)
Process.alive?(pid)
```

We can retrieve the `PID` of the current process by calling `self/0`

```elixir
self() #PID<0.41.0>
Process.alive?(self()) # true
```

Let's see what happens when a process started with `spawn/1` fails:

```elixir
spawn(fn -> raise "oops" end) #[error] Process #PID<0.58.00>
```

It merely logged an error but the parent process is still running. That's because processes are isolated.

## Sending and Receiving messages

We can send messages to a process with `send/2` and receive them with `receive/1`:

```elixir
send(self(), {:hello, "world"}) # {:hello, "world"}
receive do
  {:hello, msg} -> msg
  {:world, _msg} -> "won't match"
end
# "world"
```

When a message is sent to a process, the message is stored in the process mailbox. The `receive/1` block goes through the current process mailbox searching for a message that matches any of the given patterns. `receive/1` supports guards and many clauses, such as `case/2`.

The process that sends the message does not block on `send/2`, it puts the message in the recipient's mailbox and continues. In particular, a process can send messages to itself.

If there is no message in the mailbox matching any of the patterns, the current process will wait until a matching message arrives. A timeout can also be specified:

```elixir
receive do
    {:hello, msg} -> msg
after
    1_000 -> "nothing after 1s"
end
# "nothing after 1s"
```

A timeout of 0 can be given when you already expect the message to be in the mailbox.

Let's put it all together and send messages between processes:

```elixir
parent = self() #PID<0.41.0>
spawn(fn -> send(parent, {:hello, self()}) end) #PID<0.48.0>
receive do
    {:hello, pid} -> "Got hello from #{inspect pid}"
end
#"Got hello from #PID<0.48.0>"
```

The `inspect/1` function is used to convert a data structure's internal representation into a string, typically for printing.

While in the shell, you may find the helper `flush/0` quite useful. It flushes and prints all the messages in the mailbox.

```elixir
send(self(), :hello) #:hello
flush() # :hello :ok
```

## Links

The majority of times we spawn processes in Elixir, we spawn them as linked processes. If we want the failure in one process to propagate to another one, we should link them. This can be done with spawn_link/1:

```elixir
self() #PID<0.41.0>
spawn_link(fn -> raise "oops" end) #** (EXIT from #PID<0.41.0>) evaluator process exited with reason: an exception was raised:
```

Because processes are linked, we now see a message saying the parent process, which is the shell process, has received an EXIT signal from another process

Linking can also be done manually by calling `Process.link/1`.

Processes and links play an important role when building fault-tolerant systems. Elixir processes are isolated and don't share anything by default. Therefore, a failure in a process will never crash or corrupt the state of another process. Links, however, allow processes to establish a relationship in case of failure. We often link our processes to supervisors which will detect when a process dies and start a new process in its place.

While other languages would require us to catch/handle exceptions, in Elixir we are actually fine with letting processes fail because we expect supervisors to properly restart our systems. "Failing fast" (sometimes referred as "let it crash") is a common philosophy when writing Elixir software!

`spawn/1` and `spawn_link/1` are the basic primitives for creating processes in Elixir.

## Tasks

Tasks build on top of the spawn functions to provide better error reports and introspection:

```elixir
Task.start(fn -> raise "oops" end) #{:ok, #PID<0.55.0>}
```

Instead of `spawn/1` and `spawn_link/1`, we use `Task.start/1` and `Task.start_link/1` which return `{:ok, pid}` rather than just the `PID`. This is what enables tasks to be used in supervision trees. Furthermore, Task provides convenience functions, like `Task.async/1` and `Task.await/1`, and functionality to ease distribution.

## State

We haven't talked about state so far. If you are building an application that requires state, for example, to keep your application configuration, or you need to parse a file and keep it in memory, where would you store it?

Processes are the most common answer to this question. We can write processes that loop infinitely, maintain state, and send and receive messages. As an example, let's write a module that starts new processes that work as a key-value store in a file named kv.exs:

```elixir
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

```

Note that the `start_link` function starts a new process that runs the `loop/1` function, starting with an empty map. The `loop/1` function then waits for messages and performs the appropriate action for each message. In the case of a `:get` message, it sends a message back to the caller and calls `loop/1` again, to wait for a new message. While the `:put` message actually invokes `loop/1` with a new version of the map, with the given key and value stored.

Let's give it a try by running `iex kv.exs`:

```elixir
{:ok, pid} = KV.start_link() # {:ok, #PID<0.62.0>}
send(pid, {:get, :hello, self()}) # {:get, :hello, #PID<0.41.0>}
flush() # nil :ok
```

At first, the process map has no keys, so sending a `:get` message and then flushing the current process inbox returns `nil`. Let's send a `:put` message and try it again:

```elixir
send(pid, {:put, :hello, :world}) # {:put, :hello, :world}
send(pid, {:get, :hello, self()}) # {:get, :hello, #PID<0.41.0>}
flush() # :world :ok
```

Notice how the process is keeping a state and we can get and update this state by sending the process messages.

It is also possible to register the pid, giving it a name, and allowing everyone that knows the name to send it messages:

```elixir
Process.register(pid, :kv) # true
send(:kv, {:get, :hello, self()}) # {:get, :hello, #PID<0.41.0>}
flush() #:world :ok
```

Using processes to maintain state and name registration are very common patterns in Elixir applications. However, most of the time, we won't implement those patterns manually as above, but by using one of the many abstractions that ship with Elixir. For example, Elixir provides Agents, which are simple abstractions around state. Our code above could be directly written as:

```elixir
{:ok, pid} = Agent.start_link(fn -> %{} end) # {:ok, #PID<0.72.0>}
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end) # :ok
Agent.get(pid, fn map -> Map.get(map, :hello) end) # :world
```

A `:name` option could also be given to `Agent.start_link/2` and it would be automatically registered. Besides agents, Elixir provides an API for building generic servers (called GenServer), registries, and more, all powered by processes underneath.
