FROM ubuntu:latest
MAINTAINER learningsam20@gmail.com
 Just van den Broecke<just@justobjects.nl>

ARG JMETER_VERSION="3.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN apt update
RUN apt-get install -y ca-certificates
RUN apt-get install curl
RUN apt-get install git
RUN apt-get install openjdk-jre
RUN apt-get install unzip
RUN apt-get install bash

RUN mkdir -p /tmp/dependencies

RUN	curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter.tgz
RUN mkdir -p /opt

RUN tar -xzf /tmp/dependencies/apache-jmeter.tgz -C /opt && \
    rm -rf /tmp/dependencies

RUN apt-get install -y npm
RUN alias node=nodejs
RUN npm install wetty -g
RUN cp /usr/local/lib/node_modules/wetty/bin/wetty.conf /etc/init    

  
