## Nexus intro and basic config part 3

Awesome Nexus configuration guide is available here: [awesome-nexus](https://github.com/Alliedium/awesome-nexus)

Covered topics:

### [Maven section](https://github.com/Alliedium/awesome-nexus#setup-maven-repositories)
* Which Maven repositories Nexus has installed out of the box
* How to setup any type of Maven repository if any additional needed
* What is Maven used for and where can we place settings (`settings.xml`, `pom.xml`) in order to configure whole Maven tool or particular project
* Examples of [pulling/pushing](https://github.com/Alliedium/awesome-nexus#client-configuration--how-to-use-2)
* How to configure Gradle to use Maven Nexus repositories (with examples)

### [Conda section](https://github.com/Alliedium/awesome-nexus#setup-conda-repositories)
* How to setup properly Conda Proxy repository in Nexus and what it is used for
* How to work with Conda-based tools (for example, micromamba)
* What is Conda environment
* How to configure Conda to use Nexus proxy with [examples](https://github.com/Alliedium/awesome-nexus#client-configuration--how-to-use-3) of pulling

### [npm section](https://github.com/Alliedium/awesome-nexus#setup-npm-repositories)
* How to setup npm Proxy, npm Hosted and npm Group repositories in Nexus
* How to configure npm to use Nexus repositories (including [authentication for pushing](https://github.com/Alliedium/awesome-nexus#security)) with [examples of pulling and pushing](https://github.com/Alliedium/awesome-nexus#example-of-pulling)
* How to [workaround npm audit calls](https://github.com/Alliedium/awesome-nexus#nginx-configuration-to-redirect-npm-audit)


### [Pypi section](https://github.com/Alliedium/awesome-nexus#setup-pypi-repositories)
* How to setup Pypi Proxy, Pypi Hosted and npm Pypi repositories in Nexus 
* How to [configure](https://github.com/Alliedium/awesome-nexus#client-configuration--how-to-use-5) pip (and other tools e.g. twine) to use Nexus
* [How to package Python project](https://packaging.python.org/en/latest/tutorials/packaging-projects/) before pushing
* [What Poetry is used for and how to configure it](https://habr.com/ru/post/593529/)

### What [Realworld](https://github.com/gothinkster/realworld) projects are used for

### [Apt section](https://github.com/Alliedium/awesome-nexus#apt-repositories-for-debian)
* How to setup Apt Proxy and Apt Hosted repositories in Nexus
* How to [configure](https://github.com/Alliedium/awesome-nexus#client-configuration--how-to-use-6) client side to use Apt repositories from Nexus

### [How to add Ansible format to list of supported formats in Nexus](https://github.com/l3ender/nexus-repository-ansiblegalaxy)

### [How to add S3 blobstore to Nexus](https://github.com/Alliedium/awesome-nexus#how-to-configure-s3-blobstore-in-nexus)


## Links for reference:


* [Poetry guide on Habr](https://habr.com/ru/post/593529/)
* [The easiest way to publish a python package on PyPI using Poetry](https://www.earthinversion.com/utilities/easiest-way-to-publish-a-python-package-using-poetry/)
* [Conda vs Pip](https://www.askpython.com/python/conda-vs-pip)
* [Conda vs Pip v.2](https://pythonspeed.com/articles/conda-vs-pip/)
* [Understand Conda and Pip](https://medium.com/analytics-vidhya/understand-conda-and-pip-9e5c67da47cc)
* [What is the function of /etc/apt/sources.list.d?](https://stackoverflow.com/questions/26020917/what-is-the-function-of-etc-apt-sources-list-d/26021071#26021071)
* [Realworld- The mother of all demo apps](https://codebase.show/projects/realworld)
* [Realworld on Github](https://github.com/gothinkster/realworld)