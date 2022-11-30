# Installation methods

Official documentation:
[https://help.sonatype.com/repomanager3/installation-and-upgrades](https://help.sonatype.com/repomanager3/installation-and-upgrades)

<details>
<summary><h4>Install Nexus using Yum</h4></summary>

## Prerequisite steps:
* Rocky Linux 8

## Installation steps:
### 1. Install Sonatype Nexus 3 repo and Nexus 3 itself

following the steps from https://github.com/sonatype-nexus-community/nexus-repository-installer#yum-setup

### 2. Fine-tune the memory requirements

by editing the file `/opt/sonatype/nexus3/bin/nexus.vmoptions` (for weaker systems set

```
-Xms512m
-Xmx512m
-XX:MaxDirectMemorySize=512m
```

### 3. Enable and start Nexus 3 service

via `sudo systemctl enable nexus-repository-manager --now`

### 4. Login to Nexus as `admin`.

To ensure the system begins with a secure state, Nexus Repository Manager generates a unique random password during the system’s initial startup which it writes to the data directory (in our case it's "sonatype-work/nexus3") in a file called admin.password.

So you can use the value from this file:

`sudo cat /opt/sonatype/sonatype-work/nexus3/admin.password`

And then go to http://your_host:8081/ in your browser to log in as "admin" user using the password from the file above.
</details>

<details>
<summary><h4>Install Nexus manually</h4></summary>

## Prerequisite steps:

* Install wget utility in case if you don't have it:
```
sudo yum install wget -y

```

* Install OpenJDK 1.8 in case if you don't have it (to check the version run "java -version")
```
sudo yum install java-1.8.0-openjdk.x86_64 -y
```

## Installation steps: 

**1) Move to your /opt directory**
```
cd /opt
```

**2) Download the latest version of Nexus**

You can get the latest download links for nexus from [here](https://help.sonatype.com/repomanager3/product-information/download) (for example, *https://download.sonatype.com/nexus/3/nexus-3.38.1-01-unix.tar.gz*)
```
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
```

**3) Extract the tar file**
```
sudo tar -xvzf nexus.tar.gz
```
You should see two directories: nexus files directory (it's name is "nexus-3.20.1-01" at the screenshot below) and nexus data directory (it's name is "sonatype-work" at the screenshot below).

![1](https://user-images.githubusercontent.com/74211642/203735846-686fd7d2-9ffb-4d43-8c44-febcad94cc4c.png)

Rename the nexus files directory
```
sudo mv nexus-3* nexus
```

**4) Create new user which will run the service**

As a good security practice, it is not advised to run nexus service with root privileges. So create a new user named "nexus" to run the nexus service
```
sudo adduser nexus
```

Change the ownership of nexus files directory and nexus data directory to nexus user
```
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
```

**5) Edit "nexus.rc" file**

Open /opt/nexus/bin/nexus.rc file
```
sudo vi  /opt/nexus/bin/nexus.rc
```

Uncomment run_as_user parameter and set it as follows
```
run_as_user="nexus"
```

**6) Edit "nexus.vmoptions"**

Open the file in editor
```
sudo vi /opt/nexus/bin/nexus.vmoptions
```

In case if you need to change the default nexus data directory You need to adjust the "-Dkaraf.data" value .

Also I've notices that the service is not starting at all without any logging in case if it's not enough memory to start. So if default values of "-Xms" and "-Xmx" are too huge, you'd need to decrease them.

Below are the values I've used in my setup:
```
-Xms512m
-Xmx512m
-XX:MaxDirectMemorySize=512m
-XX:+UnlockDiagnosticVMOptions
-XX:+LogVMOutput
-XX:LogFile=../sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=etc/karaf/java.util.logging.properties
-Dkaraf.data=../sonatype-work/nexus3
-Dkaraf.log=../sonatype-work/nexus3/log
-Djava.io.tmpdir=../sonatype-work/nexus3/tmp
-Dkaraf.startLocalConsole=false
-Djdk.tls.ephemeralDHKeySize=2048
-Dinstall4j.pidDir=/opt/tmp
-Djava.endorsed.dirs=lib/endorsed
```

**7) Start the service**

You can configure the repository manager to run as a service with "init.d" or "systemd".

