FROM alpine:latest

LABEL maintainer="FoRTu" \
maintainer.website="https://github.com/FoRTu"

RUN apk add --no-cache \
gcc \
g++ \
make \
git \
zlib-dev

WORKDIR /tmp

RUN wget http://www.fefe.de/libowfat/libowfat-0.32.tar.xz \
&& mkdir /tmp/libowfat \
&& tar -xf libowfat-0.32.tar.xz -C /tmp/libowfat --strip-components=1 \
&& cd /tmp/libowfat \
&& make \
&& cd /tmp \
&& git clone git://erdgeist.org/opentracker

COPY Makefile /tmp/opentracker/Makefile

RUN cd /tmp/opentracker \
&& make \
&& cp /tmp/opentracker/opentracker.debug /bin/opentracker \
&& apk del gcc g++ make git zlib-dev \
&& rm -rf /var/cache/apk/* /tmp/*

CMD opentracker -f /etc/opentracker/opentracker.conf
