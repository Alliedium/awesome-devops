# Devspace, Part 2

The `DevSpace lecture` covers the following topics:
-    Installing and using the `micromamba` environment.      
-    Running an HTTP web server called `uvicorn` along with `FastAPI`, a modern web framework for building APIs.     
-    Utilizing the `loft-sh/devspace-example-python `project as an illustrative example.      
In this lecture, attendees will learn how to set up a development environment, run a powerful web server, and leverage a real-world project to gain practical insights into the concepts covered.      

## Prerequisites

1. `Manjaro` Linux is installed. Follow [instructions](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro) to install manjaro.
2. `K3D` is installed. `K3D` is already installed if you used scripts from the previous link.
3. `OpenLens` is installed. View [instructions](https://github.com/MuhammedKalkan/OpenLens) to install.
4. `DevSpace` is installed. Follow the [instructions](https://www.devspace.sh/docs/getting-started/installation?x0=5) to install.
5. `micromamba` is installed. `micromamba` is already installed if you used scripts from p. 1.

# Devspace python example 01
Clone the project    
```shell
git clone https://github.com/loft-sh/devspace-example-python.git $HOME/devspace-example-python
```
Go to repository with the first example:      
```shell
cd $HOME/devspace-example-python/01-simple
```
### Start application locally
1. Create and activate micromamba environment with name `01-simple` to set project dependencies. View environment `01-simple` appears in the list:

```shell
micromamba create -n 01-simple
```
```shell
micromamba activate 01-simple
```
```shell
micromamba env list 
```
2. Install `pip` packet manager
```shell
micromamba install pip -c conda-forge
```
View installed dependencies
```shell
micromamba list
```
3. Install `pip` dependencies indicated in the file `requirements.txt`
```shell
pip install -r ./requirements.txt
```     
View installed pip packages: 
```shell
pip list
```    
4. Run application using command from the `Dockerfile`.       
View Dockerfile
```shell
cat ./Dockerfile
```     
5. Run command:
```shell
uvicorn app.main:app --host 0.0.0.0 --port 8081
```     
6. Navigate to the URL `http://0.0.0.0:8081` via browser to check application is working now.     

### Start application with `devspace`
1. Create cluster:
```shell
k3d cluster create ds-quick0 --registry-create ds-quick-registry:23456
```    
2. Add registry tag `latest` in the file `devspace.yaml`:   
```shell
sed -i "s/rebuildStrategy: ignoreContextChanges/rebuildStrategy: ignoreContextChanges\n    tags:\n      - latest/" devspace.yaml 
```    
```shell
devspace deploy
```     
Set current namespace to the automatically created by devspace according to the `devspace.yaml`:
```shell
kubectl ns python-hello-devspace
```     
3. Replace IP in with `127.0.0.1:NodePort` `./manifests/deployment.yaml`
```shell
sed -ri "s/([0-9]{1,3}\.){3}[0-9]{1,3}(|:[0-9]{1,5})/127.0.0.1:$(kubectl get svc -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}')/" ./manifests/deployment.yaml
```     
To check whether the replacement was done correctly you may go to the `OpenLens` or use the following command:
```shell
kubectl get svc --all-namespaces
```    
4. Repeat deploy:
```shell
devspace deploy
```
Watch pods are running via command or via `OpenLens`
```shell
kubectl get pods
```     
5. Run dev    
```shell
devspace dev
```    
Watch new pod started for development via command or via `OpenLens`     
```shell
kubectl get pods
```     
6. Open the browser and go to the app page. See `Hello, World!` message     
`http://127.0.0.1:3000/`    

7. Change message `Hello, World!` to the `Hello, DevSpace!` in the file `./app/main.py`.    
```shell
sed -i "s/World/DevSpace/" ./app/main.py  
```
8. Go back to the browser and refresh the page. See new message `Hello, DevSpace!`     
9. Go to the `devspace` ui     
```shell
devspace ui
```

## Clean your system   

1. Clean devspace
```shell
devspace purge
```
2. Clean the registry
```shell
devspace cleanup local-registry
```
3. Delete cluster
```shell
k3d cluster delete ds0
```
4. Deactivate and remove micromamba environment
```shell
micromamba deactivate 01-simple
```
```shell
micromamba env remove -n 01-simple
```

## References
1. [Node port](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)
2. [Micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
3. [Asynchronous Server Gateway Interface](https://asgi.readthedocs.io/en/latest/)
4. [Uvicorn - An ASGI web server, for Python.](https://www.uvicorn.org/)
5. [Devspace example python](https://github.com/loft-sh/devspace-example-python.git)