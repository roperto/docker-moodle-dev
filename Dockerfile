# Start from Ubuntu
FROM ubuntu
MAINTAINER Daniel Thee Roperto <daniel@theeroperto.com>

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install git apache2 php libapache2-mod-php mysql-server
RUN apt-get -y install php-mysql php-xml php-curl php-zip php-gd php-mbstring php-xmlrpc php-soap php-intl

# Fetch moodle
RUN git clone --progress --verbose https://github.com/moodle/moodle.git /var/www/moodle/html

# Copy files to container
COPY moodle/. /var/www/moodle

# Install Moodle
RUN mv /var/www/moodle/moodle.conf /etc/apache2/sites-available/
RUN mv /var/www/moodle/config.php /var/www/moodle/html
RUN chmod -R 2777 /var/www/moodle
RUN a2ensite moodle
RUN service mysql start \
	&& sleep 5 \
	&& echo CREATE DATABASE moodle\; | mysql \
	&& php /var/www/moodle/html/admin/cli/install_database.php --adminpass=admin --adminemail=admin@moodle.docker.test --agree-license --fullname="Docker Moodle Site" --shortname="DockerMoodle"

# Start services
CMD service mysql restart && /usr/sbin/apache2ctl -D FOREGROUND