Both these methods you can find described at the following [page](https://help.sonatype.com/repomanager3/installation-and-upgrades/run-as-a-service).

In this guide we will use "update-rc.d" - a tool that targets the initscripts in "init.d" to run the nexus service.

Symlink "opt/nexus/bin/nexus" to "/etc/init.d/nexus":
```
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
```

Then activate the service
```
cd /etc/init.d
sudo update-rc.d nexus defaults
sudo service nexus start
```

**Note:** default settings of Port and Host values which nexus uses once the service is started can be found in "/opt/nexus/etc/nexus-default.properties":

![2](https://user-images.githubusercontent.com/74211642/203736167-f6d8c807-d046-46c7-854e-0e2ae687c8ec.png)

**Post install:** Login as admin to Nexus

To ensure the system begins with a secure state, Nexus Repository Manager generates a unique random password during the system's initial startup which it writes to the data directory (in our case it's "sonatype-work/nexus3") in a file called admin.password.

So you can use the value from this file:
```
sudo vi /opt/sonatype-work/nexus3/admin.password
```

And then go to http://your_host:8081/ in your browser to log in as "admin" user using the password from the file above.
</details>


<details> 
<summary><h4>Run Nexus as a Docker container</h4></summary>

## 

You can find instructions at:
[https://github.com/sonatype/docker-nexus3](https://github.com/sonatype/docker-nexus3)

Or create a docker-compose file similar to the following:
[link](docker-compose.yml)


Then run via the following commands:

```
docker-compose pull
docker-compose up -d
```

It can take some time (2-3 minutes) for the service to launch in a new container. 
You can the status using the following command  to determine once Nexus is ready:

```
docker-compose ps
```

If the status is not "running" then check the access settings for "nexus-data" volume directory by executing

```
ls -la
```

More information can be found here: [link](https://www.pluralsight.com/blog/it-ops/linux-file-permissions)

Change permissions settings for nexus-data directory if necessary:

```
sudo chmod 777 nexus-data
```


</details>

<details>
<summary><h4>Install Nexus instance within a Kubernetes cluster</h4></summary>

## Links to the Charts:

Official Helm chart:
[https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager)

Community Helm chart:
[https://artifacthub.io/packages/helm/stevehipwell/nexus3](https://artifacthub.io/packages/helm/stevehipwell/nexus3)
</details>


# Backup and restore (blob stores and database)

https://help.sonatype.com/repomanager3/planning-your-implementation/backup-and-restore


# Post-install steps

<details>
<summary><h4>Anonymous access & Local Authorizing Realm</h4></summary>

#
During initial configuration of Nexus repository you should remain the following checkbox and choose "Local Authorizing Realm" in the Realm dropdown:

![3](https://user-images.githubusercontent.com/74211642/203736295-ac3f1dd4-256e-45b1-8ed1-2de0ce41301d.png)

In case if you've missed this, you can find this setting in the [ 1) Admin panel -> 2) Anonymous access ] panel as shown below:

![4](https://user-images.githubusercontent.com/74211642/203736356-2eb3f22a-40db-4522-a2c6-d09fa849e36a.png)

Then go to [ 1) Admin panel -> 2) Realms ] and add Local Authorizing Realm to the active block.

</details>


<details> 
<summary><h4>Create Cleanup policies for each types of repo</h4></summary> 

#
1) Login to Nexus as Admin

2) Navigate to Admin panel at the very top of Nexus UI

![5](https://user-images.githubusercontent.com/74211642/203737149-ca507133-5918-49a3-a66f-fd3cccfbfaf7.png)

3) At the Repository section choose "Cleanup policies"

![6](https://user-images.githubusercontent.com/74211642/203737211-841bb524-c010-49e1-8809-fba0f98ed7d4.png)

4) Click at the "Create Cleanup Policy" button

The next steps (as an example) will be described for a maven type of repository:

![7](https://user-images.githubusercontent.com/74211642/203737286-bac848fc-aafc-48ee-b92f-940c233699cd.png)

**1)** Specify the name of cleanup policy --> **2)** Choose the type of repository (at the screenshot above it's maven2) --> **3)** Choose Cleanup criteria (at the screenshot above it's about to delete components that haven't been downloaded in 3 days)

These steps should be repeated for all the type of repositories for which you need to have a cleanup job configured.
In my case it's the following list: apt, conda, docker, helm, maven, npm, pypi

![8](https://user-images.githubusercontent.com/74211642/203737469-fbd79fd8-1a95-4b09-ab6f-ec51dfa73183.png)

</details>

<details>
<summary><h4>Setup cleanup tasks (!)</h4></summary>

#
1) Login to Nexus as Admin

2) Navigate to Admin panel at the very top of Nexus UI

![5](https://user-images.githubusercontent.com/74211642/203737149-ca507133-5918-49a3-a66f-fd3cccfbfaf7.png)

3) At the System section choose "Tasks"

![20](https://user-images.githubusercontent.com/74211642/203737906-ee7bf0d1-eb53-4fd0-830c-2284f225c731.png)

4) Click on "Create task" button

![21](https://user-images.githubusercontent.com/74211642/203738136-46640d20-9ae0-4683-b955-123cac93d175.png)

5) Choose **"Cleanup Service (Admin - Cleanup repositories using their associated policies)"**

This task will clean up all the items which are valid to be cleaned up according to the **cleanup policies** set up for each repository separately.

- define the name of the task

- define frequency of running (e.g. daily)

6) Choose **"Admin - Compact Blob Store"**

