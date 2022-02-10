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
