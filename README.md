# Snapcast Client
docker image para [snapcast client](https://github.com/badaix/snapcast).

## Compilar Docker 
Se testeo la compilacion en amd64 y armv7. 

docker buildx build --progress=plain --platform=linux/amd64,linux/arm/v7 -t matiasgonzalocalvo/snapcastclient:latest --push .

## Run Snapclient
Este docker se probo en ubuntu 20.04 y en una raspberry:

* `--device /dev/snd` a sound device for snapclient to output sound to.
* `-e snapserverhost` the hostname or IP of the snapserver.
* `--net host` para que funcione correctamente sin este parametro cuando se baja el volumen el cliente no recibia la orden.

``` /bin/bash

docker run -t -d --name snapcast-client --device /dev/snd -h docker-$(hostname) -e snapserverhost=192.168.0.10 --net host  --restart always -d matiasgonzalocalvo/snapcastclient:latest

```

## Snapcast Updates
Para cambiar la version del Snap Cast Client hay que pasar en el buil el argumento de la version. dejo abajo el ejemplo 

docker buildx build --build-arg Version=0.20.0 --progress=plain --platform=linux/amd64,linux/arm/v7 -t matiasgonzalocalvo/snapcastclient:latest --push .