It's a kind of hard delete. Any clean up (task, or individual deletions) done via NXRM3 is soft deleted in case it's removed the wrong thing, you can restore. Compact blob store task finishes the job (removing all soft deleted items).

- define the name of the task

- choose the blobstore this task will be applied to

- define frequency of running (e.g. daily)

7) Choose **"Delete blob store temporary files"**

- define the name of the task

- choose the blobstore this task will be applied to

- define frequency of running (e.g. daily)

8) Choose **"Docker - delete incomplete upload tasks"**

- define the name of the task

- define "age in hours" value - incomplete docker uploads that are older than the specified age in hours will be deleted

- define frequency of running (e.g. daily)

9) Choose **"Docker - delete unused manifests and images"**

- define the name of the task

- provide the nexus repository name to clean up

- define "deploy offset in hours" value - Manifests and images deployed within this period before the task starts will not be deleted

- define frequency of running (e.g. daily)

</details>

<details>
<summary><h4>Setup Users and User roles for contributing</h4></summary>

#
Example will contain info about how to create **user role** and **user** that are able to download/upload artifacts to **Docker** Nexus repositories.

Login as Admin user -> Go to Admin Panel -> Expand "Security" section -> Choose "Roles" -> Click "Create Role"

Provide the ID and Name of User role, move the following Privileges from Active to Given section as at teh screenshot:

```
nx-repository-admin-docker-docker-group-*
nx-repository-admin-docker-docker-hosted-*
nx-repository-view-docker-docker-group-*
nx-repository-view-docker-docker-hosted-*
```

![18](https://user-images.githubusercontent.com/74211642/203738503-4b9bd1ed-74da-42da-8521-0831dfd1c1d1.png)

Click "Save" button.

Go to Admin Panel -> Expand "Security" section -> Choose "Users" -> Click "Create Local User"

Fill the form: 

ID: any description e.g. "docker-contributor"

First Name, Last Name, Email: any dummy values

Password: it will be used for authentication

Status: choose "active"

Roles: move previously created role (in my case it's "docker-contributor") from "Available" section to "Granted"

Save the user

![19](https://user-images.githubusercontent.com/74211642/203738769-e5236d6a-0889-4933-bf6c-1263615a1897.png)

</details>


# Setup Docker repositories

Nexus Repository Manager support Docker registries as the Docker repository format for hosted and proxy repositories. Official documentation from Sonatype on how to proxy Docker: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/proxy-repository-for-docker)

Prerequisite: Go to "server administration and configuration" section -> Choose "Security" -> "Realms" option on the left sidebar -> Add Docker Bearer Token Realm to the active block

<details>
<summary><h4>Setup Proxy Docker repository</h4></summary>

#
Go to "server administration and configuration" section -> Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen -> Choose "docker (proxy)" type

![9](https://user-images.githubusercontent.com/74211642/203739210-e7927164-4cda-4673-b299-80e825d91e94.png)

1) Provide the name of proxy

2) Check the "HTTP" checkbox and provide a Port value you may use for this repository (at the screenshot it's 8181)

3) Check "allow anonymous docker pull"

4) Provide the URL of the remote storage (for example, https://registry-1.docker.io). Note: each proxy repository can use only one remote storage

5) For the Docker index, select Use Docker Hub

6) Check "Allow Nexus Repository Manager to download and cache foreign layers" checkbox (info: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/foreign-layers)). Remain the regexp by default

7) Please don't forget to apply to the repository the cleanup policy which has been created at the [Post-Install steps] -> [Create Cleanup policies for each types of repo] section of this guide

![10](https://user-images.githubusercontent.com/74211642/203739321-f299e06f-32ed-416f-8305-819c1b335cd0.png)

</details>

<details>
<summary><h4>Setup Hosted Docker repository</h4></summary>

#
If you want to have an ability to push your own Docker images to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted Docker repository in Nexus is pretty similar to the Proxy Docker repository set up described above.

The differences are that:

1) When choosing the repository type to be created, choose "docker (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as at the [Post-Install steps] -> [Create Cleanup policies for each types of repo] section of this guide)

