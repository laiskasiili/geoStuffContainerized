# geoStuffContainerized

## What is this about?
Installing GDAL with python bindings for a workshop is painful:
- Participants have different hardware and OS.
- Participants have different python version.
- Participants might already have some globally installed (potentially conflicting) versions of the software of interest installed, e.g. from a QGIS installation.
- GDAL usually requires fiddling around with system paths.
- We do NOT want to mess up participant's computers in any way, e.g. by fiddling around with system paths.
- The setup should be easy and fast - also for non technical participants.
- The setup should be reproducible and documented, so that participants can make use of it even after the course.

Luckily container technology has matured to the point by now where it is a viable solution to address all points above.

## Setup guide

### Wait, give me the high level picture first


### Step-by-step guide
1. Download and install [docker for desktop](https://www.docker.com/products/docker-desktop). After the installation you can close the graphical Docker Desktop User Interface, we don't need it and it runs in the background. Test that the installation was successful by opening a terminal and typing ```docker --version```.
> _Good to know_: If you get an error message mentioning a _daemon_, make sure Docker Desktop is running (search for Docker Desktop and click to start the application).
2. Download this [repository as zip](https://github.com/laiskaSiili/geoStuffContainerized/archive/refs/heads/main.zip) and unzip it.
> _Good to know_: If you are versed in git, you can of course just clone the repository.
3. Open a terminal and navigate to the folder where you unziped the downloaded repository. You want to be in the same folder as the so called Dockerfile:  _geostuff.dockerfile_
4. In the terminal run the following command to build an image. This may take some time, but it is a one-time thing:
```docker build -t geostuffcontainerized:latest -f geostuff.dockerfile .```
5. Start a container with the following command in your terminal. Replace FULL_PATH_TO_YOUR_DATA_FOLDER with the full path of the folder that contains the data you want to manipulate:
```docker run -it --rm --volume="FULL_PATH_TO_YOUR_DATA_FOLDER":"/home/data" geostuffcontainerized:latest```
> _Just an example_: ```docker run -it --rm --volume="C:\Users\laiskaSiili\mydata":"/home/data" geostuffcontainerized:latest```
6. You should see your terminal change to something like root@3b1bf65. __Congratulations, you are now inside the container, inside your a new small universe!__ You should be in /home directory. Type ```ls``` and you should see a folder _data_ which contains the same files as the data folder you specified the full path to above. In fact, they _are_ the same files! Whatever you write in this data folder is both visible in the container as well as in your normal file system.
> _Good to know_: If you are a windows user you might quickly notice strange things when working in this container terminal. Paths need to be specified with forward slashes, the commands to list items is ```ls``` instead of ```dir``` and pasting stuff is no longer Ctrl+V but rather a simple right click. What is going on??? The container you are working in is actually a linux ubuntu system! Embrace the light side of the force and google the linux shell commands if needed!
7. You have access to GDAL via command line (type ```gdalinfo --version```) which also includes ogr2ogr. You have also access to gdal within python. Type ```python``` to enter python terminal and then type ```from osgeo import gdal```. If you see no error message, the import worked and you are ready. Leave python terminal by typing ```quit()``` to return to your container terminal.
8. When you are done, type ```exit``` in your container's terminal to return back to your normal system terminal. The container will be shut down and destroyed. When you restart the container the data in the data folder will still be there, but the system dependencies will be reset. So feel free to experiment as wildly as you want with the system packages - you cannot destroy anything!