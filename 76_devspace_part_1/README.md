# Devspace, Part 1

In this lecture we get started with `DevSpace`, which is an open-source developer tool for Kubernetes that lets you develop and deploy cloud-native software. We are talked about possibilities that gives `DevSpace` and generated first devspace.yaml for quickstart-python project. The main components of the deployment manifest are discussed.  

## Prerequisites

1. `Manjaro` Linux is installed   
2. `K3D` is installed    
3. `OpenLens` is installed    
4. `DevSpace` is installed    
5. `micromamba` is installed     

## `DevSpace` Quick start
1. Clone project and go to the project directory    
```shell
git clone https://github.com/loft-sh/devspace-quickstart-python.git
```
```shell
cd ./devspace-quickstart-python
```
2. Create micromamba environment and activate it    
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
and follow the instructions from :
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

1. [devspace](https://devspace.sh)
2. [skaffold](https://skaffold.dev/)
3. [Tilt](https://tilt.dev/)
4. [Comparison of instruments](https://loft.sh/blog/skaffold-vs-tilt-vs-devspace/)
5. [Micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
6. [Quickstart example](https://github.com/loft-sh/devspace-quickstart-python.git)
