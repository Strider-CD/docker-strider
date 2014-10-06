build:
	docker build -t quay.io/keyvanfatehi/strider:1.5.0 .

push:
	docker push quay.io/keyvanfatehi/strider:1.5.0