3) Don't forger to provide a HTTP connector at specified port as at the screenshot below. The port should be different from other HTTP connector ports specified for other created repos.

![11](https://user-images.githubusercontent.com/74211642/203739440-3ea5c732-332d-472e-b5f3-ba9cb7de2b2c.png)

Then you will be able to push your own images to such repository. 
Example of pushing to Docker hosted repo can be found at the **"Client configuration & How to use"** section below

</details>

<details>
<summary><h4>Setup Group Docker repository</h4></summary>

#
Several Docker repositories can be grouped in order to simplify access if you're going to use different remote repos at the same time.
For more details please refer to the [guide](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/grouping-docker-repositories) .

In our case, Nexus contains the Docker Group repository which includes all the Proxy Docker repos and Hosted Docker repo. 
So, accessing the only one HTTP connector of Group repository, we will be able to **download** any image from all these repos (please **note** that Nexus Repository OSS **does not support pushing** into a group repository, so only pulling from group repository is available. Explicit push to the hosted repository is described in the **"Client configuration & How to use"** section below):

![12](https://user-images.githubusercontent.com/74211642/203739670-68f46b50-bc81-4ef5-a639-82b9d60c7335.png)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

1) Go to /etc/docker/daemon.json and change it's content as follows:
```
{ "features" : { "buildkit": true},
"insecure-registries": ["nexus_address:http_connector_group_repo", "http://nexus_address:http_connector_group_repo", "nexus_address:http_connector_hosted_repo", "http://nexus_address:http_connector_hosted_repo"],
"registry-mirrors": ["http://nexus_address:http_connector_group_repo", "http://nexus_address:http_connector_hosted_repo"],
"debug": true
 }

```

for example, in my case it would be:

```
{ "features" : { "buildkit": true}, 
"insecure-registries": ["localhost:8183", "http://localhost:8183", "localhost:8182", "http://localhost:8182"], 
"registry-mirrors": ["http://localhost:8183", "http://localhost:8182"], 
"debug": true 
 }
```

2) Create a file /etc/default/docker and put the following line:

```
DOCKER_OPTS="--config-file=/etc/docker/daemon.json"
```

![13](https://user-images.githubusercontent.com/74211642/203739818-5e761286-6e4c-4571-8cda-f9f97ff3b87a.png)

3) Go to **~/.docker/config.json**. In case if it contains a record with docker.io, delete it (otherwise docker will work with docker hub instead of proxy)

4) Restart the docker service:

```
sudo systemctl restart docker
```

Run docker info command:

```
docker info
```

At the bottom you should see records similar to the following:

![14](https://user-images.githubusercontent.com/74211642/203763787-be8f39eb-080b-4172-9f4a-5b2f5cdf03a3.png)

Now if you run in your console:

```
docker pull
# or
docker push
```

your docker will point to the Nexus instance.

**Example of pushing** to Docker hosted repo:
General approach is described [here](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/pushing-images)

I've chose one of the available images for pushing:

![15](https://user-images.githubusercontent.com/74211642/203763859-950fb250-9c82-4246-9a59-ad41e0bbd61f.png)

Then made a tag:

![16](https://user-images.githubusercontent.com/74211642/203763954-4998617e-feb8-4298-93a9-29525b2c1ef9.png)

Then authenticated as "docker-contributer" user (password: 123123123) and pushed the image:

![17](https://user-images.githubusercontent.com/74211642/203763993-964db330-edf6-45ae-9e95-dddc35cd25fd.png)

</details>

# Setup Helm repositories

Official documentation from Sonatype on how to proxy Helm: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/helm-repositories)

<details>
<summary><h4>Setup Proxy Helm repository</h4></summary>

#
Note: each created repository can proxy only one remote repository.

The list of Helm repositories for proxying:

```
https://oxyno-zeta.github.io/helm-charts-v2/
https://argoproj.github.io/argo-helm/
https://charts.bitnami.com/bitnami
https://aws.github.io/eks-charts
https://charts.crossplane.io/stable
https://charts.bitnami.com/bitnami
https://dapr.github.io/helm-charts
```

In general proxy repository can be set up as follows:

![22](https://user-images.githubusercontent.com/74211642/203764074-92c7ad36-1c05-43fc-81cc-eed0885aedfe.png)

1) Go to "server administration and configuration" section

2) Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen

3) Choose "helm (proxy)" type

![23](https://user-images.githubusercontent.com/74211642/203764341-9795f4c9-ca66-4a96-bf4d-42102d4e9498.png)

1) Provide the name of proxy

2) Provide the URL of the remote storage (for example,  https://kubernetes-charts.storage.googleapis.com/ )

3) (Optional, can be remained by default) Choose a blob store for the repository if you need to separate it from the default one.

4) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

![24](https://user-images.githubusercontent.com/74211642/203764410-dc04d4c6-b437-489b-8e44-10e0b309611b.png)

As a result, repository like this should appear:

![25](https://user-images.githubusercontent.com/74211642/203764475-b1dfa487-b84b-43a2-965b-1c7f11c228f4.png)

</details>

<details>
<summary><h4>Setup Hosted Helm repository</h4></summary>

#

If you want to have an ability to push your own Helm charts to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted Helm repository in Nexus is pretty similar to the **Proxy Helm repository** creation.

The differences are that:

1) When choosing the repository type to be created, choose "helm (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as above in the **cleanup policies setup** section)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

### **How to fetch Helm charts from helm-proxy repo**

Once you have Helm up and running you'll want to run a command similar to the following to add a Helm repo:
```
helm repo add <helm_repository_name> http://<host>:<port>/repository/<nexus_repository_name>/ --username <username> --password <password>
```

The below command will fetch the latest chart or with the version:
```
1. helm fetch <helm_repository_name>/<chart_name>
2. helm fetch <helm_repository_name>/<chart_name> --version <chart_version>
```

For example, Nexus Repository has a Helm proxy repository called **helm-proxy** and your Nexus Repository is running on localhost:8081 where username is admin and password is admin. 
You would like to add this repository to Helm client. Also, you would like to fetch the latest MySQL chart. To accomplish this, you would do the following:
```
1. helm repo add nexusrepo http://localhost:8081/repository/helm-proxy/ --username admin --password admin
2. helm fetch nexusrepo/mysql
```

If you want to fetch a chart with a specific version, just run it, like so:
```
helm fetch nexusrepo/mysql --version 1.4.0
```

---
### **How to push Helm charts to the helm-hosted repo**

![26](https://user-images.githubusercontent.com/74211642/203764593-35fba3b3-2b69-4dfa-a3ed-5d1f6a4c3c90.png)

1) I've created test chart

2) I've checked that chart directory has been created with default content

3) Made an archive out of the chart

Then, using "helm-contributor" user with "123123123" password we can push the chart to the helm-hosted repo.
The following command should be used:

```
curl -X 'POST' \
  'http://localhost:8082/service/rest/v1/components?repository=helm-hosted' \
  -u 'helm-contributor:123123123' \
  -H 'accept: application/json' \
  -H 'Content-Type: multipart/form-data' \
  -F 'helm.asset=@test_chart-0.1.0.tgz;type=application/x-compressed-tar'
```
</details>

# Setup Maven repositories

Official documentation from Sonatype on how to proxy Maven dependencies: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/maven-repositories)

<details>
<summary><h4>Setup Proxy Maven repository</h4></summary>

#

Note: Nexus has a set of Maven repositories (proxy, hosted and group types) installed by default from the box.

![27](https://user-images.githubusercontent.com/74211642/203764657-ce64bff9-8eb4-4c89-a6ae-70c6fcca70d2.png)

```
http://localhost:8082/repository/maven-central/ - proxy for https://repo1.maven.org/maven2/
http://localhost:8082/repository/maven-snapshots/ - hosted repository for custom dependencies storage
http://localhost:8082/repository/maven-releases/ - hosted repository for custom dependencies storage
http://localhost:8082/repository/maven-public/ - group repository, includes all three above repos
```

In most cases it would be enough and you can use them to proxy your dependencies, there is no need to create a separate proxy. But in case if you need this, you can go ahead with the following steps.

![28](https://user-images.githubusercontent.com/74211642/203764714-588b1678-2b6e-49fa-ae5d-7ebd94aeb0f4.png)

1) Go to "server administration and configuration" section

2) Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen

3) Choose "maven (proxy)" type

![29](https://user-images.githubusercontent.com/74211642/203764767-7e0dcee0-26c9-401a-a5c5-38b70d00c6ec.png)

1) Provide the name of proxy

2) Provide the URL of the remote storage (for example, https://repo1.maven.org/maven2/). Note: each proxy repository can use only one remote storage

3) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

