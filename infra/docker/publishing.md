# Publishing to Docker Hub

Let's review a bit about what Docker Hub is.

Docker Hub is the official cloud service for storing and sharing Docker images. We call these kinds of services "registries". Other popular image registries include:

`AWS ECR`
`GCP Container Registry`
`GitHub Container Registry`
`Harbor`
`Azure ACR`

Let's publish the Go webserver we used a couple of chapters ago up to Docker Hub. You will want to navigate back over to that directory now.

## Rebuild the application

```bash
GOOS=linux GOARCH=amd64 go build
```

## Rebuild the image

We need to rebuild the image with a name that corresponds to its namespace on Docker Hub. Swap out USERNAME for your Docker Hub username.

```bash
docker build . -t USERNAME/goserver
```

## Run it to make sure it works

```bash
docker run -p 8080:8080 USERNAME/goserver
```

## Push the image to Docker Hub

```bash
docker push USERNAME/goserver
```

If everything worked, you should be able to refresh your repositories page and see your new image!

## Delete and Pull

Let's delete our local copy of the image, then pull it back down from Docker Hub. Just like with GitHub, the nice thing about having images in the cloud is that if something happens to your computer, or you're working on another machine, you can always pull down your images.

## Remove your local image

```bash
docker image rm USERNAME/goserver
```

## Pull it down from Docker

```bash
docker pull USERNAME/goserver
```

## Tag a New Version

Let's publish a new version of our web server.

### Deployment Pipelines

Publishing new versions of Docker images is a very common method of deploying cloud-native back-end servers. Here's a diagram describing the deployment pipeline of many production systems (including the server that powers the Boot.dev site you're on currently).

### Deployment Pipeline

1. Edit your code.
   Update your Go code so that the message in the HTML says `Hi Docker, I pushed a new version!`. Build a new executable.
2. Build and run your new image
   Let's tag the new image with a new minor version. We're fans of semantic versioning here, though it's a common convention to not include the v in Docker tags.
   ```bash
   docker build . -t USERNAME/goserver:0.2.0
   docker run -p 8080:8080 USERNAME/goserver:0.2.0
   ```
3. Push a new version
   ```bash
   docker push USERNAME/goserver:0.2.0
   ```

Navigate to your repo on DockerHub and now you should see 2 images with different tags.

Delete the local images so that you have no reference on your local machine. Pull and run the new version from Docker Hub.

`docker pull USERNAME/goserver:0.2.0`

## Latest

If you look closely, you'll notice that your old version is tagged "latest"... that's a bit confusing. As it turns out, the latest tag doesn't always indicate that a specific tag is the latest version of an image. In reality, latest is just the default tag that's used if you don't explicitly supply one. We didn't use a tag on our first version, that's why it was tagged with "latest".

## Should I use "latest"?

The convention I'm familiar with is to use semantic versioning on all your images, but to also push to the "latest" tag. That way you can keep all of your old versions around, but the latest tag still always points to the latest version.

**You can build and push for multiple tags like this:**

```bash
docker build -t username/imagename:0.0.0 -t username/imagename:latest .
docker push username/imagename --all-tags
```
