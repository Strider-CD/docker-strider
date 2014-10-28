TAG=`cat TAG`

build:
	docker build -t $(TAG) .

push: build
	docker push $(TAG)

test: build
	docker run --rm -p 3000:3000 -e GENERATE_ADMIN_USER=true -t $(TAG)
