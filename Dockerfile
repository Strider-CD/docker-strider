FROM ubuntu:14.04
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

ENV STRIDER_TAG 1.6.0-pre.2
ENV STRIDER_REPO https://github.com/Strider-CD/strider

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update && \
  apt-get install -y git supervisor python-pip nodejs npm && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \
  pip install supervisor-stdout && \
  sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

ADD sv_stdout.conf /etc/supervisor/conf.d/

RUN mkdir -p /home/strider && mkdir -p /opt/strider
RUN adduser --disabled-password --gecos "" --home /home/strider strider
RUN chown -R strider:strider /home/strider
RUN chown -R strider:strider /opt/strider
RUN ln -s /opt/strider/src/bin/strider /usr/local/bin/strider
USER strider
VOLUME /home/strider
ENV HOME /home/strider

RUN git clone --branch $STRIDER_TAG --depth 1 $STRIDER_REPO /opt/strider/src && \
  cd /opt/strider/src && npm install && npm run postinstall && npm run build
COPY start.sh /usr/local/bin/start.sh
ADD strider.conf /etc/supervisor/conf.d/strider.conf
EXPOSE 3000
USER root
CMD ["bash", "/usr/local/bin/start.sh"]
