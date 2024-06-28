# Docker Notes

## Using an Image
- **List Images**: `docker image ls`
- **Pull an Image**: `docker pull <image_name>:<tag>`

## Using a Dockerfile
- **Build Image**: `docker build -t <image_name> .`
  - Builds an image from a Dockerfile in the current directory.
- **Build Context**: The `.` at the end specifies the build context (current directory).

## Running a Container
- **Run Container (Default Command)**: `docker run -d --name <container_name> <image_name>`
  - `-d` runs the container in detached mode (background).
  - `--name` assigns a name to the container.
- **Run Container (Custom Command)**: `docker run -d --name <container_name> <image_name> <command>`
  - Overrides the default CMD in the Dockerfile.

## Interacting with Containers
- **List Containers**: `docker container ls -a`
- **Start an Exited Container**: `docker start <container_name>`
- **Attach to Running Container**: `docker attach <container_name>`
- **Execute Command in Running Container**: `docker exec -it <container_name> <command>`
  - Commonly used to open a shell with `/bin/sh` or `/bin/bash`.

## Misc
- **View Logs**: `docker logs <container_name>`
- **Stop Container**: `docker stop <container_name>`
- **Remove Container**: `docker rm <container_name>`
- **Remove Image**: `docker rmi <image_name>`
- **List all containers**: `docker ls -la`
- **List all images**: `docker images`
- **Remove all containers**: `docker rm $(docker ps -a -q)`
- **Remove all images**: `docker rmi $(docker images -q)`

---------------------------------------------------------------

## Creating a simple image

### 1. Pulling an Alpine Image
- **Pull Alpine Image**: `docker pull alpine:latest`
  - Downloads the latest Alpine Linux image from Docker Hub.

### 2. Installing Figlet Inside a Container
- **Run Alpine Container**: `docker run -it --name temp_alpine alpine:latest /bin/sh`
  - Starts an interactive container from the Alpine image and opens a shell session.
  - `run` is the command to run a container
  - `-it` option combines `-i` (keeps STDIN open even if not attached) and `-t` (allocates a pseudo-TTY, simulating a terminal). This combination allows for interactive command line interaction inside the container.
  - `--name` is the flag to name the container
  - `alpine:latest` is the image to use
  - `/bin/sh` is the command to run inside the container
- **Inside the container, install Figlet:**
  - Update the package list: `apk update`
  - Install Figlet: `apk add figlet`
  - Exit the container: `exit`

### 3. Creating an Image of This Container
- **Commit Changes to New Image**: `docker commit temp_alpine alpine_figlet`
  - Creates a new image named `alpine_figlet` from the `temp_alpine` container, which now has Figlet installed.

### 4. Running a Command Inside a Container with This Image
- **Run Figlet in new container and detach the container**
  - `docker run -d --name figlet_container_d alpine_figlet sh -c "figlet 'hello'; tail -f /dev/null"`
  - `-d` flag will detach the container leaving it running in the background after the cmd was executed
  - `tail -f /dev/null` is a command that will run forever, leaving the container running in the background
    for demonstration purposes.
  - **View Output of Detached Container**: `docker logs figlet_container_d`
    - This command will display the logs from the container.
- **Run Figlet Command in New Container and close the contianer**:
  - `docker run -it --name figlet_container_closed alpine_figlet figlet "hello"`
  - adding the `-rm` flag will remove the container after it exits, cleaning it up
    since there is no use for the container afterwards.

**Check the difference**
`docker container ps -la`


*Now you have 2 containers, one that closed and one that is still running.*
*Since the closed container wont have anything to do, restarting it will not allow you to get to the terminal*

### 5. Access the existing container to run more commands
- **Interact with the detached running container**: To run additional commands in a detached container that is still running, use the `docker exec` command with specific flags for interactive access.
  - **Command to open a shell in the detached container**: 
    - `docker exec -it figlet_container_d /bin/sh`
  - **Using `-it` and `/bin/sh`**:
    - The `-it` (once agaian) runs the container in interactive mode
    - Use `/bin/sh` to open a shell session within the container.
    - *exiting the container will not stop the container as the `tail -f /dev/null` is still running*
    - *run `docker stop figlet_container_d` to stop the container(takes 10 seconds due to the `tail -f /dev/null`)*
- **Restart and access the closed container**: If a container has exited and you need to run more access it you can ues the `docker start` commands.
  - **Rerun the closed container**
    - `docker start -a figlet_container_closed`
    - `docker start` will restart the container, but it will not open a shell session.
    - `-i` will restart the container and open a shell session.
    - `-a` will restart the container and attach to it, allowing you to interact with the container's command line interface.
    - *starting a container with no commands to run will immediately close the container again*

-----------------------------------------

## **Using a dockerfile to create an NGINX container**

`docker build`: Used to build a Docker image from a Dockerfile.
`docker run`: Used to run a Docker container based on a Docker image.
`docker pull`: Used to pull a Docker image from a registry, such as Docker Hub.
`docker push`: Used to push a Docker image to a registry.
`docker ps`: Used to list the running Docker containers on a system.
`docker stop`: Used to stop a running Docker container.
`docker rm`: Used to remove a Docker container.
`docker rmi`: Used to remove a Docker image.
`docker exec`: Used to execute a command in a running Docker container.
`docker logs`: Used to view the logs for a Docker container.


### Docker difference between `RUN` and `CMD`:
- `RUN`: This command is used to run commands in the Docker image.
- `CMD`: This command is used to set the default command to run when a container is started from the image.

// NGINX

### 1. 

get logs during runtime (server booted but isnt loading webpage):
docker logs 

https://www.plesk.com/blog/various/nginx-configuration-guide/