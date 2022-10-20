FROM ubuntu
MAINTAINER Alexander Sorokin <sebastian.sorokin@gmail.com>

## Upgrade existing packages
RUN apt-get update && apt-get -y upgrade

## For apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Install packages
RUN apt-get install -y apache2 gcc binutils make perl liblzma-dev mtools syslinux isolinux git xorriso cron

## Prepare html
RUN rm /var/www/html/index.html
ADD html/ /var/www/html/
RUN mkdir /var/www/html/bin

## Adding scripts and files
ADD config-backup /config-backup
ADD renew.sh /renew.sh
RUN chmod +x /renew.sh

# Copy renew file to the cron.d directory
COPY renew /etc/cron.d/renew
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/renew

# Apply cron job
RUN crontab /etc/cron.d/renew

# Clone repo for script to work for the first time
RUN git clone git://git.ipxe.org/ipxe.git

### Uncomment next line for working WPA2 connections ###
# RUN git -C ipxe reset --hard 0fb37a4

# Build latest images
RUN /renew.sh

## Expose ports.
EXPOSE 80

## Run apache2
CMD /usr/sbin/cron start && /usr/sbin/apache2ctl -D FOREGROUND
