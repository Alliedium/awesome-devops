# Devspace, Part 3

In this lecture we get started with `DevSpace`, which is an open-source developer tool for Kubernetes that lets you develop and deploy cloud-native software. We are talked about possibilities that gives `DevSpace` and generated first devspace.yaml for devspace-example-python project. The main components of the deployment manifest are discussed.

## Prerequisites

1. `Manjaro` Linux is installed
2. `K3D` is installed
3. `OpenLens` is installed
4. `DevSpace` is installed

# Devspace python example 01
Clone the project    
```shell
git clone https://github.com/loft-sh/devspace-example-python.git
```
Go to repository with the first example:      
```shell
cd $HOME/devspace-example-python/01-simple
```

### Start application with `devspace`
1. Create cluster:
```shell
k3d cluster create ds-quick0 --registry-create ds-reg:23456
```    
2. Make following changes in `devspace.yaml`:
- Add 2 variables `REGISTRY=127.0.0.1:23456` and `INTERNAL_REGISTRY: ds-reg:5000`, to access created registry from outside and inside the cluster, respectively
```shell
sed -i "s/DEVSPACE_FLAGS: \"-n python-hello-devspace\"/DEVSPACE_FLAGS: \"-n python-hello-devspace\"\n  REGISTRY: 127.0.0.1:23456\n  INTERNAL_REGISTRY: ds-reg:5000/" devspace.yaml
```   
- Add registry tag `latest`:
```shell
sed -i "s/rebuildStrategy: ignoreContextChanges/rebuildStrategy: ignoreContextChanges\n    tags:\n      - latest/" devspace.yaml 
```   
- Replace value of `image` in section `images`
```shell
sed -i "s/image: \${IMAGE}/image: \${REGISTRY}\/\${IMAGE}/" devspace.yaml
```
- Replace value of `imageSelector` in section `
```shell
sed -i "s/imageSelector: \${IMAGE}/imageSelector: \${INTERNAL_REGISTRY}\/\${IMAGE}/" devspace.yaml
``` 
3. Change link to the registry in the file `./manifests/deployment.yaml`:
```shell
sed -i "s/172.31.254.11/ds-reg:5000/" ./manifests/deployment.yaml
```
4. Do deploy:
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

7. Change message `Hello, World!` to the `Hello, DevSpace2!` in the file `./app/main.py`.    
```shell
sed -i "s/World/DevSpace2/" ./app/main.py  
```
8. Go back to the browser and refresh the page. See new message `Hello, DevSpace2!`     

##  Example `02-fastapi-tortoise`
1. Go to repository with the second example:
```shell
cd $HOME/devspace-example-python/02-fastapi-tortoise
```
2. Fix versions in file with requirements `./backend/pyproject.toml`
```shell
sed -i "s/fastapi>=0\.83\.0,<1\.0\.0/fastapi==0\.83\.0/" ./backend/pyproject.toml
```s
sed -i "s/tortoise-orm\[asyncpg\]>=0\.19\.2,<1\.0\.0/tortoise-orm[asyncpg]==0\.19\.2/" ./backend/pyproject.toml
```
3. In the file `./devspace.yaml` do the following changes:
- Add variables:   
```yaml
vars:
  REGISTRY: 127.0.0.1:12345
  INT_REGISTRY: ds-reg:5000
```
  via command:   
```shell
  sed -i "s/REGISTRY: 172.31.254.11/  REGISTRY: 127.0.0.1:12345\n  INT_REGISTRY: ds-reg:5000/" ./devspace.yaml
```
- Change variables values in the file `./devspace.yaml`:    
```shell
sed -i "s/\${REGISTRY}\/python-simple-project-db/python-simple-project-db/" ./devspace.yaml
```
```shell
sed -i "s/\${REGISTRY}\/python-simple-project-backend/python-simple-project-backend/" ./devspace.yaml
``` 
- Replace paths to the images:    
```shell
sed -i "s/image: \${DATABASE_IMAGE}/image: \${REGISTRY}\/\${DATABASE_IMAGE}/" ./devspace.yaml
```
```shell
sed -i "s/image: \${BACKEND_IMAGE}/image: \${REGISTRY}\/\${BACKEND_IMAGE}/" ./devspace.yaml
```
```shell
sed -i "s/imageSelector: \${BACKEND_IMAGE}/imageSelector: \${INT_REGISTRY}\/\${BACKEND_IMAGE}/" ./devspace.yaml
```
- Add tag `latest`:   
```shell
sed -i "s/rebuildStrategy: ignoreContextChanges/rebuildStrategy: ignoreContextChanges\n    tags:\n      - latest/" ./devspace.yaml
```
4. Change image addresses for database and backend in `./manifests/deployment.yaml`:       
```shell
sed -i "s/172.31.254.11/ds-reg:5000/" ./manifests/deployment.yaml
```
5. Go to the browser and open page `http://127.0.0.1:3000/people/1`

6. View kube services are running in namespace `python-fastapi-tortoise` or go to the `OpenLens` to view more details
```shell
kubectl get service -n python-fastapi-tortoise
```
7. Clean devspace
```shell
devspace purge
```
87. Run development without services using profile named `dev`:
```shell
devspace dev -p dev
```
View there is no running kube services in namespace `python-fastapi-tortoise` or go to the `OpenLens` to view more details
```shell
kubectl get service -n python-fastapi-tortoise
```

## Clean your system   

1. Clean `devspace`
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
2. [Asynchronous Server Gateway Interface](https://asgi.readthedocs.io/en/latest/)
3. [Uvicorn - An ASGI web server, for Python.](https://www.uvicorn.org/)
4. [Devspace example python](https://github.com/loft-sh/devspace-example-python.git)
5. [Develop environments using Nix](https://devenv.sh/)