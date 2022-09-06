## Docker best practices II ##
------------------------------
	

## Example 1: Simple Spring Boot application improved ##



1. Get the project code
	
If you have already made a clone of the Devops Course git repository, do the following steps

```	
cd ~/devops-course-2022
git pull
```
	
Otherwise, clone the repo

```	
cd ~
git clone https://github.com/Alliedium/devops-course-2022.git
```	

2. Change to the example directory 

```
cd ./devops-course-2022/06_sep_2022_docker_best_practices_ii/demo-multi-stage-improved/
```
	
3. Get the directory contents

```
ls -a
```	
	
Output: `gradle  src  .dockerignore  build.gradle  Dockerfile  gradlew  gradlew.bat  settings.gradle`
		

4. Build the application from the host (VM)

```
./gradlew clean build
```
	
5. Get the directory contents

```
ls -a
```

Output: `.gradle  build  gradle  src  .dockerignore  build.gradle  Dockerfile  gradlew  gradlew.bat  settings.gradle`

The folders `.gradle` and `build` were added
		

6. Start the application

```
java -jar build/libs/spring-boot-0.0.1-SNAPSHOT.jar
```

Output: log records, the last one: `welcomePageHandlerMapping`
		

7. Open the second Bash (terminal) window and connect to VM by ssh

	
8. In the second Bash window, check that the app is running properly

```
curl localhost:8080
```

Output: `Greetings from Spring Boot!%` 

First Bash window: three log records added
	
	
9. In the second Bash window, stop the ssh connection and close the window.


10. In the first Bash window, stop the app

```
Hit <Ctrl+C>
```
	
11. See the contents of the `.dockerignore` file

```
nano ./.dockerignore
```
		
	
12.	See the contents of the `Dockerfile`

```
nano Dockerfile
```
	

### Example 2: Dockerfile of pytorch ###

	
https://github.com/pytorch/pytorch/blob/master/Dockerfile

Commands for building the image	were not perfromed on the lecture.

The building process takes about 15 minutes. The image takes 14.6GB disk space.

13-17*.
		
```
git clone https://github.com/pytorch/pytorch.git
cd ./pytorch
git checkout -B v1.12.1 tags/v1.12.1
bash ./.github/scripts/build_publish_nightly_docker.sh
docker images
```
		

	
### Example 3: Python dependences in a separate image parameterized by hash  ###
	

20. Change to the example directory

```	
cd ~/devops-course-2022/06_sep_2022_docker_best_practices_ii/dependencies
```


21. Get the contents of the directory
	
```
ls -a
```	

Output:
```
build-deps-image.sh  Dockerfile-deps              python_env_install.py
Dockerfile-app       get-python-req-check-sum.sh  python_requirements.yml
```

22. See the package list

```
nano python_requirements.yml
```

23. Get the contents of Dockerfile for building dependencies image

```
nano Dockerfile-deps
```


24. See the shell script that builds the dependencies image

```
nano build-deps-image.sh
```


25. See the shell script that calculates hash of the files `python_env_install.py` and `python_requirements.yml`

```
nano get-python-req-check-sum.sh
```

26. Calculate the hash

```
./get-python-req-check-sum.sh
```

Output: `b6f6eb0218ab7ae82a57dc162fa43eab`


27. Build the base image with the dependencies installed

```
./build-deps-image.sh
```

Building process takes about two minutes. The last output line contains the tag of the image just built:

`deps:PRCS-b6f6eb0218ab7ae82a57dc162fa43eab` 


28. See the Dockerfile for building application based on the base image

```
nano Dockerfile-app
```

No instructions after `FROM $BASE_IMAGE`, only comments


29. Run the build command for application

```
docker build --file Dockerfile-app --build-arg BASE_IMAGE=$(./build-deps-image.sh | tail -n 1) .
```

Building process takes about 0.2s. 
Since there is no `-t` option in the `docker build` command, and no instructions after `FROM $BASE_IMAGE` in the `Dockerfile-app`, the image built on this step coincides with the base image.


30. Get the list of images 

```
docker images
```

The Image ID for image with the Tag `PRCS-b6f6eb0218ab7ae82a57dc162fa43eab` is listed only once


### Example 4: CMD vs ENTRYPOINT ###


31. Change to the example directory

```
cd ~/devops-course-2022/06_sep_2022_docker_best_practices_ii/cmd_vs_entrypoint
```

32. Get the contents of the directory

```
ls
```

Output: `Dockerfile  Dockerfile-postgres-customized`


33. See an example for building postgres image with non-default parameters

```
nano Dockerfile-postgres-customized
```

34. See an example of Dockerfile where CMD is used for passing parameters to ENTRYPOINT

```
nano Dockerfile
```

35. Build an image from the Dockerfile

```
docker build -t darwin:latest .
```

Building process takes 1.5s


36. Create and start a container based on the image built on the previous step, without pointing the last `docker run` parameter. 

The option `--rm` means that the container will be removed automatically after is it stopped

```
docker run --rm darwin
```

Output: `Hello Darwin`


37. Create and start similar container with the last `docker run` parameter to be string `User`

```
docker run --rm darwin User
```

Output: `Hello User`

	
	
### Example 5: Isolation of containres by user-defined network ###


38. Get the list of Docker networks	

```
docker network ls
```
	
If there are no user-defined networks, the output contains three records: for `bridge`, `host` and `none` networks


39. Create a user-defined network of type `bridge`, with the name `demo-bridge`

```
docker network create --driver bridge demo-bridge
```

Output: `<NETWORK ID>` (the network is created)

40. Get the list of Docker networks	

```
docker network ls
```

There appear a new record with the `<NETWORK ID>` from the previous step, and the name `demo-bridge`


41. Create and start a container in detached mode, named `demo-net-1`, in the new network

```	
docker run -d --name demo-net-1 -h demo-net-1 --network demo-bridge rtsp/net-tools
```

42. Create a container in the new network to ping the previous `demo-net-1`, remove the container after ping

```
docker run --rm --name demo-net-2 -h demo-net-2 --network demo-bridge rtsp/net-tools ping -c 3 demo-net-1
```

Ping successfull, `0% packet loss`


43. Create a container in the default network to ping `demo-net-1`, remove the container after ping

```
docker run --rm --name demo-net-3 -h demo-net-3 rtsp/net-tools ping -c 3 demo-net-1
```

Ping failed. Output: `ping: demo-net-1: Name or service not known`
	


### Example 6: Put ca-certificates into base image, parameterize the image by certificates hash ###


44. Change to the example directory

```
cd ~/devops-course-2022/06_sep_2022_docker_best_practices_ii/certs
```

45. Get the contents of the directory

```
ls
```

Output: `build-base-image.sh  Dockerfile-app  Dockerfile-certs`


46. See the shell script that builds the base image

```
nano build-base-image.sh
```

47. Get the contents of the Dockerfile for building  the base image

```
nano Dockerfile-certs
```




	
