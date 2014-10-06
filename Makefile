TAG=`cat TAG`

build:
	docker build -t $(TAG) .

push: build
	docker push $(TAG)
