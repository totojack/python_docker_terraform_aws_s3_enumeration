DOCKER_IMAGE = python_s3_enumerator:latest

help:
	@echo 'Available targets:'
	@echo '- build: build docker image locally'
	@echo '- run: run the docker container locally'
	@echo '- tfapply: create and apply terraform plan'		

build: #build docker image locally
	docker build -t ${DOCKER_IMAGE} .

run: #run docker image locally
	docker run --rm --env AWS_ACCESS_KEY=${AWS_ACCESS_KEY} --env AWS_SECRET_KEY=${AWS_SECRET_KEY} ${DOCKER_IMAGE}

tfapply: #create and apply tf plan
	cd terraform && terraform plan -out=plan.out && terraform apply plan.out