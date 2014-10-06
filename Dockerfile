FROM dockerfile/nodejs
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>
RUN adduser --disabled-password --gecos "" --home /home/strider strider
RUN mkdir -p /opt/strider
WORKDIR /opt/strider
RUN npm install strider@1.5.0
RUN chown -R strider:strider /opt/strider
RUN chown -R strider:strider /home/strider
ADD start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh
USER strider
ENV NODE_ENV production
ENV HOME /home/strider
ENV PORT 3000
EXPOSE 3000
CMD ["/usr/local/bin/start.sh"]
