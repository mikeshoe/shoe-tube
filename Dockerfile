FROM ubuntu:16.04

LABEL maintainer="mike@shoesobjects.com"

#Remove apt-get update/upgrade so build process is immutable
RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install -y vim apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-intl mysql-client ffmpeg git libimage-exiftool-perl python curl

WORKDIR /var/www/html

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git /var/www/html/YouPHPTube 
RUN mkdir /var/www/html/YouPHPTube/videos
RUN chmod 777 /var/www/html/YouPHPTube/videos

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube-Encoder.git /var/www/html/YouPHPTube-Encoder
RUN mkdir /var/www/html/YouPHPTube-Encoder/videos
RUN chmod 777 /var/www/html/YouPHPTube-Encoder/videos

#necessary?  RUN chown -R root:root /var/www

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl

RUN chmod a+rx /usr/local/bin/youtube-dl 

#edit apache2.conf
#     /var/www
#     replace AllowOverride None to AllowOverride All
#
# ToDo: copying edited apache2.conf file into container for now
RUN mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
ADD apache2.conf /etc/apache2
RUN chmod 644 /etc/apache2/apache2.conf
RUN a2enmod rewrite

#edit /etc/php/7.0/apache2/php.ini
# max_execution_time - replace 30 with 7200
# post_max_size - replace 8 with 100mb
# upload_max_filesize - replace 2 with 100mb
# memory_limit - replace 128 with 512
#
# ToDo: copying edited php.ini file into container for now
RUN mv /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bak
ADD php.ini /etc/php/7.0/apache2
RUN chmod 644 /etc/php/7.0/apache2/php.ini
RUN /etc/init.d/apache2 stop

#VOLUME ["/var/www/htdocs/videos", "/var/www/htdocs/encoder/videos"]

EXPOSE 80/TCP 443/TCP

CMD apachectl -D FOREGROUND

