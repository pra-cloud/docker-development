FROM 606244583710.dkr.ecr.eu-west-2.amazonaws.com/hyperzod-php8.1:latest

WORKDIR /var/www/html/

RUN rm -rf /var/www/html/*

COPY ../* /var/www/html/

RUN ls -la /var/www/html/routes/*


#COPY start_octane.sh /usr/local/bin/start_octane.sh


#RUN chmod +x /usr/local/bin/start_octane.sh

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

RUN ls -la

#RUN composer install --no-scripts --no-autoloader --ansi --no-interaction


RUN chown -R root:root /var/www/html/

#install nginx

RUN apk update && apk add nginx

COPY ./nginx/nginx.conf /etc/nginx/

RUN rm -rfv /etc/nginx/conf.d/default.conf

COPY ./supervisor/supervisord.conf /etc/supervisord.conf

COPY start_octane.sh /usr/local/bin/start_octane.sh

RUN chmod +x /usr/local/bin/start_octane.sh

ARG ONGOING_ENVIRONMENT=production
ENV ONGOING_ENVIRONMENT=${ONGOING_ENVIRONMENT}


# COPY startup.sh /usr/local/bin/startup.sh

# RUN chmod +x /usr/local/bin/startup.sh

#RUN chmod +x start.sh

EXPOSE 80


# CMD ["/usr/local/bin/startup.sh"]

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
