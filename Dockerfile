FROM dockerfile/nodejs
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

ENV STRIDER_VERSION 1.6.0-pre.1

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN mkdir /strider
RUN adduser --disabled-password --gecos "" --home /strider strider
RUN chown -R strider:strider /strider
USER strider
ENV HOME /strider

RUN git clone --branch $STRIDER_VERSION --depth 1 https://github.com/Strider-CD/strider /strider/src
RUN cd /strider/src
WORKDIR /strider/src
RUN npm install
RUN npm run postinstall
RUN npm run build

USER root
RUN ln -s /strider/src/bin/strider /usr/local/bin/strider
COPY start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh
USER strider

# this line can come out for anything after 1.6.0-pre.1
RUN touch /strider/src/.restart

WORKDIR /strider
ENV NODE_ENV production
ENV PORT 3000
EXPOSE 3000
ENTRYPOINT /usr/local/bin/start.sh
