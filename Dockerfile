FROM dockerfile/nodejs
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>
RUN adduser --disabled-password --gecos "" strider
RUN mkdir -p /opt/strider
WORKDIR /opt/strider
RUN npm install strider@1.5.0
RUN chown -R strider:strider /opt/strider
ADD start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh
USER strider
CMD ["/usr/local/bin/start.sh"]
EXPOSE 3000
