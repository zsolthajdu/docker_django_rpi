#################################################
# Dockerfile to build Python-Django WSGI Application Containers
# for Raspberry Pi
# Based on Raspbian Jessie
#

# Set the base image to Ubuntu
FROM resin/rpi-raspbian:jessie

# File Author / Maintainer
MAINTAINER z_hajdu@yahoo.com

# Update the sources list
RUN apt-get update
RUN apt-get install build-essential

# Install basic applications
RUN apt-get install -y aptitude apt-utils apache2  libapache2-mod-wsgi-py3

# Install Python and Basic Python Tools
RUN apt-get install -y python3 wget

RUN apt-get install -y python3-pip

#RUN pip install --upgrade pip

# Get pip to download and install requirements:

RUN pip3 install django==1.10
ENV DJANGO_VER 110
ENV PYTHON_VER 34

#install MySQL in noninteractive way
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -qy -t jessie python-dev
RUN apt-get install -qy python3-dev
RUN apt-get install -qy libmysqlclient-dev

RUN pip3 install pymysql mysqlclient


