Easy iPXE Building from source code
==============================

## You need Docker installed for this project!

Special thanks to [BackyMaler](https://github.com/BuckyMaler/global) for the wonderful black theme!

# For beginners
* Download or clone the project
* Replace or Edit the script's Legacy.ipxe (For Legacy BIOS'es) and EFI.ipxe (For UEFI devices)
* Run the Magic batch file (Magic.cmd on Windows, Magic.sh on Linux and Magic.command on Mac)
* When Magic is done - open your browser and open http://localhost to download your images
* Enjoy!

### You are developer from now! You builded latest iPXE from source code!!!

# For advanced

## Step 1: Download the project.

You can use git command or simply download it from github

## Step 2: Edit files

### You can change the commands to edit config files, add/or remove packages, add/or remove files, etc.
- a. You can can comment out "make efi" commands to save your time if you don't need them.
- b. You can comment out settings "sed -i..." if you don' tneed them.
- c. You can edit/add/or remove batch files.
- d. etc.

## Step 3: Build the project
The build process might take some time a while as it download the origin Ubuntu docker image,
clone iPXE source and build all necessary images.

```
docker build --no-cache -t sebaxakerhtc/ipxe-simple .
```
* If you NEED efi bootable iso - go to step 4 NOW!
* If you DON'T NEED efi bootable iso - you are ready to run the container and go to step 6:
```
docker run --name ipxe-simple -p 80:80 -td sebaxakerhtc/ipxe-simple
```
## Step 4: Run conteiner with --privileged option and exec a script to make efi bootable iso
### It necessary for "mount"/"umount" commands
* Run container --privileged:
```
docker run --privileged --name ipxe-root -td sebaxakerhtc/ipxe-simple
```
* Exec a script to to make efi bootable iso:
```
docker exec ipxe-root sh efi-iso.sh
```
* Stop --privileged conteiner:
```
docker stop ipxe-root
```
* Clone edited conteiner in new image:
```
docker commit ipxe-root sebaxakerhtc/ipxe-simple-efi
```
* Remoove --privileged container and default image:
```
docker rm ipxe-root
docker rmi sebaxakerhtc/ipxe-simple
```
## Step 5: Run the container
* Run the container with default permissions:
```
docker run --name ipxe-simple -p 80:80 -d sebaxakerhtc/ipxe-simple-efi
```

## Step 6:Enjoy!
### Open your browser and type http://localhost or your choosen ip/port

## Contributing

1. Fork it
2. Create a branch
3. Commit your changes
4. Push to the branch
5. Create an [Issue][1] with a link to your branch
6. Or Send me a [Pull Request][2]

[1]: https://github.com/sebaxakerhtc/ipxe-simple/issues
[2]: https://github.com/sebaxakerhtc/ipxe-simple/pull/new/master

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
