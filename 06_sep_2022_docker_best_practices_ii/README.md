## Certificates


```
cd certs
docker build --file Dockerfile-app --build-arg BASE_IMAGE=$(./build-base-image.sh | tail -n 1) . 
```

## Dependencies


```
cd dependencies
docker build --file Dockerfile-app --build-arg BASE_IMAGE=$(./build-deps-image.sh | tail -n 1) . 
```