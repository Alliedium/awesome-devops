## Docker Best Practices I ##
-----------------------------

### Example 1: Simple Spring Boot application in a container with multi-stage build ###


1. Get !!! the project code


2. Unpack to  ~/Docker/demo-multi-stage


2. Get docker disk usage

```
docker system df
``` 

Suppose the system to be clean: all values are 0.


3. Change to the context directory

```
cd ~/Docker/demo-multi-stage/complete
```

3. See the Dockerfile contents

```
nano Dockerfile
```

Two `FROM` instructions define two build stages. On the first stage of the source code is copied from the context to the first stage file system and then compiled. 
The second stage takes from the first stage only the compilation result. 

Quit the nano editor

```
Hit <Ctrl+X>
```

4. Build the image

```
docker build -t bkarpov/demo-multi-stage:0.1 --build-arg BASE_IMAGE=gradle:7.5.1-jdk11-alpine .
```

The build process takes about a minute ro two. The image contains only the layers of the second stage. The layers og the first stage are put in build cache.   


5. Get list of images

```
docker images
```

Image `bkarpov/demo-multi-stage:0.1` of size 176 MB is in the list


3. Get docker disk usage

```
docker system df
```

The following values were added to the values on Step 3??

```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          1         1         175.8MB   0B (0%)
Containers      0         0         0B        0B (0%)
Local Volumes   0         0         0B        0B
Build Cache     18        0         103.3MB   103.3MB
```


4. Build another image with the same Dockerfile and context

```
docker build -t bkarpov/demo-multi-stage:0.2 --build-arg BASE_IMAGE=gradle:7.5.1-jdk11-alpine .
```

The build process takes a few seconds. 


4. Get list of images

```
docker images
```

Images `bkarpov/demo-multi-stage:0.1` and `bkarpov/demo-multi-stage:0.2` have the same Image ID.  


4. Remove the another image

```
docker rmi bkarpov/demo-multi-stage:0.2
```

Only tag `0.2` has been removed, not the image: `Untagged: bkarpov/demo-multi-stage:0.2`


5. Get list of images

```
docker images
```

Image `bkarpov/demo-multi-stage:0.1` is still present in the list


6. Create and run container based on the image `bkarpov/demo-multi-stage:0.1`. Map the host port 7080 to the container port 8080

```
docker run -d -p 7080:8080 bkarpov/demo-multi-stage:0.1
```

Output: `<CONTAINER_ID>` (Container is created and running)


7. Connect to the application running in the container from the host

```
curl localhost:7080
```

Output: `Greetings from Spring Boot!%` (The app is running) 


7. Log in to the default Container Registry (Docker hub)

```
docker login
```

8. Push the image to the Registry

```
docker push bkarpov/demo-multi-stage:0.1
```

Only two layers are pushed, the others are mounted from the Registry


8. Log out from the Container Registry

```
docker logout
```

9. Clean the docker system

```
docker stop <CONTAINER_ID>
docker rm <CONTAINER_ID>
docker rmi bkarpov/demo-multi-stage:0.1
docker builder prune
```