# Ping

We've already done just a bit of networking in Docker. Specifically, we've exposed containers to the host network on various ports and accessed web traffic.

Now, let's force a container into offline mode!

## Offline Mode

You might want to remove the network connection from a container in one of these scenarios:

- You're running 3rd party code that you don't trust, and it shouldn't need network access
- You're building an e-learning site, and you're allowing students to execute code no your machine
- You know a container has a virus that's sending malicious requests that's over the internet, and you want to do an adult.

## Using the "ping" utility

The `ping` command allows you to check for connectivity to a host by sending small packets of data.

If we ping `google.com`

```bash
ping google.com
PING google.com (216.58.202.78) 56(84) bytes of data.
64 bytes from eze06s09-in-f14.1e100.net (216.58.202.78): icmp_seq=1 ttl=116 time=17.7 ms
64 bytes from eze06s09-in-f14.1e100.net (216.58.202.78): icmp_seq=2 ttl=116 time=19.8 ms
64 bytes from eze06s09-in-f14.1e100.net (216.58.202.78): icmp_seq=3 ttl=116 time=19.1 ms
```

That means that we are receiving a packet from google.com of size 64 bytes

## Break the network

Let's quarantine a container and make sure that we can't reach google.

We can run the "getting started" container with the flag `--network none`

`docker run -d --network none docker/getting-started`

and if we run

`docker exec CONTAINER_ID ping google.com -W 2`

We are gonna obtain `ping:bad address`

## Load Balancer

- (Load Balancer)[./load_balancer.md]
