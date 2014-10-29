DB="DB_URI=mongodb://keyvan:mypass@ds041380.mongolab.com:41380/strider-testing"
TAG=`cat TAG`

build:
	docker build -t $(TAG) .

push: build
	docker push $(TAG)

test: build
	docker run --rm -p 3000:3000 -e $(DB) -e GENERATE_ADMIN_USER=true -t $(TAG)
