# Docker Image for Fish Shell and NeoVim
This repository contains a Dockerfile for building a Docker image with Fish shell and NeoVim installed.

## Getting Started
Prerequisites
To use this image, you must have Docker installed on your machine. You can download Docker from the official website: https://www.docker.com/get-started

### Set env
```fish
.env 
#add your pub key for ssh to docker
SSH_PUB_KEY="ssh-rsa "

#add the dir on your workspace for share as volume
WORKSPACE_DIR="${HOME}/code"
```

### Running the Container
```fish
docker-compose up --build -d
```
This will start the container with Fish shell and NeoVim installed.

### Set ssh
```
vi ~/.ssh/config

Host nameSsh
    Hostname 0.0.0.0
    User root
    Port 2222
```
### Connection to workspace
```fish
  ssh nameSsh
```
