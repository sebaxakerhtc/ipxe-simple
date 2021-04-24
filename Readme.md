Easy iPXE Building from source code
===================================
### You need Docker installed for this project!

## Demo
#### You can see demo and download the latest images at [ipxe.pcserviceburgas.com](https://ipxe.pcserviceburgas.com/)
#### This build uses crontab to rebuild iPXE every 6 hours, so you can use the latest images from there!
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
docker run --name ipxe-simple -p 80:80 -d sebaxakerhtc/ipxe-simple
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

## Screenshots
![1](https://user-images.githubusercontent.com/32651506/115465918-fa3af180-a237-11eb-9c42-37836427de60.jpg)
![3](https://user-images.githubusercontent.com/32651506/115466141-53a32080-a238-11eb-9e6f-9650f6ace9fe.jpg)
![2](https://user-images.githubusercontent.com/32651506/115465033-a4197e80-a236-11eb-9ad3-ba6e45c2ea24.png)
![4](https://user-images.githubusercontent.com/32651506/115465170-d75c0d80-a236-11eb-81b4-233386f17305.png)
![5](https://user-images.githubusercontent.com/32651506/115465172-d925d100-a236-11eb-8269-a1c582a4dae4.png)

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
