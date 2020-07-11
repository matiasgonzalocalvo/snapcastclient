ARG ARCH=arm32v7
FROM ${ARCH}/debian:latest

ARG DIST_ARCH=armhf
ARG Version=0.20.0

ENV GitUrlSnapcast https://github.com/badaix/snapcast/releases/download/
#ENV Version 0.20.0
ENV USER snapclient
ENV GROUP snapclient
ENV WORKDIR /app

RUN groupadd -r ${GROUP} && useradd --no-log-init -r -g ${GROUP} ${USER}

WORKDIR ${WORKDIR}

#INSTALL SNAPCAST
RUN apt update && apt install wget libasound2 libavahi-client3  libavahi-common3 libflac8 libogg0 libopus0 libsoxr0 libvorbis0a -y
RUN wget ${GitUrlSnapcast}v${Version}/snapclient_${Version}-1_${DIST_ARCH}.deb 
RUN dpkg -i snapclient_${Version}-1_${DIST_ARCH}.deb &&  rm -rf snapclient_${Version}-1_${DIST_ARCH}.deb 

CMD ["sh","-c","if ! [ -z snapserverhost ] ; then /usr/bin/snapclient -h ${snapserverhost} ; else /usr/bin/snapclient ; fi "]
