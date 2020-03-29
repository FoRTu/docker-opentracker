FROM alpine

LABEL maintainer="FoRTu" \
maintainer.website="https://github.com/FoRTu"

WORKDIR /tmp

RUN apk add --no-cache \
gcc \
g++ \
make \
git \
cvs \
zlib-dev \
&& cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat \
&& cd libowfat \
&& make \
&& cd ../ \
&& git clone git://erdgeist.org/opentracker

COPY Makefile /tmp/opentracker/Makefile

RUN cd /tmp/opentracker \
&& make \
&& cp /tmp/opentracker/opentracker.debug /bin/opentracker \
&& apk del gcc g++ make git cvs zlib-dev \
&& rm -rf /var/cache/apk/* /tmp/*

EXPOSE 6969

CMD opentracker -f /etc/opentracker/opentracker.conf
