FROM ubuntu
MAINTAINER Alexander Sorokin <sebastian.sorokin@gmail.com>

## Upgrade existing packages
RUN apt update && apt -y upgrade

## For apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Install packages
RUN apt install -y apache2 gcc binutils make perl liblzma-dev mtools genisoimage syslinux isolinux git

## Clone repo
RUN git clone git://git.ipxe.org/ipxe.git

### SETTINGS ###
RUN mkdir /config-backup
RUN cp ipxe/src/config/branding.h /config-backup/
RUN cp ipxe/src/config/general.h /config-backup/
RUN cp ipxe/src/config/console.h /config-backup/

## branding.h
RUN sed -i 's/#define\ PRODUCT_NAME\ ""/#define\ PRODUCT_NAME\ "Serviz\ za\ komputri\ Burgas"/' ipxe/src/config/branding.h
RUN sed -i 's/#define\ PRODUCT_SHORT_NAME\ "iPXE"/#define\ PRODUCT_SHORT_NAME\ "sebaxakerhtc"/' ipxe/src/config/branding.h
RUN sed -i 's/#define\ PRODUCT_URI\ "http:\/\/ipxe.org"/#define\ PRODUCT_URI\ "https:\/\/pcserviceburgas.com"/' ipxe/src/config/branding.h
RUN sed -i 's/#define\ PRODUCT_TAG_LINE\ "Open\ Source\ Network\ Boot\ Firmware"/#define\ PRODUCT_TAG_LINE\ "Han\ Asparuh\ 28"/' ipxe/src/config/branding.h

## general.h
RUN sed -i 's/#undef\tDOWNLOAD_PROTO_HTTPS/#define\ DOWNLOAD_PROTO_HTTPS/' ipxe/src/config/general.h
RUN sed -i 's/#undef\tDOWNLOAD_PROTO_FTP/#define\ DOWNLOAD_PROTO_FTP/' ipxe/src/config/general.h
RUN sed -i 's/#undef\tDOWNLOAD_PROTO_NFS/#define\ DOWNLOAD_PROTO_NFS/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#undef\tSANBOOT_PROTO_ISCSI/#define\ SANBOOT_PROTO_ISCSI/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#undef\tSANBOOT_PROTO_HTTP/#define\ SANBOOT_PROTO_HTTP/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\tIMAGE_PXE/#define\ IMAGE_PXE/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\tIMAGE_SCRIPT/#define\ IMAGE_SCRIPT/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\tIMAGE_BZIMAGE/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ DIGEST_CMD/#define\ DIGEST_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ REBOOT_CMD/#define\ REBOOT_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ POWEROFF_CMD/#define\ POWEROFF_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ IMAGE_TRUST_CMD/#define\ IMAGE_TRUST_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ PING_CMD/#define\ PING_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ CONSOLE_CMD/#define\ CONSOLE_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ IPSTAT_CMD/#define\ IPSTAT_CMD/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\ CERT_CMD/#define\ CERT_CMD/' ipxe/src/config/general.h

## console.h
RUN sed -i 's/\/\/#undef\tCONSOLE_PCBIOS/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
RUN sed -i 's/\/\/#define\tCONSOLE_FRAMEBUFFER/#define\ CONSOLE_FRAMEBUFFER/' ipxe/src/config/console.h
RUN sed -i 's/\/\/#define\tCONSOLE_DIRECT_VGA/#define\ CONSOLE_DIRECT_VGA/' ipxe/src/config/console.h

## Run make
RUN make -C ipxe/src

## Prepare html
RUN rm /var/www/html/index.html
ADD html/ /var/www/html/
RUN mkdir /var/www/html/bin

## Adding scripts
ADD Legacy.ipxe /ipxe/src/
ADD EFI.ipxe /ipxe/src/

## Prepare efi bootable iso script and files
RUN mkdir -p /efiiso/efi
ADD IPXE.IMG /efiiso/efi/
ADD efi-iso.sh efi-iso.sh
RUN chmod +x efi-iso.sh

## Legacy BIOS Images
RUN make bin/ipxe.iso EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.iso /var/www/html/bin/
RUN make bin/ipxe.dsk EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.dsk /var/www/html/bin/
RUN make bin/ipxe.lkrn EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.lkrn /var/www/html/bin/
RUN make bin/ipxe.usb EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.usb /var/www/html/bin/
RUN make bin/ipxe.pxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.pxe /var/www/html/bin/
RUN make bin/ipxe.kpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kpxe /var/www/html/bin/
RUN make bin/ipxe.kkpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kkpxe /var/www/html/bin/
RUN make bin/ipxe.kkkpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kkkpxe /var/www/html/bin/

### SETTINGS EFI ###
## general.h
RUN sed -i 's/#define\ IMAGE_PXE/\/\/#define\ IMAGE_PXE/' ipxe/src/config/general.h
RUN sed -i 's/#define\ IMAGE_BZIMAGE/\/\/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
RUN sed -i 's/\/\/#define\tIMAGE_EFI/#define\ IMAGE_EFI/' ipxe/src/config/general.h

## console.h
RUN sed -i 's/#define\ CONSOLE_PCBIOS/\/\/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
RUN sed -i 's/\/\/#undef\tCONSOLE_EFI/#define\tCONSOLE_EFI/' ipxe/src/config/console.h

## EFI Images
RUN make bin-x86_64-efi/ipxe.efi EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-x86_64-efi/ipxe.efi /var/www/html/bin/bootx64.efi
RUN make bin-i386-efi/ipxe.efi EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-i386-efi/ipxe.efi /var/www/html/bin/bootia32.efi

## Clean project
RUN make clean -C ipxe/src

# Expose ports.
EXPOSE 80

## Run apache2
CMD /usr/sbin/apache2ctl -D FOREGROUND
