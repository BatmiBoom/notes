# The Bigger Picture

## The Deployment Process

- The developer (you) writes some new code
- The developer commits the code to Git
- The developer pushes a new branch to GitHub
- The developer opens a pull request to the main branch
- A teammate reviews the PR and approves it (if it looks good)
- The developer merges the pull request
- Upon merging, an automated script, perhaps a Github action, is started
- The script builds the code (if it's a compiled language)
- The script builds a new docker image with the latest program
- The script pushes the new image to Docker Hub
- The server that runs the containers, perhaps a Kubernetes cluster, is told there is a new version
- The k8s cluster pulls down the latest image
- The k8s cluster shuts down old containers as it spins up new containers of the latest image

## It's never the same

While the deployment process I've outlined above is a common one, especially at newer "cloud native" companies, two companies rarely have identical processes. Instead of GitHub, it might be GitLab. Instead of Docker Hub, it might be ECR. Instead of Kubernetes, it might be Docker Swarm or a more managed service.
