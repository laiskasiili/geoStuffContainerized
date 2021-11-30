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
1. Download and install [docker for desktop](https://www.docker.com/products/docker-desktop). Test that the installation was successful by opening a terminal and typing ```docker --version```.
2. Save the dockerfile somewhere.
3. Open a terminal and navigate to the folder where you saved the dockerfile.
4. Build the image form the dockerfile by running the following command in the terminal:
```docker build -f geostuff.dockerfile . -t geostuffcontainerized:latest```
5. Copy the full path of the folder that contains the data you want to manipulate.
6. Start a container with the following command in your terminal. Replace FULL_PATH_TO_THE_DATA_FOLDER with the full path to your data folder:
```docker run -it --rm --volume=FULL_PATH_TO_THE_DATA_FOLDER:/home/data geostuffcontainerized:latest```
7. You should see your terminal change to something like root@347df44. Congratulations, you are now inside the container! You have access to GDAL via command line (type ```gdalinfo --version```) which also includes ogr2ogr. You have also access to gdal within python. Type```python``` to enter python terminal and then type ```from osgeo import gdal```. If you see no error message, the import worked and you are ready.
8. Leave python terminal by typing ```quit()``` to return to your container terminal. You should be in /home directory. Type ```ls``` and you should see a folder _data_ which contains the same files as the data folder you selected above. In fact, they _are_ the same files! Whatever you write there is both visible in the container as well as in your normal file system.
9. Have fun, and let's hack!
10. When you are done, type ```exit``` in your container's terminal to return back to your normal system terminal. The container will be shut down and destroyed. When you restart the container the data in the data folder will still be there, but the system dependencies will be reset. So feel free to experiment as wildly as you want with the system packages - you cannot destroy anything :D