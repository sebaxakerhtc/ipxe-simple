mkdir /mnt/ipxe && mount -t vfat -o rw /efiiso/efi/IPXE.IMG /mnt/ipxe
mkdir -p /mnt/ipxe/efi/boot
cp /var/www/html/bin/bootx64.efi /mnt/ipxe/efi/boot/
cp /var/www/html/bin/bootia32.efi /mnt/ipxe/efi/boot/
umount /mnt/ipxe
genisoimage -v -J -r -V "IPXE" -o /var/www/html/bin/ipxe-efi.iso -eltorito-alt-boot -e IPXE.IMG -no-emul-boot /efiiso/efi
