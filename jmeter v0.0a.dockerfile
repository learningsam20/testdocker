FROM alpine:3.6

MAINTAINER Just van den Broecke<just@justobjects.nl>

ARG JMETER_VERSION="3.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV     JMETER_BIN      ${JMETER_HOME}/bin
ENV     JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# Install extra packages
# See https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-272703023
# Change TimeZone TODO: TZ still is not set!
ARG TZ="Europe/Amsterdam"
#RUN su
RUN apk update
RUN apk upgrade
# RUN apk add --update nodejs nodejs-npm
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update openjdk7-jre tzdata curl unzip bash python nodejs nodejs-npm git make gcc g++
#RUN apk add --update nodejs nodejs-npm

#RUN apk add docker --no-cache

# Clean APK cache
RUN rm -rf /var/cache/apk/*

# download and extract JMeter
RUN mkdir -p /tmp/dependencies
RUN curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter.tgz
RUN mkdir -p /opt

RUN tar -xzf /tmp/dependencies/apache-jmeter.tgz -C /opt && \
    rm -rf /tmp/dependencies

RUN mkdir -p /wetty
RUN cd /wetty
RUN git clone https://github.com/krishnasrinivas/wetty
RUN cd /wetty/wetty
#RUN ls
RUN npm install
#RUN npm -g config set user root
#RUN npm install wetty -g
RUN cp /wetty/wetty/bin/wetty.conf /etc/init
##RUN start wetty
RUN cd /wetty
#RUN ls
#RUN node app.js -p 3000

# TODO: plugins (later)
# && unzip -oq "/tmp/dependencies/JMeterPlugins-*.zip" -d $JMETER_HOME

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
#COPY entrypoint.sh /

WORKDIR ${JMETER_HOME}

#ENTRYPOINT ["/entrypoint.sh"]
