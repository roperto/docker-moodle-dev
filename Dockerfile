# Start from Ubuntu
FROM ubuntu
MAINTAINER Daniel Thee Roperto <daniel@theeroperto.com>

# Install dependencies
RUN apt-get -y update
RUN apt-get -y install apache2

# Start services
CMD /usr/sbin/apache2ctl -D FOREGROUND
