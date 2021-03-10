# docker-terraform-packer
Container with Terraform, Packer, Ansible, AWSCLI and some useful DevOps utils

## Build 
To build
```commandline
docker tag imageID hunteri/terraform-packer:0.3
docker build -t hunteri/terraform-packer:latest .
docker push hunteri/terraform-packer:latest
```

## Running
```commandline
docker run -dit hunteri/terraform-packer:latest bash
docker attach <CONTAINER_NAME>
```
