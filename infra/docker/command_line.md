# Command Line

## Help

Run `docker help`, it should spit out a giant help menu. There are a lot of commands

## Run

Docker hosts a "getting started" image for users to play with. We can run it

`docker run -d -p XX:YY docker/getting-started:latest`

- `-d` detach
- `-p` expose port
- `XX` is the host port
- `YY` is the port within the container

You can use a different port if you are unable to expose port 80 on your system.

## PS

This will list running containers in the console. On one of the columns you should see this:

```bash
$ docker ps

PORTS
0.0.0.0:80->80/tcp
```

This is saying that port 80 on your local "host" machine is being forwarded to port 80 on the running container. Port 80 is conventionally used to indicate HTTP web traffic. Navigate to http://localhost:80 and you should get a webpage describing the container you're running!

## Stop

This stops the container by issuing a `SIGTERM` signal to the container.

`docker stop CONTAINER_ID`

## Kill

This stops the container by issuing a `SIGKILL` signal to the container. This is more aggressive than `stop`

`docker kill CONTAINER_ID`

## Images

`docker images`

You should see an image with the name "docker/getting-started".

That's a static image that we downloaded from docker hub. It describes to docker how to start a new container.

## Exec

Running one-off commands in the container

`docker exec CONTAINER_ID ls`

This executes an `ls` command in the running container and returns the result to our current shell session.

## Live Shell

Often is more convenient to start a shell session running within the container itself

`docker exec -it CONTAINER_ID /bin/sh`

- `-i` makes the `exec` command interactive.
- `-t` gives us a **tty interface**.
- `/bin/sh` is the path to the command we're running. A command line shell is just a program. `sh` is a more basic version of bash.
