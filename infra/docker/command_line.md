# Command Line

## Help

Run `docker help`, it should spit out a giant help menu. There are a lot of commands

## Container

### Run

Docker hosts a "getting started" image for users to play with. We can run it

`docker run -d -p XX:YY docker/getting-started:latest`

- `-d` detach
- `-p` expose port
- `XX` is the host port
- `YY` is the port within the container

`docker run -d -e NODE_ENV=development -e url=http://localhost:3001 -p 3001:2368 -v ghost-vol:/var/lib/ghost/content ghost`

- `-e NODE_ENV=development` sets an env variable
- `-e url=http://localhost:3001` sets another env variable
- `-p` expose port
- `-v ghost-vol:/var/lib/ghost/content` mounts the `ghost-vol` volume that we create to the `/var/lib/ghost/content` path in the container

`docker run -d --network none docker/getting-started`

- `--network none` this removes the network interface from the container

`docker run -it --network caddytest docker/getting-started /bin/sh`

- `-i` interactive. Keeps STDIN (standard input) open even if you're not directly attached. This is essential for interactive processes that need user input, such as a shell.
- `-t` Allocates a pseudo-TTY (a terminal interface) to the container. This makes the container's output appear like it's running in a terminal.
- `--network caddytest` use a custom network to communicate different container

Combining -i and -t allows you to interact with the container in a terminal session, making it especially useful for debugging or running commands directly within the container.

### PS

This will list running containers in the console. On one of the columns you should see this:

```bash
$ docker ps

|    PID      |        IMAGE           |     COMMAND      | CREATED | STATUS |      PORTS        |
|-------------|------------------------|------------------|---------|--------|-------------------|
|CONTAINER_ID | docker/getting-started | ................ | ....... | Exited |0.0.0.0:80->80/tcp |
```

- `-a` to see every container running or not

### Stop

This stops the container by issuing a `SIGTERM` signal to the container.

`docker stop CONTAINER_ID`

### Kill

This stops the container by issuing a `SIGKILL` signal to the container. This is more aggressive than `stop`

`docker kill CONTAINER_ID`

### Remove

Removes one or more container

`docker rm CONTAINER_ID`

- `-f` force the removal of a running container (uses `SIGKILL`)
- `l` Remove the specified link
- `v` Remove anonymous volumes associated with the container

### Exec

Running one-off commands in the container

`docker exec CONTAINER_ID ls`

This executes an `ls` command in the running container and returns the result to our current shell session.

## Live Shell

Often is more convenient to start a shell session running within the container itself

`docker exec -it CONTAINER_ID /bin/sh`

- `-i` makes the `exec` command interactive.
- `-t` gives us a **tty interface**.
- `/bin/sh` is the path to the command we're running. A command line shell is just a program. `sh` is a more basic version of bash.

## Images

`docker images`

You should see an image with the name "docker/getting-started".

That's a static image that we downloaded from docker hub. It describes to docker how to start a new container.

### Download an image

`docker pull image-name`

## Volumes

### Create Vol

`docker volume create vol-name`

### List Vol

`docker volume ls`

### Inspect Vol

`docker volume inspect vol-name`

### Remove a vol

`docker volume rm vol-name`

## Network

### Create network

`docker network create network_name`

### List Networks

`docker network ls`
