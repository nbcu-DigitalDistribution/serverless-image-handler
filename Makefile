clean_containers:
	./clean_containers.sh

build_package: clean_containers
	docker build -t thumbor-lambda .
	docker exec $(shell docker run -itd --name=thumbor thumbor-lambda bash) /thumbor/deployment/build.sh

upload_package: build_package
	./deployment/upload.sh

.PHONY: build_package upload_package
