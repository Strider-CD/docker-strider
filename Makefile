TAG=`cat TAG`

build:
	docker build -t $(TAG) .

push: build
	docker push $(TAG)

test: build
	docker run --rm -t $(TAG) --help
