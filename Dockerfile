FROM ubuntu:16.04

LABEL maintainer="mike@shoesobjects.com"

EXPOSE 80/TCP

RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-intl mysql-client ffmpeg git libimage-exiftool-perl python curl

WORKDIR /var/www/html

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git /var/www/html/YouPHPTube 

RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube-Encoder.git /var/www/html/YouPHPTube-Encoder

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl

RUN chmod a+rx /usr/local/bin/youtube-dl 

RUN a2enmod rewrite
