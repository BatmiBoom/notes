# Docker

Is a technology that you interact primarily through your local command line.

There are a couple of moving parts to keep in mind when it comes to using Docker on your local machine:

1. The "Docker Service" or "Docker Daemon". This listens to requests from the desktop app and executes them. If this isn't running nothing else will work.
2. The "Docker Desktop" GUI. Starting the GUI should start the server. The GUI is the visual way to interact with Docker.
3. The Docker CLI. As a developer, most of your work will be interacting with Docker via the CLI. I'd recommend using the GUI to visualize what's going on with Docker, but executing most of your commands through the commands line

## What is Docker?

Allow us to deploy our applications inside "containers" which can be thought of as very lightweight virtual machines. Instead of just shipping an application, we can ship an application and the environment it's meant to run within.

## What is a Container?

> A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.

The trouble with VM is that they are very heavy on resources. Booting one up often takes longer than booting up your physical machine.

A container gives us 85% of the benefits that virtual machines offer, but are super lightweight. Containers boot up in seconds, while virtual machines can take minutes.

### VM Architecture

```
|-----------|-----------|-----------|
|   VM      |   VM      |   VM      |
|-----------|-----------|-----------|
| App A     | App B     | App C     |
|-----------|-----------|-----------|
| Guest     | Guest     | Guest     |
| Operating | Operating | Operating |
| System    | System    | System    |
|-----------|-----------|-----------|
|         HYPERVISOR                |
|-----------------------------------|
|         INSFRASTRUCTURE           |
|-----------------------------------|
```

### Container (Docker) Architecture

```
|-----------|-----------|-----------|
| App A     | App B     | App C     |
|-----------|-----------|-----------|
|             DOCKER                |
|-----------------------------------|
|         HOST OPERATING SYSTEM     |
|-----------------------------------|
|          INSFRASTRUCTURE          |
|-----------------------------------|
```

### Whats makes such a big difference in performance?

VM virtualize hardware, they emulate what a physical computer does at a very low level. Containers virtualize at the operating system level. Isolation between containers that are running on the same machines is still really good. For the most part, it appears to each container as if it has its own operating and filesystem. In reality, a lot of resources are being shared, but they're being shared securely through **namespaces**

## Docker Hub

Is the official cloud service for storing and sharing Docker images. There are other alternatives, and they're usually coupled with cloud service providers. For example, when using AWS, you can use ECR to store images. When in GCP, you can use Container Registry.

# Images vs Containers

- `images` is the read-only definitions of a container.
- `container` is a virtualized read-write environment.

A container is essentially just an image that's actively running.
