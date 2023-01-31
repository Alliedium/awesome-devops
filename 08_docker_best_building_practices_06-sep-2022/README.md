## Docker best practices II: multistage builds, different examples  ##

### Table of contents ###

| Example | Details |
|------|-------|
| [Example 1](#spring-boot) | Simple Spring Boot application improved |
| [Example 2](#pytorch) | Dockerfile of pytorch |
| [Example 3](#pytorch-dependencies) | Python dependencies in a separate image parameterized by hash |
| [Example 4](#cmd-entrypoint) | CMD vs ENTRYPOINT |
| [Example 5](#user-defined-network) | Isolation of containers by user-defined network |
| [Example 6](#ca-certificates) | Put ca-certificates into base image, parameterize the image by certificates hash |

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- Java installed via script from the previously cloned `awesome-linux-config` repository (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md)):
     
    ```
    ./awesome-linux-config/manjaro/basic/install_jdk11.sh 
    ```

    or simply run the command:

    ```
    sudo pacman -S --noconfirm --needed jdk11-openjdk
    ```

### <a id="spring-boot"></a>Example 1: Simple Spring Boot application improved ###

1. Get the latest project code version:

```	
cd $HOME/devops-course-2022
git pull
```

2. Change to the example directory: 

```
cd $HOME/devops-course-2022/08_docker_best_building_practices_06-sep-2022/demo-multi-stage-improved/
```
	
3. Get the directory contents:

```
ls -a
```
	
Output: `gradle  src  .dockerignore  build.gradle  Dockerfile  gradlew  gradlew.bat  settings.gradle`.

4. Build the application from the host (VM):

```
chmod +x ./gradlew
./gradlew clean build
```
	
5. Get the directory contents:

```
ls -a
```

Output: `.gradle  build  gradle  src  .dockerignore  build.gradle  Dockerfile  gradlew  gradlew.bat  settings.gradle`.

The folders `.gradle` and `build` were added.

6. Start the application:

```
java -jar build/libs/spring-boot-0.0.1-SNAPSHOT.jar
```

Output: log records, the last one: `welcomePageHandlerMapping`.

7. Open the second Bash (terminal) window and connect to VM by SSH.
	
8. In the second Bash window, check that the app is running properly:

```
curl localhost:8080
```

Output: `Greetings from Spring Boot!%`.

First Bash window: three new log records were added.
	
9. In the second Bash window, stop the SSH connection and close the window.

10. In the first Bash window, stop the app (\[Ctrl+C\]).
	
11. Check the contents of the `.dockerignore` file:

```
cat ./.dockerignore
```

12.	Check the contents of the `Dockerfile`:

```
cat Dockerfile
```

### <a id="pytorch"></a>Example 2: Dockerfile of pytorch ###
	
https://github.com/pytorch/pytorch/blob/master/Dockerfile

Commands for building the image	were not performed on the lecture.

The building process takes about 15 minutes. The image takes 14.6 GB disk space.

13-17*.
		
```
git clone https://github.com/pytorch/pytorch $HOME/pytorch
cd $HOME/pytorch
git checkout -B v1.12.1 tags/v1.12.1
bash ./.github/scripts/build_publish_nightly_docker.sh
docker images
```
	
### <a id="pytorch-dependencies"></a>Example 3: Python dependencies in a separate image parameterized by hash ###

18. Change to the example directory:

```	
cd $HOME/devops-course-2022/08_docker_best_building_practices_06-sep-2022/dependencies
```

19. Get the contents of the directory:
	
```
ls -a
```

Output:
```
build-deps-image.sh  Dockerfile-deps              python_env_install.py
Dockerfile-app       get-python-req-check-sum.sh  python_requirements.yml
```

20. See the package list:

```
cat python_requirements.yml
```

21. Get the contents of Dockerfile for building dependencies image:

```
cat Dockerfile-deps
```

22. See the shell script that builds the dependencies image:

```
cat build-deps-image.sh
```

23. See the shell script that calculates hash of the files `python_env_install.py` and `python_requirements.yml`:

```
cat ./get-python-req-check-sum.sh
```

24. Calculate the hash:

```
./get-python-req-check-sum.sh
```

Output: `b6f6eb0218ab7ae82a57dc162fa43eab`.

25. Build the base image with the dependencies installed:

```
./build-deps-image.sh
```

Building process takes about two minutes. The last output line contains the tag of the image just built:

`deps:PRCS-b6f6eb0218ab7ae82a57dc162fa43eab`

26. See the Dockerfile for building application based on the base image:

```
cat ./Dockerfile-app
```

No instructions after `FROM $BASE_IMAGE`, only comments.

27. Run the build command for application:

```
docker build --file Dockerfile-app --build-arg BASE_IMAGE=$(./build-deps-image.sh | tail -n 1) .
```

Building process takes about 0.2s. 
Since there is no `-t` option in the `docker build` command, and no instructions after `FROM $BASE_IMAGE` in the `Dockerfile-app`, the image built on this step coincides with the base image.

28. Get the list of images:

```
docker images
```

The Image ID for image with the Tag `PRCS-b6f6eb0218ab7ae82a57dc162fa43eab` is listed only once.

### <a id="cmd-entrypoint"></a>Example 4: CMD vs ENTRYPOINT ###

29. Change to the example directory:

```
cd $HOME/devops-course-2022/08_docker_best_building_practices_06-sep-2022/cmd_vs_entrypoint
```

30. Get the contents of the directory:

```
ls
```

Output: `Dockerfile  Dockerfile-postgres-customized`.

31. See an example for building postgres image with non-default parameters:

```
cat ./Dockerfile-postgres-customized
```

32. See an example of Dockerfile where CMD is used for passing parameters to ENTRYPOINT:

```
cat ./Dockerfile
```

33. Build an image from the Dockerfile:

```
docker build -t darwin:latest .
```

Building process takes 1.5s.

34. Create and start a container based on the image built on the previous step, without pointing the last `docker run` parameter. 

The option `--rm` means that the container will be removed automatically after is it stopped:

```
docker run --rm darwin
```

Output: `Hello Darwin`

35. Create and start similar container with the last `docker run` parameter to be string `User`:

```
docker run --rm darwin User
```

Output: `Hello User`

### <a id="user-defined-network"></a>Example 5: Isolation of containers by user-defined network ###

36. Get the list of Docker networks:

```
docker network ls
```
	
If there are no user-defined networks, the output contains three records: for `bridge`, `host` and `none` networks.

37. Create a user-defined network of type `bridge`, with the name `demo-bridge`:

```
docker network create --driver bridge demo-bridge
```

Output: `<NETWORK ID>` (the network is created)

38. Get the list of Docker networks:

```
docker network ls
```

There appear a new record with the `<NETWORK ID>` from the previous step, and the name `demo-bridge`.

39. Create and start a container in detached mode, named `demo-net-1`, in the new network:

```	
docker run -d --name demo-net-1 -h demo-net-1 --network demo-bridge rtsp/net-tools
```

40. Create a container in the new network to ping the previous `demo-net-1`, remove the container after ping:

```
docker run --rm --name demo-net-2 -h demo-net-2 --network demo-bridge rtsp/net-tools ping -c 3 demo-net-1
```

Ping successful, `0% packet loss`.

41. Create a container in the default network to ping `demo-net-1`, remove the container after the ping.

```
docker run --rm --name demo-net-3 -h demo-net-3 rtsp/net-tools ping -c 3 demo-net-1
```

Ping failed. Output: `ping: demo-net-1: Name or service not known`

### <a id="ca-certificates"></a>Example 6: Put ca-certificates into base image, parameterize the image by certificates hash ###

42. Change to the example directory:

```
cd $HOME/devops-course-2022/08_docker_best_building_practices_06-sep-2022/certs
```

43. Get the contents of the directory:

```
ls
```

Output: `build-base-image.sh  Dockerfile-app  Dockerfile-certs`

44. See the shell script that builds the base image:

```
cat ./build-base-image.sh
```

45. Get the contents of the Dockerfile for building the base image:

```
cat ./Dockerfile-certs
```

The next steps were not performed on the lecture
------------------------------------------------  

46*. Copy ca-certificates to the HOME folder:

```
cp -r $HOME/devops-course-2022/08_docker_best_building_practices_06-sep-2022/.certs ~
```

47*. Build base image with programmatically defined tag, and application image with user-defined tag `demo-certs:latest`:

```
 docker build -t demo-certs --file Dockerfile-app --build-arg BASE_IMAGE=$(./build-base-image.sh | tail -n 1) .
```

48*. Get the list of images:

```
docker images
```

There are two images with the same `IMAGE ID` (it may differ from the value given below):
```
REPOSITORY                        TAG                                     IMAGE ID       ...
certs                             792b64caee459e16460a15bdd83dcf1b        7cab03803d76   ...
demo-certs                        latest                                  7cab03803d76   ... 
```

### References ###

1. [`.dockerignore` file](https://docs.docker.com/engine/reference/builder/#dockerignore-file)
2. [PyTorch Dockerfile](https://github.com/pytorch/pytorch/blob/master/Dockerfile)
3. [PyTorch script for creating Container Image](https://github.com/pytorch/pytorch/blob/master/.github/scripts/build_publish_nightly_docker.sh)
4. [PyTorch `docker.Makefile` used in the script for creating Container Image](https://github.com/pytorch/pytorch/blob/master/docker.Makefile)
5. [PyTorch image on Docker Hub: Tags](https://hub.docker.com/r/pytorch/pytorch/tags)
6. [Docker CMD vs ENTRYPOINT: What’s The Difference & How To Choose](https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/)
7. [Clean up (--rm) option of `docker run` command](https://docs.docker.com/engine/reference/run/#clean-up---rm)
8. [Container networking](https://docs.docker.com/config/containers/container-networking/)
9. [Network settings in `docker run` command](https://docs.docker.com/engine/reference/run/#network-settings)
10. [Container networking: DNS services](https://docs.docker.com/config/containers/container-networking/#dns-services)
11. [RTSP Network Tools Docker Image](https://hub.docker.com/r/rtsp/net-tools)
12. [Docker behind SSL intercepting proxy](https://technotes.shemyak.com/posts/docker-behind-ssl-proxy/)