# Start from Ubuntu
FROM ubuntu
MAINTAINER Daniel Thee Roperto <daniel@theeroperto.com>

# Install dependencies
RUN apt-get -y update
RUN apt-get -y install apache2
RUN apt-get -y install git

# Copy files
COPY moodle/. /var/www/moodle
#COPY moodle/.git /var/www/moodle/.git

# Start services
CMD /usr/sbin/apache2ctl -D FOREGROUND
