# File "Magic.command":
#!/bin/bash
docker build --no-cache -t sebaxakerhtc/ipxe-simple .
docker run --privileged --name ipxe-root -td sebaxakerhtc/ipxe-simple
docker exec ipxe-root sh efi-iso.sh
docker stop ipxe-root
docker commit ipxe-root sebaxakerhtc/ipxe-simple-efi
docker rm ipxe-root
docker rmi sebaxakerhtc/ipxe-simple
docker run --name ipxe-simple -p 80:80 -td sebaxakerhtc/ipxe-simple-efi