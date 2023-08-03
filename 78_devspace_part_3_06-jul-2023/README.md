# Devspace, Part 3

In this DevSpace lecture, participants will explore running the `02-fastapi-tortoise` example project and an introduction to the `Nix` package manager. Attendees will learn how to run the `02-fastapi-tortoise` example project, which is built using `FastAPI` and `Tortoise ORM`. `FastAPI` is a modern `Python` web framework known for its speed and ease of use, while `Tortoise ORM` provides object-relational mapping for working with databases. `Nix` package manager, a powerful tool used for managing software packages and system environments. `Nix` adopts a functional approach, treating packages as immutable units with unique identifiers, ensuring reproducibility and avoiding dependency conflict.           

## Prerequisites

1. `Manjaro` Linux is installed. Follow [instructions](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro) to install manjaro
2. `K3D` is installed. `K3D` is already installed if you used scripts from the previous link, if it is not, follow the [instructions](https://k3d.io/v5.5.2/#install-current-latest-release)
3. `OpenLens` is installed. View [instructions](https://github.com/MuhammedKalkan/OpenLens) to install
4. `DevSpace` is installed. Follow the [instructions](https://www.devspace.sh/docs/getting-started/installation?x0=5) to install

# Devspace python example 01
Clone the project    
```shell
git clone https://github.com/loft-sh/devspace-example-python.git $HOME/devspace-example-python
```
Export env variable with the path:      
```shell
export WORK_PATH="$HOME/devspace-example-python/01-simple"
```

### Start application with `devspace`
1. Create cluster:
```shell
k3d cluster create ds-quick0 --registry-create ds-reg:23456
```    
2. Make following changes in `devspace.yaml`:
- Add 2 variables `REGISTRY=127.0.0.1:23456` and `INTERNAL_REGISTRY: ds-reg:5000`, to access created registry from outside and inside the cluster, respectively
```shell
sed -i "s/DEVSPACE_FLAGS: \"-n python-hello-devspace\"/DEVSPACE_FLAGS: \"-n python-hello-devspace\"\n  REGISTRY: 127.0.0.1:23456\n  INTERNAL_REGISTRY: ds-reg:5000/" $WORK_PATH/devspace.yaml
```   
- Add registry tag `latest`:
```shell
sed -i "s/rebuildStrategy: ignoreContextChanges/rebuildStrategy: ignoreContextChanges\n    tags:\n      - latest/" $WORK_PATH/devspace.yaml 
```   
- Replace value of `image` in section `images`
```shell
sed -i "s/image: \${IMAGE}/image: \${REGISTRY}\/\${IMAGE}/" $WORK_PATH/devspace.yaml
```
- Replace value of `imageSelector` in section `
```shell
sed -i "s/imageSelector: \${IMAGE}/imageSelector: \${INTERNAL_REGISTRY}\/\${IMAGE}/" $WORK_PATH/devspace.yaml
``` 
3. Change link to the registry in the file `$WORK_PATH/manifests/deployment.yaml`:
```shell
sed -ri "s/([0-9]{1,3}\.){3}[0-9]{1,3}(|:[0-9]{1,5})/ds-reg:5000/" $WORK_PATH/manifests/deployment.yaml
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

7. Change message `Hello, World!` to the `Hello, DevSpace2!` in the file `$WORK_PATH/app/main.py`.    
```shell
sed -i "s/World/DevSpace2/" $WORK_PATH/app/main.py  
```
8. Go back to the browser and refresh the page. See new message `Hello, DevSpace2!`     
9. Unset env variable for the work path
```shell
unset WORK_PATH
```
##  Example `02-fastapi-tortoise`
1. Export env variable with the path:
```shell
export WORK_PATH="$HOME/devspace-example-python/02-fastapi-tortoise"
```
2. Fix versions in file with requirements `$WORK_PATH/backend/pyproject.toml`
```shell
sed -i "s/fastapi>=0\.83\.0,<1\.0\.0/fastapi==0\.83\.0/" $WORK_PATH/backend/pyproject.toml
```s
sed -i "s/tortoise-orm\[asyncpg\]>=0\.19\.2,<1\.0\.0/tortoise-orm[asyncpg]==0\.19\.2/" $WORK_PATH/backend/pyproject.toml
```
3. In the file ``$WORK_PATH/devspace.yaml` do the following changes:
- Add variables:   
```yaml
vars:
  REGISTRY: 127.0.0.1:12345
  INT_REGISTRY: ds-reg:5000
```
  via command:   
```shell
  sed -ri "s/REGISTRY: ([0-9]{1,3}\.){3}[0-9]{1,3}(|:[0-9]{1,5})/REGISTRY: 127.0.0.1:12345\n  INT_REGISTRY: ds-reg:5000/" $WORK_PATH/devspace.yaml
```
- Change variables values in the file `./devspace.yaml`:    
```shell
sed -i "s/\${REGISTRY}\/python-simple-project-db/python-simple-project-db/" $WORK_PATH/devspace.yaml
```
```shell
sed -i "s/\${REGISTRY}\/python-simple-project-backend/python-simple-project-backend/" $WORK_PATH/devspace.yaml
``` 
- Replace paths to the images:    
```shell
sed -i "s/image: \${DATABASE_IMAGE}/image: \${REGISTRY}\/\${DATABASE_IMAGE}/" $WORK_PATH/devspace.yaml
```
```shell
sed -i "s/image: \${BACKEND_IMAGE}/image: \${REGISTRY}\/\${BACKEND_IMAGE}/" $WORK_PATH/devspace.yaml
```
```shell
sed -i "s/imageSelector: \${BACKEND_IMAGE}/imageSelector: \${INT_REGISTRY}\/\${BACKEND_IMAGE}/" $WORK_PATH/devspace.yaml
```
- Add tag `latest`:   
```shell
sed -i "s/rebuildStrategy: ignoreContextChanges/rebuildStrategy: ignoreContextChanges\n    tags:\n      - latest/" ./devspace.yaml
```
4. Change image addresses for database and backend in `./manifests/deployment.yaml`:       
```shell
sed -ri "s/([0-9]{1,3}\.){3}[0-9]{1,3}(|:[0-9]{1,5})/ds-reg:5000/" $WORK_PATH/manifests/deployment.yaml
```
5. Start project for development
```shell
 devspace dev
```
6. Go to the browser and open page `http://127.0.0.1:3000/people/1`

7. View kube services are running in namespace `python-fastapi-tortoise` or go to the `OpenLens` to view more details
```shell
kubectl get service -n python-fastapi-tortoise
```
8. Clean devspace
```shell
devspace purge
```
9. Run development without services using profile named `dev`:
```shell
devspace dev -p dev
```
10. View there is no running kube services in namespace `python-fastapi-tortoise` or go to the `OpenLens` to view more details
```shell
kubectl get service -n python-fastapi-tortoise
```
11. Unset env variable for the work path
```shell
unset WORK_PATH
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

## References
1. [Node port](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)
2. [Asynchronous Server Gateway Interface](https://asgi.readthedocs.io/en/latest/)
3. [Uvicorn - An ASGI web server, for Python.](https://www.uvicorn.org/)
4. [Devspace example python](https://github.com/loft-sh/devspace-example-python.git)
5. [Develop environments using Nix](https://devenv.sh/)