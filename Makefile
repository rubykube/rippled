VERSION := $(shell cat VERSION)
IMAGE   := rubykube/rippled:$(VERSION)

.PHONY: default build push run ci deploy

default: build run

build:
	@echo '> Building "rippled" docker image...'
	@docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)

run:
	@echo '> Starting "rippled" container...'
	@docker run -d --rm $(IMAGE)

debug:
	@echo '> Starting "rippled" container'
	@docker run -it --rm $(IMAGE) bash

ci:
	@fly -t ci set-pipeline -p rippled -c config/pipelines/review.yml -n
	@fly -t ci unpause-pipeline -p rippled

deploy: push
	@helm install ./config/charts/rippled --set "image.tag=$(VERSION)"
