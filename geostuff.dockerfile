FROM python:3.9-slim-bullseye

LABEL Description="Setup a container with gdal and python bindings."

WORKDIR /home

# Install GDAL
RUN apt update && apt install -y binutils libproj-dev gdal-bin libgdal-dev

# Install Python GDAL bindings
# Kudos to these people:
# https://gis.stackexchange.com/questions/28966/python-gdal-package-missing-header-file-when-installing-via-pip
RUN apt install -y python3-dev build-essential
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal
RUN pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

CMD ["/bin/bash"]
