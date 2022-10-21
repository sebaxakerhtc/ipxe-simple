FROM ubuntu:20.04
MAINTAINER Alexander Sorokin <sebastian.sorokin@gmail.com>

## Upgrade existing packages
RUN apt-get update && apt-get -y upgrade

## For apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Install packages
RUN apt-get install -y apache2 gcc binutils make perl liblzma-dev mtools syslinux isolinux git xorriso

## Prepare html
RUN rm /var/www/html/index.html
ADD html/ /var/www/html/
RUN mkdir /var/www/html/bin

## Adding scripts and files
ADD config-backup /config-backup
ADD renew.sh /renew.sh
RUN chmod +x /renew.sh
 
# Clone repo for script to work for the first time
RUN git clone git://git.ipxe.org/ipxe.git

# Reset to Wi-Fi working commit
RUN git -C ipxe reset --hard 0fb37a4

# Build latest images
RUN /renew.sh

## Expose ports.
EXPOSE 80

## Run apache2
CMD /usr/sbin/apache2ctl -D FOREGROUND
