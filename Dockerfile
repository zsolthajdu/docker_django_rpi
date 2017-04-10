#################################################
# Dockerfile to build Python-Django WSGI Application Containers
# for Raspberry Pi
# Based on Raspbian Jessie
#

# Set the base image to Ubuntu
FROM resin/rpi-raspbian:jessie

# File Author / Maintainer
MAINTAINER z_hajdu@yahoo.com


# The path where the django app is stored
ENV APP_PATH /usr/src/app

# Main Django dir under APP_PATH, that stores wsgi.py, settings.py, etc.
ENV SITE_DIR mysite

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

COPY start.sh /
RUN chmod a+x /start.sh

#expose the port
EXPOSE 80

# Configure apache to run django app under /usr/src/app
RUN echo "WSGIScriptAlias / /usr/src/app/THE_SITE_DIR/wsgi.py" >> /etc/apache2/apache2.conf && \
echo "WSGIPythonPath /usr/src/app/" >> /etc/apache2/apache2.conf &&  \
echo "Alias /static/ /usr/src/app/static/" >> /etc/apache2/apache2.conf &&  \
echo "<Directory /usr/src/app/>" >> /etc/apache2/apache2.conf &&  \
echo " <Files wsgi.py>" >> /etc/apache2/apache2.conf &&  \
echo "  Order deny,allow" >> /etc/apache2/apache2.conf &&  \
echo "  Require all granted" >> /etc/apache2/apache2.conf && \
echo "  Satisfy Any" >> /etc/apache2/apache2.conf && \
echo " </Files>" >> /etc/apache2/apache2.conf && \
echo "</Directory>" >> /etc/apache2/apache2.conf && \
echo "<Directory /usr/src/app/static/>" >> /etc/apache2/apache2.conf &&  \
echo "  Require all granted" >> /etc/apache2/apache2.conf && \
echo "</Directory>" >> /etc/apache2/apache2.conf

ENTRYPOINT ["/start.sh"]

