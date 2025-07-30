FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server 

# Change bind-address from 127.0.0.1 to 0.0.0.0 to allow network connections
RUN sed -i 's/bind-address.*= 127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start

COPY ./script.sh .
RUN chmod +x script.sh

RUN ./script.sh

CMD /usr/bin/mysqld_safe


