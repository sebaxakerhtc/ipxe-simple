Easy iPXE Building from source code
==============================

## You need Docker installed for this project!

### You can see how it works and download the latest images at [ipxe.pcserviceburgas.com](https://ipxe.pcserviceburgas.com/)

## Step 1: Download the project.

You can use git command or simply download it from github

## Step 2: Edit files

### You can change the commands to edit config files, add/or remove packages, add/or remove files, etc.
- a. You can comment out "make efi" commands to save your time if you don't need them.
- b. You can comment out settings "sed -i..." if you don't need them.
- c. You can edit/add/or remove batch files.
- d. Replace the content of EFI.ipxe and Legacy.ipxe script with yours.
- e. etc.

## Step 3: Build the project
The build process might take some time a while as it download the origin Ubuntu docker image,
clone iPXE source and build all necessary images.

```
docker build --no-cache -t sebaxakerhtc/ipxe-simple .
```

## Step 4: Run the container
* Run the container:
```
docker run --name ipxe-simple -p 80:80 -d sebaxakerhtc/ipxe-simple
```
## Or two commands togrther: Build and Run the container
* Build and Run the container:
```
docker build --no-cache -t sebaxakerhtc/ipxe-simple . && docker run --name ipxe-simple -p 80:80 -d sebaxakerhtc/ipxe-simple
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
