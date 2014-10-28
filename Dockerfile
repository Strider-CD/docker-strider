FROM dockerfile/supervisor
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

ENV STRIDER_TAG 1.6.0-pre.2

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

USER root
RUN apt-get update && apt-get -y install nodejs npm
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN mkdir /strider
RUN adduser --disabled-password --gecos "" --home /strider strider
RUN chown -R strider:strider /strider
USER strider
ENV HOME /strider


RUN git clone --branch $STRIDER_TAG --depth 1 https://github.com/Strider-CD/strider /strider/src
RUN cd /strider/src
WORKDIR /strider/src
RUN npm install
RUN npm run postinstall
RUN npm run build

USER root
RUN apt-get install -y python-pip
RUN pip install supervisor-stdout
ADD sv_stdout.conf /etc/supervisor/conf.d/

RUN ln -s /strider/src/bin/strider /usr/local/bin/strider
COPY start.sh /usr/local/bin/start.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD strider.conf /etc/supervisor/conf.d/strider.conf


EXPOSE 3000
CMD ["bash", "/usr/local/bin/start.sh"]
