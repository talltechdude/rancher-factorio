FROM ubuntu

ENV VERSION=0.14.22

RUN echo $VERSION	
RUN apt-get update && apt-get install -y curl tini
RUN curl -skSL https://www.factorio.com/get-download/$VERSION/headless/linux64 \
		-o /tmp/factorio_headless_x64_$VERSION.tar.gz
RUN tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz --directory /opt
RUN rm /tmp/factorio_headless_x64_$VERSION.tar.gz
#RUN apk del curl

ENTRYPOINT ["/sbin/tini", "--"]

RUN chmod +x /opt/factorio/bin/x64/factorio
WORKDIR /opt/factorio

RUN mkdir /opt/factorio/config
COPY files/map-gen-settings.json /opt/factorio/config
COPY files/server-settings.json /opt/factorio/config
COPY files/run.sh /opt/factorio

ENV FACTORIO_SAVE_NAME=factorio
ENV FACTORIO_PORT=

VOLUME /opt/factorio/saves
VOLUME /opt/factorio/mods

EXPOSE 34197/udp

CMD ["/opt/factorio/run.sh"]
