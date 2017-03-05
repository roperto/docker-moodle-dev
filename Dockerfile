# Start from Ubuntu
FROM ubuntu
MAINTAINER Daniel Thee Roperto <daniel@theeroperto.com>

# Install dependencies
RUN apt-get -y update
RUN apt-get -y install apache2
RUN apt-get -y install git
RUN apt-get -y install php libapache2-mod-php

# Copy files to container
COPY moodle/. /var/www/moodle

# Install Moodle
RUN mv /var/www/moodle/moodle.conf /etc/apache2/sites-available/
RUN chmod -R 2777 /var/www/moodle
RUN a2ensite moodle

# Start services
CMD /usr/sbin/apache2ctl -D FOREGROUND
