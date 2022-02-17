# README

## TASKS

- Create an object store in cloud provider of choice by terraform (eg. S3 in AWS) - Upload something
- Create a small tool in language of choice to enumerate the object store
- Create a Dockerfile to host the tool
- Bonus: deploy to kubernetes (eg. minikube) with tooling of choice - Bonus: sketch out possible CICD setup
- Bonus: roughly describe possible credential storage

## INSTRUCTIONS

- apply Terraform (aws local profile "test"):

  > make tfapply

- build docker image:

  > make build

- run docker image locally (env vars must be configured AWS_ACCESS_KEY AWS_SECRET_KEY):
  > make run

- run docker image as cronjob into minikube:
  > make mkloadimage
  > make mkcreatejob
  > make mkgetjobstatus

## CI/CD SETUP

Pipeline steps:
- pip install
- terraform validate
- docker build
- docker run locally to test the code
- docker push to container images repo
- helm package
- upload helm package to Artifactory repo
- terraform plan
- terraform apply
- helm upgrade --install

## CREDENTIAL STORAGE

- load credentials from an external service (AWS System Manager - Parameters store); but the container needs an IAM role to load them
- add a role to the container to be able to list the S3 bucket content

## IMPROVEMENTS

### TERRAFORM

- save tfstate to a custom S3 backend to share it across team/CICD

```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

- use DynamoDB table for locking
- use Terraform workspaces to manage a Multi-account AWS Architecture

### DOCKER

- use multi-stage Dockerfile
- set a USER in the Dockerfile

### SECURITY

- user namespaces
- kernel capabilities
- read only filesystem