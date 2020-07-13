#Si es arm seteo la dist armhf
FROM --platform=$TARGETPLATFORM debian:latest AS debian-arm
ENV DIST_ARCH=armhf
RUN echo "(|| DIST_ARCH == $DIST_ARCH || "

#si es 64 bits setedo distamd64
FROM --platform=$TARGETPLATFORM debian:latest AS debian-amd64
ENV DIST_ARCH=amd64
RUN echo "(|| DIST_ARCH == $DIST_ARCH ||"

FROM --platform=$TARGETPLATFORM debian-$TARGETARCH
ENV Version=0.20.0
ENV GitUrlSnapcast https://github.com/badaix/snapcast/releases/download/
ENV USER snapclient
ENV GROUP snapclient
ENV WORKDIR /app

RUN groupadd -r ${GROUP} && useradd --no-log-init -r -g ${GROUP} ${USER}

WORKDIR ${WORKDIR}

#INSTALL SNAPCAST
RUN apt update && apt install wget libasound2 libavahi-client3  libavahi-common3 libflac8 libogg0 libopus0 libsoxr0 libvorbis0a -y
RUN wget ${GitUrlSnapcast}v${Version}/snapclient_${Version}-1_${DIST_ARCH}.deb
RUN dpkg -i snapclient_${Version}-1_${DIST_ARCH}.deb &&  rm -rf snapclient_${Version}-1_${DIST_ARCH}.deb 
CMD ["sh","-c","if [ ! -z ${snapserverhost} ] ; then /usr/bin/snapclient -h ${snapserverhost} ; else /usr/bin/snapclient ; fi "]
