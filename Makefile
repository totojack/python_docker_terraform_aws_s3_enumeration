DOCKER_IMAGE = python_s3_enumerator:latest
KUBE_MANIFEST = deployment/cronjob.yaml
KUBE_CRONJOB = python-s3-enumerator

help:
	@echo 'Available targets:'
	@echo '- build: build docker image locally'
	@echo '- run: run the docker container locally'
	@echo '- tfapply: create and apply terraform plan'
	@echo '- mkloadimage: load local docker image to minikube'		
	@echo '- mkcreatejob: create cronjob into minikube'
	@echo '- mkdeletejob: delete cronjob from minikube'
	@echo '- mkgetjobstatus: show job details into minikube'
	@echo '- mktailjobs: tail jobs executions'

build: #build docker image locally
	docker build -t ${DOCKER_IMAGE} .

run: #run docker image locally
	docker run --rm --env AWS_ACCESS_KEY=${AWS_ACCESS_KEY} --env AWS_SECRET_KEY=${AWS_SECRET_KEY} ${DOCKER_IMAGE}

tfapply: #create and apply tf plan
	cd terraform && terraform plan -out=plan.out && terraform apply plan.out

mkloadimage: #load local docker image to minikube
	minikube image load ${DOCKER_IMAGE}

mkcreatejob: #create cronjob into minikube
	kubectl create -f ${KUBE_MANIFEST}

mkdeletejob: #delete cronjob from minikube
	kubectl delete -f ${KUBE_MANIFEST}

mkgetjobstatus: #show job details into minikube
	kubectl get cronjob ${KUBE_CRONJOB}

mktailjobs: #tail jobs executions
	kubectl get jobs --watch