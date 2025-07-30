FROM debian:bullseye
RUN apt-get update && apt-get install -y \
nginx \
openssl 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE/L=Heilbronn/O=42/OU=student/CN=localhost" -addext "subjectAltName=DNS:localhost,DNS:rmakoni.42.fr,DNS:www.rmakoni.42.fr"

COPY ./conf /etc/nginx/sites-available/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
