FROM ubuntu:14.04
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

ENV STRIDER_TAG v1.6.4
ENV STRIDER_REPO https://github.com/Strider-CD/strider

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update && \
  apt-get install -y git supervisor python-pip curl && \
  pip install supervisor-stdout && \
  sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf && \
  curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - && \
  apt-get install -y nodejs

ADD sv_stdout.conf /etc/supervisor/conf.d/

VOLUME /home/strider/.strider
RUN mkdir -p /home/strider && mkdir -p /opt/strider
RUN adduser --disabled-password --gecos "" --home /home/strider strider
RUN chown -R strider:strider /home/strider
RUN chown -R strider:strider /opt/strider
RUN ln -s /opt/strider/src/bin/strider /usr/local/bin/strider
USER strider
ENV HOME /home/strider

RUN git clone --branch $STRIDER_TAG --depth 1 $STRIDER_REPO /opt/strider/src && \
  cd /opt/strider/src && npm install && npm run build
COPY start.sh /usr/local/bin/start.sh
ADD strider.conf /etc/supervisor/conf.d/strider.conf
EXPOSE 3000
USER root
CMD ["bash", "/usr/local/bin/start.sh"]
