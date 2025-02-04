FROM debian:bookworm
##FROM is the base image

ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME

RUN apt-get update \
	&& apt-get install -y openssl nginx gettext-base moreutils \
	&& apt-get clean
## apt-get update : general update
## apt-get install -y : install the package
## -y : assume yes to all prompts
## nginx : nginx installationl
## openssl : openssl installation

## making a new ssl keyl
RUN openssl req -x509 -newkey rsa:2048 -nodes \
	-out /etc/nginx/cert.pem \
	-keyout /etc/nginx/key.pem -subj "/C=NL/L=NL/O=CODAM/OU=student/CN=${DOMAIN_NAME}"

## req : request certificate
## -x509 : self-signed certificate
## -nodes : no DES encryption, private key is not pw protected
## -newkey : new key
## -rsa:2048 : 2048 bit RSA key
## -keyout : key outputl
## -out : output certificate
## -subj : general info for the certificate
## C : country
## L : location
## O : organization
## OU : organizational unit
## CN : common name


COPY ./conf/custom.conf /etc/nginx/conf.d/default.conf
## nginx will by default use the config file in conf.d (conf.d dir is copied from the /conf dir by the COPY)

RUN envsubst < /etc/nginx/conf.d/default.conf | sponge /etc/nginx/conf.d/default.conf

COPY ./tools/index.html /usr/share/nginx/html/index.html


# port is already defined in docker-compose but leaving it here for clarity
EXPOSE 443


## difference between RUN and CMD
# RUN is used to run the command in the docker image
# CMD is used to set the default command for the docker container

CMD ["nginx", "-g", "daemon off;"]
## nginx : nginx command
## -g : set globally
## daemon off; : deamon is foreground or background, deamon off is run as a foreground process
## -c : set configuration file (by default already conf.d but to be 100% certain specifying)