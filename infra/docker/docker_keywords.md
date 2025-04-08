## Keywords

1. **`FROM`**

   - Specifies the base image for the new image.
   - Example: `FROM ubuntu:20.04`

2. **`RUN`**

   - Executes a command during the build process.
   - Used to install software or configure the environment.
   - Example: `RUN apt-get update && apt-get install -y nginx`

3. **`CMD`**

   - Specifies the default command to run when the container starts.
   - Can be overridden with `docker run` arguments.
   - Example: `CMD ["nginx", "-g", "daemon off;"]`

4. **`ENTRYPOINT`**

   - Defines the main executable for the container.
   - Typically used in conjunction with `CMD` to pass default arguments.
   - Example: `ENTRYPOINT ["python"]`

5. **`WORKDIR`**

   - Sets the working directory for subsequent commands like `RUN`, `CMD`, and `ENTRYPOINT`.
   - Example: `WORKDIR /app`

6. **`COPY`**

   - Copies files or directories from the host to the container.
   - Example: `COPY . /app`

7. **`ADD`**

   - Similar to `COPY`, but also supports extracting tar files and accessing URLs.
   - Example: `ADD archive.tar.gz /app`

8. **`EXPOSE`**

   - Declares the ports that the container listens on at runtime.
   - This is for documentation purposes and does not publish the ports automatically.
   - Example: `EXPOSE 80`

9. **`ENV`**

   - Sets environment variables in the container.
   - Example: `ENV APP_ENV production`

10. **`ARG`**

    - Defines build-time variables that can be passed using the `--build-arg` flag.
    - Example: `ARG VERSION=1.0`

11. **`LABEL`**

    - Adds metadata to the image, such as description, version, or maintainer information.
    - Example: `LABEL maintainer="yourname@example.com"`

12. **`VOLUME`**

    - Creates a mount point for a volume to persist data or share files between host and container.
    - Example: `VOLUME /data`

13. **`USER`**

    - Specifies the user to run the container's processes.
    - Example: `USER nonroot`

14. **`ONBUILD`**

    - Adds triggers to a parent image, which execute when the image is used as a base for another build.
    - Example: `ONBUILD RUN apt-get update`

15. **`SHELL`**

    - Specifies the shell to use for the `RUN` commands.
    - Example: `SHELL ["/bin/bash", "-c"]`

16. **`HEALTHCHECK`**

    - Defines a command to check the health of the container.
    - Example:
      ```dockerfile
      HEALTHCHECK --interval=30s CMD curl -f http://localhost/ || exit 1
      ```

17. **`STOPSIGNAL`**

    - Specifies the signal to send to the container to stop it gracefully.
    - Example: `STOPSIGNAL SIGTERM`

18. **`COPY --chown`**
    - Copies files to the container and sets ownership at the same time.
    - Example: `COPY --chown=user:group . /app`
