FROM php:8.3-apache
RUN apt update && apt install -y jq && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
COPY . /var/www/html/
COPY favicon.ico /var/www/html/
COPY index.html /var/www/html/
COPY api.php /var/www/html/
RUN a2enmod rewrite
COPY .htaccess /var/www/html/
