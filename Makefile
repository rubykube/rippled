VERSION := $(shell cat VERSION)
IMAGE   := gcr.io/hc-public/rippled:$(VERSION)

.PHONY: default build push run

default: build run

build:
	@echo '> Building "rippled" docker image...'
	@docker build -t $(IMAGE) .

push: build
	gcloud docker -- push $(IMAGE)

run:
	@echo '> Starting "rippled" container...'
	@docker run -it --rm $(IMAGE) bash
