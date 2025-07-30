FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Change bind-address from 127.0.0.1 to 0.0.0.0 to allow network connections
RUN sed -i 's/bind-address.*= 127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize MySQL data directory and set proper ownership
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]


