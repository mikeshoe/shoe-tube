FROM ubuntu:16.04

LABEL maintainer="mike@shoesobjects.com"

#Remove apt-get update/upgrade so build process is immutable
RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install -y vim apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-intl mysql-client ffmpeg git libimage-exiftool-perl python curl

WORKDIR /var/www/html

#remove pid or container won't start
#RUN rm /run/apache2/apache2.pid

#remove default index page
RUN rm /var/www/html/index.html

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git /var/www/html/ 
RUN mkdir /var/www/html/videos
RUN chmod 777 /var/www/html/videos

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube-Encoder.git /var/www/html/encoder
RUN mkdir /var/www/html/encoder/videos
RUN chmod 777 /var/www/html/encoder/videos

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl

RUN chmod a+rx /usr/local/bin/youtube-dl 

ADD entrypoint.sh /usr/local/bin
RUN chmod a+rx /usr/local/bin/entrypoint.sh

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

EXPOSE 80/TCP 443/TCP

CMD ["entrypoint.sh"]