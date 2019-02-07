clean_containers:
	./clean_containers.sh

build_package: clean_containers
	docker build -t thumbor-lambda .
	docker run --rm -itd --name=thumbor thumbor-lambda bash
	docker exec $$(docker inspect --format="{{.Id}}" thumbor) /thumbor/deployment/build.sh $(VERSION)
	./deployment/copy-package.sh

upload_package: build_package
	./deployment/upload.sh $(VERSION)

.PHONY: build_package upload_package
