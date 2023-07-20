# Devspace, Part 2

In this lecture we get started with `DevSpace`, which is an open-source developer tool for Kubernetes that lets you develop and deploy cloud-native software. We are talked about possibilities that gives `DevSpace` and generated first devspace.yaml for devspace-example-python project. The main components of the deployment manifest are discussed.

## Prerequisites

1. `Manjaro` Linux is installed
2. `K3D` is installed
3. `OpenLens` is installed
4. `DevSpace` is installed
5. `micromamba` is installed

# Devspace python example 01
Clone the project    
```shell
git clone https://github.com/loft-sh/devspace-example-python.git
```
Go to repository with the first example:      
```shell
cd $HOME/devspace-example-python/01-simple
```
### Start application with locally
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

### Start application with devspace
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
sed -i "s/172.31.254.11/127.0.0.1:$(kubectl get svc -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}')/" ./manifests/deployment.yaml
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
devspace destroy
```
2. Clean the registry
```shell
devspace cleanup local-registry
```
3. Delete cluster
```shell
k3d cluster delete ds0
```
4. Stop your docker containers and clean
 ```shell
docker stop $(docker ps -a -q)
```
```shell
docekr system prune -f -a
```
5. Deactivate and remove micromamba environment
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