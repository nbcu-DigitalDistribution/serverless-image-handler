clean_containers:
	./clean_containers.sh

build_docker_container: clean_containers
	docker build -t thumbor-lambda .
	docker run --rm -itd --name=thumbor thumbor-lambda bash

build_package: build_docker_container
	docker exec $$(docker inspect --format="{{.Id}}" thumbor) /thumbor/deployment/build.sh $(VERSION)
	./deployment/copy-package.sh

upload_package: build_docker_container
	./deployment/upload.sh $(VERSION)

unit_test: build_package
	docker exec $$(docker inspect --format="{{.Id}}" thumbor) /thumbor/deployment/run-unit-tests.sh

.PHONY: build_package upload_package