![30](https://user-images.githubusercontent.com/74211642/203764848-db7adf5c-dac8-4ae5-958d-3a3b22405952.png)

As a result, repository like this should appear:

![31](https://user-images.githubusercontent.com/74211642/203764913-d3e9ca14-bced-4b45-b3ac-51805137f092.png)

</details>

<details>
<summary><h4>Setup Hosted Maven repository</h4></summary>

#

If you want to have an ability to push your own Maven dependencies to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted Maven repository in Nexus is pretty similar to the **Proxy Maven** repository creation.

The differences are that:

1) When choosing the repository type to be created, choose "maven (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as above at the **cleanup policies setup** section of this guide))

</details>

<details>
<summary><h4>Setup Group Maven repository</h4></summary>

#

Several Maven repositories can be grouped in order to simplify access if you're going to use different remote repositories at the same time.
For more details please refer to the [guide](https://help.sonatype.com/repomanager3/nexus-repository-administration/repository-management) on repository types (group repository section).

For example, you can group both **Maven Proxy** and **Maven Hosted** repositories in the same **Maven Group** Repo:

![32](https://user-images.githubusercontent.com/74211642/203766754-3fc100e3-0957-43a5-8596-91224b67ac67.png)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

1) In your ~/.m2/ directory create a settings.xml file and fill it with the following data (in case if it already exists, override it's content):

```
<settings>
  <mirrors>
	<mirror>
  	<!--This sends everything else to /public -->
  	<id>nexus</id>
  	<mirrorOf>external:*</mirrorOf>
	<url>http://localhost:8082/repository/maven-public/</url>
	</mirror>
  </mirrors>
</settings>
```

Now, every maven command will use the mirror identified in user's settings.xml and only after that settings from pom will be picked up. There's no need to include the path of settings.xml in the maven command after -s flag. Maven will automatically check for settings in .m2 directory.

More documentation about mirror settings can be found in the mini guide on the [Maven web site](http://maven.apache.org/guides/mini/guide-mirror-settings.html).

Now, in order to check that the setting works well, you can go to directory that contain pom.xml and execute mvn package:
```
cd /...

mvn package
```

The log shown in terminal may contain URL address of specified proxy.

In case if you want to, you can explicitly define the path for settings.xml configuration file inside the maven command (-s flag) as shown below:

```
mvn -B -s $settings_xml_path -Dmaven.repo.local=$maven_repo_path install
```

</details>

# Setup Conda repositories

Official documentation from Sonatype on how to proxy Conda dependencies: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/conda-repositories)

<details>
<summary><h4>Setup Proxy Conda repository</h4></summary>

#

Note: each proxy repository can use only one remote storage (channel)

Our project is correctly using Conda Proxy repositories for the following channels:

```python
https://conda.anaconda.org/conda-forge/
https://conda.anaconda.org/anaconda/
```

For both channels setup is similar and should be done as follows:

![33](https://user-images.githubusercontent.com/74211642/203766876-2b2d46e1-35f2-45eb-803a-4ed9a3fcabd7.png)

1) Go to "server administration and configuration" section

2) Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen

3) Choose "conda (proxy)" type

![34](https://user-images.githubusercontent.com/74211642/203766899-4187f9d7-3962-4599-8357-b4d20196496f.png)

1) Provide the name of proxy (if you are proxying a common channel, e.g. conda-forge, try to use the same name)

2) Provide the URL of remote storage (in case of conda-forge channel it's https://conda.anaconda.org/conda-forge/)

3) (Optional, can be remained by default) Choose a blob store for the repository if you need to separate it from the default one.

4) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

![35](https://user-images.githubusercontent.com/74211642/203766937-e0608ea9-a342-4a4e-9192-e5a7cdb7959b.png)

As a result, repository like this should appear:

![36](https://user-images.githubusercontent.com/74211642/203767057-03f1b124-92ef-48dd-952d-c9e3f976e478.png)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

One of the options is to use repository URL directly in the conda (or miniconda, or micromamba) command, for example the following command:

```
micromamba install -c http://localhost:8082/repository/conda-forge/ numpy
```

downloads numpy package from conda-forge remote repository through our proxy repository.

Content of the -c flag represents URL to the Nexus repository.

The better way would be to use .condarc configuration file (more details on how to use .condarc file can be found [here](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html))

1) Create ~/.condarc file under your user's home directory and fill it with the content similar to the following:

```
channel_alias: http://localhost:8082/repository/
```

This alias means, that every conda command, which is including channel with *channel_name*, will be actually referring to http://localhost:8082/repository/channel_name

**Note** that currently we have proxy repositories for *conda-forge* and *anaconda* channels only:

```
https://conda.anaconda.org/conda-forge/
https://conda.anaconda.org/anaconda/
```

So the command structure like in example below is valid (we can use these two channels without explicit mention of proxy url):

```
conda install pip -c conda-forge
```
</details>

# Setup Npm repositories

Official documentation from Sonatype on how to proxy npm dependencies: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/npm-registry)

