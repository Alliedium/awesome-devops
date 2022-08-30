## Docker Best Practices I ##
-----------------------------

### Example 1: Simple Spring Boot application in a container with multi-stage build ###


To perform the Steps ,
 
- you should have an account on Dockerhub https://hub.docker.com/

- you have to tag the image to be pushed as `<your_Dockerhub_login>/demo-multi-stage:0.1` instead of `bkarpov/demo-multi-stage:0.1` 


1. Get the project code. Copy all following commands at once, paste them to Linux terminal and hit <Enter>

```
mkdir ~/devops-course-2022
cd ~/devops-course-2022
git init
git remote add origin https://github.com/boris-karpov/devops-course-2022/
git config core.sparseCheckout true
echo "30_aug_2022_docker_best_practices_i/demo-multi-stage" >> .git/info/sparse-checkout
git pull --depth=1 origin main
```

The working directory will change to `~/devops-course-2022`

Project directory will be created `~/devops-course-2022/30_aug_2022_docker_best_practices_i/demo-multi-stage`
  

2. Get docker disk usage

```
docker system df
``` 

Suppose the system to be clean: all values are 0.


3. Change to the project directory

```
cd ~/devops-course-2022/30_aug_2022_docker_best_practices_i/demo-multi-stage
```

4. See the Dockerfile contents

```
nano Dockerfile
```

Two `FROM` instructions define two build stages. On the first stage of the source code is copied from the context to the first stage file system and then compiled. 
The second stage takes from the first stage only the compilation result. 

Quit the nano editor

```
Hit <Ctrl+X>
```

5. Build the image. If you have an account on Dockerhub, use the tag `<your_Dockerhub_login>/demo-multi-stage:0.1` instead of `bkarpov/demo-multi-stage:0.1`

```
docker build -t bkarpov/demo-multi-stage:0.1 --build-arg BASE_IMAGE=gradle:7.5.1-jdk11-alpine .
```

The build process takes about two minutes. The image contains only the layers of the second stage. The layers of the first stage are put in build cache.   


6. Get list of images

```
docker images
```

Image `bkarpov/demo-multi-stage:0.1` of size 176 MB is in the list


7. Get docker disk usage

```
docker system df
```

If the docker system was clean on Step 2, the output would be the following: 

```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          1         1         175.8MB   0B (0%)
Containers      0         0         0B        0B (0%)
Local Volumes   0         0         0B        0B
Build Cache     18        0         103.3MB   103.3MB
```

Otherwise, the output values are added to the corresponding values received on Step 2


8. Build another image with the same Dockerfile and context

```
docker build -t bkarpov/demo-multi-stage:0.2 --build-arg BASE_IMAGE=gradle:7.5.1-jdk11-alpine .
```

The build process takes a few seconds. 


9. Get list of images

```
docker images
```

Images `bkarpov/demo-multi-stage:0.1` and `bkarpov/demo-multi-stage:0.2` have the same Image ID.  


10. Remove the another image

```
docker rmi bkarpov/demo-multi-stage:0.2
```

Only tag `0.2` has been removed, not the image: `Untagged: bkarpov/demo-multi-stage:0.2`


11. Get list of images

```
docker images
```

Image `bkarpov/demo-multi-stage:0.1` is still present in the list


12. Create and run a container based on the image `bkarpov/demo-multi-stage:0.1`. Map the host port 7080 to the container port 8080

```
docker run -d -p 7080:8080 bkarpov/demo-multi-stage:0.1
```

Output: `<CONTAINER_ID>` (Container is created and running)


13. Connect to the application running in the container from the host

```
curl localhost:7080
```

Output: `Greetings from Spring Boot!%` (The app is running) 


14. The default Container Registry for Docker is Dockerhub (https://hub.docker.com/)

To perform the next three Steps
 
- you should have an account on Dockerhub

- you have to tag the image to be pushed as `<your_Dockerhub_login>/demo-multi-stage:0.1` instead of `bkarpov/demo-multi-stage:0.1`

You can tag an image by the command `docker tag` or `docker image tag` (https://docs.docker.com/engine/reference/commandline/tag/)  



15. Log in to the default Container Registry (Dockerhub)

```
docker login
```

16. Push the image to the Container Registry

```
docker push <your_Dockerhub_login>/demo-multi-stage:0.1
```

Only two layers are pushed, the others are mounted from the Registry


17. Log out from the Container Registry

```
docker logout
```

18. Clean the docker system

```
docker stop <CONTAINER_ID>
docker rm <CONTAINER_ID>
docker rmi bkarpov/demo-multi-stage:0.1
docker builder prune
```