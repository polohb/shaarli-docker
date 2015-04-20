###
#
# FileName : Makefile
#
# Author :  polohb@gmail.com
#
# Description : Simple makefile to automate some tasks
#
##
CONTAINER_NAME = shaarli
IMG_NAME = polohb/$(CONTAINER_NAME)
DATA_VOLUME = /var/www/data
TIMESTAMP = $(shell date +'%Y%m%d-%H%M%S')


#all:
#	stop clean build run

# Build the image locally
build:
	docker build -t $(IMG_NAME) .


# Run a container with port forwarding
run:
	docker run -d --name $(CONTAINER_NAME) -p 8080:8080   $(IMG_NAME)

# Delete the image
clean:
	docker rm -v -f $(CONTAINER_NAME)

# Stop the container (do not delete it)
stop:
	docker stop $(CONTAINER_NAME)

# Start a previously stopped container
start:
	docker start $(CONTAINER_NAME)

# Restart a previously stopped container
#restart:
#	docker stop $(CONTAINER_NAME)

# Fetch the logs of the container
log:
	docker logs -f $(CONTAINER_NAME)

# List port mappings for the container
port:
	docker port $(CONTAINER_NAME)

# Run a bash shell into the container
enter:
	docker exec -it $(CONTAINER_NAME) /bin/bash

# Backup the gitblit-data folder as a tar archive
backup:
	docker run --rm --volumes-from $(CONTAINER_NAME) -v $(shell pwd):/backup busybox tar cvf /backup/backup-$(CONTAINER_NAME)$(TIMESTAMP).tar $(DATA_VOLUME)
	ln -nsf backup-$(CONTAINER_NAME)$(TIMESTAMP).tar backup-latest.tar

# Restore the gitblit-data folder from the tar archive created with 'make backup'
restore:
	docker run --rm --volumes-from $(CONTAINER_NAME) -v $(shell pwd):/backup busybox tar xvf /backup/backup-latest.tar
