Same as https://registry.hub.docker.com/_/mongo/

Source: https://github.com/docker-library/mongo/tree/master/2.7

# Linking

docker run --name some-app --link some-mongo:mongo -d application-that-uses-mongo
