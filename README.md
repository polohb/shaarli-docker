# Shaarli on Nginx & Docker

These instructions assume you have already installed Docker.

## Running Shaarli in Docker

You can use the Shaarli Docker image I have created [polohb/shaarli-docker](https://registry.hub.docker.com/u/polohb/shaarli-docker/).

### Get the docker image
```
docker pull polohb/shaarli-docker
```

### Launch Shaarli (nginx web based)
```
docker run -d --name shaarli -p 80:8080 polohb/shaarli-docker
```

- The container serves the web ui on ports `8080`.
- You just need to configure shaarli (fairly easy).

## Build Instructions

### Clone this Repository
```
git clone https://github.com/polohb/shaarli-docker.git
```

### Build your Docker container
```
cd shaarli-docker
make build
```

### Run your shaarli/nginx container and setup localhost port-forwarding :
```
make run
```
Be carefull default port is `8080`.


## Backup and Restore data

#### Backup the shaarli data folder
```
docker run --rm --volumes-from shaarli -v $(pwd):/backup busybox tar cvf /backup/backup.tar /var/www/data
```
or simply : `make backup`

#### Restore a shaarli data folder in the container
```
docker run --rm --volumes-from shaarli -v $(pwd):/backup busybox tar xvf /backup/backup.tar
```
or simply : `make restore`
