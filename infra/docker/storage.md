# Statefulness

Many docker containers are "stateless", or at least stateless in the persistent sense. That is, when you create a new container from the same image, it won't store any information from before. When you restart the docker/getting-started container, for example, you're starting from scratch.

That said, Docker does have ways to support a "persistent state", and the recommended way is through storage volumes.

## Volumes are independent of containers

We're going to install the Ghost blogging software on your machine through Docker. It would be fairly useless to have blogging software that doesn't save your blog posts, so we'll need to use volumes. For now, just create a new volume.

## Create Vol

`docker volume create ghost-vol`

## List Vol

`docker volume ls`

## Inspect Vol

`docker volume inspect ghost-vol`

## We can download the image for `Ghost` with

`docker pull ghost`

and we start it with

`docker run -d -e NODE_ENV=development -e url=http://localhost:3001 -p 3001:2368 -v ghost-vol:/var/lib/ghost/content ghost`

- `-e NODE_ENV=development` sets an env variable
- `-e url=http://localhost:3001` sets another env variable
- `-p` expose port
- `-v ghost-vol:/var/lib/ghost/content` mounts the `ghost-vol` volume that we create to the `/var/lib/ghost/content` path in the container

We can create a new post, restart the container and we are gonna see tat the post is still there, this is because we create a `volume` and mount it in the container

If we delete the container and delete the volume with

`docker volume rm ghost-vol`

And we run the command again

`docker run -d -e NODE_ENV=development -e url=http://localhost:3001 -p 3001:2368 -v ghost-vol:/var/lib/ghost/content ghost`

This doesn't throw any errors, because `-v ghost-vol:/var/lib/ghost/content` flag binds to a "ghost-vol" volume if it exists, otherwise, it creates it automatically
