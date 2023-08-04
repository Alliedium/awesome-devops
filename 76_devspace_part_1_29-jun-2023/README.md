# Devspace, Part 1
The lecture on DevSpace covers the following topics:

1. **DevSpace Introduction:**      
This section serves as an introduction to `DevSpace`, a tool designed to simplify and enhance the development workflow for `Kubernetes` applications. It provides an overview of its features and benefits.       
2. **Starting with a [loft-sh/devspace-quickstart-python](https://github.com/loft-sh/devspace-quickstart-python) Project:**      
In this part of the lecture, learners will be guided on how to initiate a new project using the `loft-sh/devspace-quickstart-python` template. This template helps set up a Python project with `DevSpace`, making it easier to get started with development.       
3. **DevSpace Deploy, Dev, and Purge Commands:**     
This section focuses on three crucial `DevSpace` commands - `devspace deploy`, `devspace dev`, and `devspace purge`. These commands are essential for deploying, developing, and cleaning up resources in the Kubernetes cluster. Learners will gain hands-on experience with these commands during the lecture.       

Overall, the lecture provides a comprehensive introduction to DevSpace and its benefits, guides learners through setting up a Python project with DevSpace, covers various package managers used in Python development, and explores basic DevSpace commands that streamline Kubernetes application development.       
As an example we used the project [loft-sh/devspace-quickstart-python project](https://github.com/loft-sh/devspace-quickstart-python)        

## Prerequisites

1. `Manjaro` Linux is installed. Follow [instructions](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro) to install manjaro.    
2. `K3D` is installed. `K3D` is already installed if you used scripts from the previous link, if it is not, follow the [instructions](https://k3d.io/v5.5.2/#install-current-latest-release)     
3. `OpenLens` is installed. View [instructions](https://github.com/MuhammedKalkan/OpenLens) to install.       
4. `DevSpace` is installed. Follow the [instructions](https://www.devspace.sh/docs/getting-started/installation?x0=5) to install.     
5. `micromamba` is installed. `micromamba` is already installed if you used scripts from p. 1. If micromamba is not installed, follow the [instructions](https://mamba.readthedocs.io/en/latest/installation.html) 

## `DevSpace` Quick start
1. Clone project and go to the project directory    
```shell 
git clone https://github.com/loft-sh/devspace-quickstart-python.git $HOME/devspace-quickstart-python
```
```shell
cd $HOME/devspace-quickstart-python
```
2. Create `micromamba` environment and activate it    
```shell 
micromamba create -n ds-quick python=3.8 -c conda-forge
```
```shell
micromamba activate ds-quick
```
4. Initialize `devspace` with the command
```shell
devspace init
```      
and follow the instructions from:
[Quick start project instructions](https://www.devspace.sh/docs/getting-started/initialize-project?x0=2)

5. Create cluster:
```shell
k3d cluster create ds-quick0 --registry-create ds-quick-registry:23456
```      
6. Set context for `devspace`. Select previously created cluster `k3d-ds-quick0`
```shell
devspace use context
```
7. Create namespace `python-quick0`    
```shell
kubectl create ns python-quick0
```
8. Set created namespace `python-quick0` as current    
```shell
devspace use namespace python-quick0
```
9. Deploy project
```shell
devspace deploy
```
10. Start project for development
```shell
devspace dev
```
11. Clean devspace
```shell
devspace purge
```

## Reference

1. [Devspace](https://devspace.sh)
2. [Skaffold](https://skaffold.dev/)
3. [Tilt](https://tilt.dev/)
4. [Comparison of instruments: Skaffold vs. Tilt vs. DevSpace](https://loft.sh/blog/skaffold-vs-tilt-vs-devspace/)
5. [Micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
6. [Quickstart example](https://github.com/loft-sh/devspace-quickstart-python.git)
7. [Devspace wizard instructions](https://www.devspace.sh/docs/getting-started/initialize-project?x0=2)
8. [loft-sh/devspace-example-python](https://github.com/loft-sh/devspace-example-python)
