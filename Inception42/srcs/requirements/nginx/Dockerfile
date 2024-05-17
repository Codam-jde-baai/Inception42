FROM alpine:3.19

ARG DOMAIN_NAME

##get the ARG:  DOMAIN_NAME from docker-compose

RUN apk update && apk add --no-cache nginx openssl
## apk update : general update
##  --no-cache : prevents caching the index locally, saving storage
## nginx : nginx installation
## openssl : openssl installation

## making a new ssl key
RUN openssl req -x509 -nodes -newkey rsa:2048 \
	-keyout /etc/ssl/private/${DOMAIN_NAME}.key \
	-out /etc/ssl/certs/${DOMAIN_NAME}.crt \
	-subj "/C=NL/L=NL/O=CODAM/OU=student/CN=${DOMAIN_NAME}"

## req : request certificate
## -x509 : self-signed certificate
## -nodes : no DES encryption, private key is not pw protected
## -newkey : new key
## -rsa:2048 : 2048 bit RSA key
## -keyout : key output
## -out : output certificate
## -subj : general info for the certificate
## C : country
## L : location
## O : organization
## OU : organizational unit
## CN : common name


COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
## nginx will by default use the config file in conf.d (conf.d dir is created by the COPY)


## difference between RUN and CMD

CMD ["nginx", "-g", "-c", "/etc/nginx/conf.d/default.conf", "daemon off;"]

## nginx : nginx command
## -g : set globally
## daemon off; : deamon is foreground or background, deamon off is run as a foreground process
## -c : set configuration file (by default already conf.d but to be 100% certain specifying)