<details>
<summary><h4>Setup Proxy Npm repository</h4></summary>

#

Note: each proxy repository can use only one remote storage

We will setup a proxy for the following remote storage:

```python
https://registry.npmjs.org/
```

For any other proxies the setup is similar and can be done as follows:

Go to "server administration and configuration" section -> Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen -> Choose "npm (proxy)" type

![37](https://user-images.githubusercontent.com/74211642/203767181-607fd658-68a1-4d8d-b10a-3aead46e7ed8.png)

1) Provide the name of proxy

2) Provide the URL of the remote storage (for example, https://registry.npmjs.org/)

3) (Optional, can be remained by default) Choose a blob store for the repository if you need to separate it from the default one.

4) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

![38](https://user-images.githubusercontent.com/74211642/203767206-0d15e5cb-5eda-4952-84e0-e54bcf5d3abd.png)

As a result, repository like this should appear:

![39](https://user-images.githubusercontent.com/74211642/203767233-8853cb0a-235c-4dcc-91d2-c39c5d9a4390.png)

</details>

<details>
<summary><h4>Setup Hosted Npm repository</h4></summary>

#

If you want to have an ability to push your own Npm dependencies to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted Npm repository in Nexus is pretty similar to the **Proxy Npm repository** creation.

The differences are that:

1) When choosing the repository type to be created, choose "npm (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as above in the **cleanup policies setup** section of this guide)

</details>

<details>
<summary><h4>Setup Group Npm repository</h4></summary>

#

Several npm repositories can be grouped in order to simplify access if you're going to use different remote storages at the same time.
For more details please refer to the [guide](https://help.sonatype.com/repomanager3/nexus-repository-administration/repository-management) on repository types (group repository section).

For example, in our case we can join **Proxy** and **Hosted** repositories in the same group:

![40](https://user-images.githubusercontent.com/74211642/203767326-035777c5-15a8-46fc-89fc-b17ad9ebe936.png)

</details>

<details>
<summary><h4>Nginx configuration to redirect npm audit</h4></summary>

#

![41](https://user-images.githubusercontent.com/74211642/203767349-f177fb64-6d54-4628-ada4-cfeabb9e874e.png)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

One of the options is to use repository URL directly in he npm command as follows:

```
npm --registry http://localhost:8082/repository/npm/ install yarn   
```

This command will download yarn package from the https://registry.npmjs.org/ remote repository and it will be cached in our proxy repository which URL was placed under --registry flag.

Also registry can be configured in the .npmrc configuration file (for more detail please refer to the following [guide](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/npm-registry/configuring-npm)):

1) Create ~/.npmrc file uder your user's home directory and fill it with the content similar to the following:

```
registry=http://localhost:8082/repository/npm-group/
_auth=YWRtaW46bmV4dXM=

```

Try the following commands to ensure that npm refers to the proxy:

```
npm install express --loglevel verbose
npm install yarn --loglevel verbose
```

---
</details>

# Setup Pypi repositories

Official documentation from Sonatype on how to proxy PyPi dependencies: [link](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/pypi-repositories)

<details>
<summary><h4>Setup Proxy Pypi repository</h4></summary>

#

Go to "server administration and configuration" section -> Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen -> Choose "pypi (proxy)" type

![42](https://user-images.githubusercontent.com/74211642/203767456-22491d88-6b9e-47e4-b78a-36483d63e167.png)

1) Provide the name of proxy

2) Provide the URL of the remote storage (for PyPi the most common is https://pypi.org/). Note: each proxy repository can use only one remote storage

3) Change the blobstore if needed (or keep default)

4) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

![43](https://user-images.githubusercontent.com/74211642/203767486-c8ced598-4196-42f5-9d2c-fe8663a9bdc7.png)

As a result, repository like this should appear:

![44](https://user-images.githubusercontent.com/74211642/203767505-a8143bee-7f09-45b1-b695-5dbdc1bc9810.png)

</details>

<details>
<summary><h4>Setup Hosted Pypi repository</h4></summary>

#

If you want to have an ability to push your own PyPi artifacts to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted PyPi repository in Nexus is pretty similar to the **Proxy PyPi repository** creation.

The differences are that:

1) When choosing the repository type to be created, choose "pypi (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as above in the **cleanup policies** section of this guide)

</details>

<details>
<summary><h4>Setup Group Pypi repository</h4></summary>

#

Several PyPi repositories can be grouped in order to simplify access if you're going to use different remote storages at the same time.
For more details please refer to the [guide](https://help.sonatype.com/repomanager3/nexus-repository-administration/repository-management) on repository types (group repository section).

In our own configuration, I've created a proxy to https://pypi.org/, then hosted repository for our own artifacts and then grouped them both under group repository. Now, we can access group repository in order to manage artifacts in both proxy and hosted repos.

![45](https://user-images.githubusercontent.com/74211642/203767644-7cd6423d-155c-4f04-8ff5-508b1025a9b8.png)

</details>

<details>
<summary><h4>Client configuration & How to use</h4></summary>

#

## pip.conf ##

If you are going to use pip to download pip dependencies, create a pip.conf file:

1) Create a new file under your home directory **~/.config/pip/pip.conf** with the following content:
```
[global]
index-url = http://localhost:8082/repository/pypi-group/simple
trusted-host = localhost
```

Note that *http://localhost:8082/repository/pypi-group/* - is URL for my group repository which contains proxy repository for https://pypi.org/

But don't forget to add **/simple** postfix to the end of index-url

Then you can use a command like the following one to ensure that setting is working fine - log should contain URL of the proxy:
```
pip install twine 
```
---

## .pypirc ##

Note that pip doesn't use **.pypirc** at all. **.pypirc** is only used by tools that publish packages to an index (for example, twine) and pip doesn't publish packages.

If you want to upload a package to a hosted repository using twine, you would need to configure a .pypirc file:

1) Create a .pypirc file under your user's home directory **~/.pypirc** with the following content:

```
[distutils]
index-servers =
    pypi

[pypi]
repository = http://localhost:8082/repository/pypi-group/simple
```

</details>

# Apt repositories for Debian


<details> 
<summary><h4>Setup Proxy Apt repository</h4></summary>

#

Go to "server administration and configuration" section -> Choose "repositories" option on the left sidebar, then click "create repository" button at the very top of the screen -> Choose "apt (proxy)" type


1) Provide the name of proxy

2) Provide the URL of the remote storage (for Debian the most common is **http://deb.debian.org/debian**; note that you will need to add a separate proxy for security: **http://security.debian.org/debian-security**). Note: each proxy repository can use only one remote storage

3) Change the blobstore if needed (or keep default)

