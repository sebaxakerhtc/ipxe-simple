Easy iPXE Building from source code
===================================
### You need Docker installed for this project!

## Demo
#### You can see demo and download the latest images at [ipxe.pcserviceburgas.com](https://ipxe.pcserviceburgas.com/)
#### Video instruction on [YouTube](https://youtu.be/kvNX7X7d2tw)
#### This build uses crontab to check any changes of iPXE source every 1 hour and if so then rebuild images. So you can use the latest images from there!
#### Also you can chain this images from another iPXE 
on Legacy BIOS systems
```
chain --autofree https://ipxe.pcserviceburgas.com/bin/ipxe.lkrn
```
or on EFI (x64)
```
chain --autofree https://ipxe.pcserviceburgas.com/bin/bootx64.efi
```
or on EFI (x86) netboot.xyz not provided for this platform
```
chain --autofree https://ipxe.pcserviceburgas.com/bin/bootia32.efi
```
## Step 1: Download the project.

You can use git command or simply download it from github

## Step 2: Edit files

### You can change the commands to edit config files, add/or remove packages, files, etc.
- a. You can comment out "make efi" commands to save your time if you don't need them.
- b. You can comment out settings "sed -i..." if you don't need them.
- c. You can edit/add/or remove batch files.
- d. Replace the content of EFI.ipxe and Legacy.ipxe script with yours.
- e. etc.

## Step 3: Build the project
The build process might take some time a while as it download the origin Ubuntu docker image,
clone iPXE source and build all necessary images.

Navigate to the project directory (where dockerfile and other project files are)
```
cd /path/to/project/dir
```

and start the build
```
docker build --no-cache -t sebaxakerhtc/ipxe-simple .
```

## Step 4: Run the container
Run the container:
```
docker run --restart unless-stopped --name ipxe-simple -p 80:80 -d sebaxakerhtc/ipxe-simple
```

## Step 5:Enjoy!
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

## Screenshots
![1](https://user-images.githubusercontent.com/32651506/115973212-f373ed80-a55b-11eb-9604-34569ce96bf7.jpg)
![2](https://user-images.githubusercontent.com/32651506/115973214-f53db100-a55b-11eb-8255-665269fc0b59.jpg)
![3](https://user-images.githubusercontent.com/32651506/115973144-82343a80-a55b-11eb-88e6-e603918b0d3a.png)
![4](https://user-images.githubusercontent.com/32651506/116702373-ac5d8080-a9d1-11eb-86cb-ee7d681f27a1.png)
![5](https://user-images.githubusercontent.com/32651506/115465172-d925d100-a236-11eb-8269-a1c582a4dae4.png)

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
