FROM dockerfile/nodejs
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN git clone --branch 1.5.0 --depth 1 https://github.com/Strider-CD/strider /strider/src
RUN cd /strider/src && npm install --production
RUN adduser --disabled-password --gecos "" --home /strider strider
RUN ln -s /strider/src/bin/strider /usr/local/bin/strider

RUN chown -R strider:strider /strider
COPY start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh
USER strider

CMD ["/usr/local/bin/start.sh"]
EXPOSE 3000
ENV NODE_ENV production
ENV HOME /strider
ENV PORT 3000
