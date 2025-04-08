## What is a Load Balancers?

A load balancer behaves as advertised: it balances a load of network traffic. Think of a huge website like `google.com`. There's no way that a single server ( literally a single computer ) could handle all of the Google searches for the entire world. Google uses load balancers to route requests to different servers

## How does a load balancer work?

A central server, called the "load balancer", receives traffic from users (aka clients), then routes those raw requests to different back-end applications servers. In the case of Google, this splits the world's traffic across potentially many different thousands of computers

```
clients      load balancers       servers
   c                                 s
   c         |------------|          s
   c    <--->|------------|<---->    s
   c         |------------|          s
   c                                 s
```

## How does it "balance" the traffic?

A good load balancer sends more traffic to servers that have unused resources (CPU and memory). The goal is to "balance the load" evenly. We don't want any individual server to fail due to too much traffic. There are many strategies that load balancers use, but a simple strategy is the "round robin". Requests are simply routed one after the other to different back-end servers

- Request 1 -> Server 1
- Request 2 -> Server 2
- Request 3 -> Server 3
- Request 4 -> Server 1
- Request 5 -> Server 2

## Application Servers

First, we need to start some application servers so that we have something to load balance! We'll be using `Caddy`, an awesome open-source load balancer/web server. `Nginx` and `Apache` are other popular alternatives that do similar things.

## What will our application servers do?

Each application server will serve a slightly different HTML webpage. The reason they're different is just so that we can see load balancing in action!

1. Pull down the caddy image
   `docker pull caddy`
2. Create an `index1.html` file in your working directory
   ```html
   <html>
     <body>
       <h1>Hello from server 1</h1>
     </body>
   </html>
   ```
3. Create an `index2.html` file in your working directory
   ```html
   <html>
     <body>
       <h1>Hello from server 2</h1>
     </body>
   </html>
   ```
4. Run caddy containers to serve the HTML
   `docker run -p 8001:80 -v $PWD/index/index1.html:/usr/share/caddy/index.html caddy`

5. Run a container for index2.html on port 8002:
   `docker run -p 8002:80 -v $PWD/index/index2.html:/usr/share/caddy/index.html caddy`

You can run them in separate terminal sessions, or you can run them in detached mode with `-d`, whichever you prefer.

Navigate to `localhost:8001` in a browser. You should see "Hello from server 1". Next, navigate to `localhost:8002` and hopefully, you'll see "Hello from server 2"!

- [Second Part](./custom_networks.md)

## Configuring the load balancer

We've confirmed that we have 2 application servers (Caddy) working properly on a custom bridge network. Let's create a load balancer that balances network requests between the two! We'll use a round-robin balancing strategy, so each request should route back and forth between the servers.

### Caddyfile for the loadbalancer

Caddy works great as a file server, which is what our little HTML servers are, but it also works great as a load balancer! To use Caddy as a load balancer we need to create a custom Caddyfile to tell Caddy how we want it to balance traffic.

Create a new file in your local directory called Caddyfile:

```Caddyfile
localhost:80

reverse_proxy caddy1:80 caddy2:80 {
	lb_policy       round_robin
}
```

This tells Caddy to run on `localhost:80`, and to round robin any incoming traffic to `caddy1:80` and `caddy2:80`. Remember, this only works because we're going to run the loadbalancer within the same network, so `caddy1` and `caddy2` will automatically resolve to our application server's containers.

### Run the loadbalancer

Instead of providing an index.html to this Caddy server, we're going to give it our custom Caddyfile.

```bash
docker run --network caddytest -p 8080:80 -v $PWD/Caddyfile:/etc/caddy/Caddyfile caddy
```

Now you can hit the load balancer on http://localhost:8080/! You should either get a response from server 1 or server 2, and if you hard refresh the page, it will swap back and forth.

If it's not swapping properly, try using curl instead. Your browser might be caching the HTML.

```bash
curl localhost:8080
```

Each time you run curl, you should get a response from a different server!
