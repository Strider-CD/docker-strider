FROM dockerfile/nodejs
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>
RUN adduser --disabled-password --gecos "" strider
RUN mkdir -p /opt/strider
WORKDIR /opt/strider
RUN npm install strider@1.5.0
RUN chown -R strider:strider /opt/strider
USER strider
CMD ["/opt/strider/node_modules/strider/bin/strider"]
EXPOSE 3000
