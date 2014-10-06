# docker-strider

Semi-official docker build that does NOT ship with internal Mongo or SSH.

It contains only strider, its dependent modules and nodejs/npm.

For MongoDB, you must pass in a DB_URI

## Pulling

Hosted on Quay.io. Find what to `docker pull` by checking the TAG file

## Building

Clone the project and `docker build . -t <TAG>`

## Running

Say you've created a database at MongoLab, here's how you would run it:

`docker run -e "DB_URI=mongodb://keyvan:passwd@ds041380.mongolab.com:41380/strider-testing" <TAG>`

## Linking

A compatible mongo image is included. It's left up to the user to decide how to use it.

## Security

This image can generate an admin user with a random password. Set environment variable `GENERATE_ADMIN_USER` to use this feature.