4) Please don't forget to apply to the repository the cleanup policy which has been created at the **cleanup policies section** of this guide

</details>


<details> 
<summary><h4>Setup Hosted Apt repository</h4></summary>

#

If you want to have an ability to push your own Apt artifacts to the Nexus, you would need to have Hosted Repository set up.

The creation of Hosted Apt repository in Nexus is pretty similar to the **Proxy Apt repository** creation.

The differences are that:

1) When choosing the repository type to be created, choose "apt (hosted)"

2) Provide a name of repository, choose the blobstore (or remain it default) and apply a cleanup policy if needed (it should be set up as above in the **cleanup policies** section of this guide)


</details>

<details> 
<summary><h4>Client configuration & How to use</h4></summary>

#

In your /etc/apt/ folder create a /etc/apt/sources.list config file with the following content: 

```
deb http://localhost:8082/repository/deb.debian.org_debian/ bullseye main
deb http://localhost:8082/repository/security.debian.org_debian-security/ bullseye-security main
deb http://localhost:8082/repository/deb.debian.org_debian/ bullseye-updates main
```

Where **localhost:8082** is address and port of your Nexus instance, 

**deb.debian.org_debian** and **security.debian.org_debian-security** are names of proxy repositories created for **http://deb.debian.org/debian** and **http://security.debian.org/debian-security** respectively

</details>


# How to configure S3 Blobstore in Nexus

<details>
<summary><h4>Setup a S3 blobstore in Nexus</h4></summary>

#

![47](https://user-images.githubusercontent.com/74211642/203768029-ec5a83ad-ed9b-4bf5-9657-17aea7ee7a8b.png)

1) Go to "server administration and configuration" section

2) Choose "blob store" option on the left sidebar

3) Click "create blob store" button

![48](https://user-images.githubusercontent.com/74211642/203768046-1a1004e1-9ed9-4b58-962b-2a0c3a0627c8.png)


Expand Authentication and Advanced Connection Settings and fill as follows:

Type: S3

Name: Enter a name (e.g. test-blobstore)

Region: Choose us-east-1

Bucket: Enter the name of the bucket you created in Minio or AWS

Access Key ID: Enter the access key id you provided to Minio (e.g. "mykey")

Secret Access Key: Enter the secret access key you provided to Minio (e.g. "mysecret")

Session Token: leave blank

Assume Role ARN: leave blank

Endpoint URL: Enter the Minio API URL (e.g. http://127.0.0.1:9000) or any other

Expiration Days: Enter -1

Signature version: Leave as default
</details>
