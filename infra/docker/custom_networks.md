# Custom Networks

Docker allows us to create `custom bridge networks` so that our containers can communicate with each other if we want them to, but remain otherwise isolated. We're going to build a system where the application servers are hidden within a custom network, and only our load balancer is exposed to the host.

Let's create a custom bridge network called "caddytest".

```bash
docker network create caddytest
```

You can see if it worked by listing all the networks:

```bash
docker network ls
```

Restart your application servers on the network

Stop and restart your caddy application servers, but this time, make sure you attach them to the caddytest network and give them names:

```bash
docker run --network caddytest --name caddy1 -p 8001:80 -v $PWD/index1.html:/usr/share/caddy/index.html caddy
docker run --network caddytest --name caddy2 -p 8002:80 -v $PWD/index2.html:/usr/share/caddy/index.html caddy
```

Contacting the caddy servers through the bridge

To make sure it's working, let's get a shell session inside a "getting started" container on the custom network:

```bash
docker run -it --network caddytest docker/getting-started /bin/sh
```

By giving our containers some names, caddy1 and caddy2, and providing a bridge network, Docker has set up name resolution for us! The container names resolve to the individual containers from all other containers on the network. Within your docker/getting-started container shell, curl the first container:

```bash
curl caddy1
curl caddy2
```

Once you get the HTML responses that you expect, exit out of your shell session within the "getting started" container and then run and submit the tests.

Note that if you need to restart your caddy application servers after naming them, you can use: docker start caddy1 and docker start caddy2.
