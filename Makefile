VERSION ?= 2.0.3
NAME ?= "nats-client-metrics"
AUTHOR ?= "Dale Bingham"
PORT_EXT ?= 7778
PORT_INT ?= 7778
NO_CACHE ?= true
DOCKERHUB_ACCOUNT ?= cingulara
  
.PHONY: build docker latest clean version dockerhub

build:  
	dotnet build src

docker: 
	docker build -f Dockerfile -t $(NAME)\:$(VERSION) --no-cache=$(NO_CACHE) .

latest: 
	docker build -f Dockerfile -t $(NAME)\:latest --no-cache=$(NO_CACHE) .
	docker tag $(NAME)\:latest ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
 
clean:
	@rm -f -r src/obj
	@rm -f -r src/bin

version:
	@echo ${VERSION}

dockerhub:
	docker tag $(NAME)\:$(VERSION) ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)

DEFAULT: build
