#!/bin/bash

cat <<'EOS' | mysql -uroot
CREATE USER 'repl'@'%' IDENTIFIED BY 'replic@ti0n';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

GRANT SUPER, REPLICATION CLIENT ON *.* TO 'mha'@'%';
EOS

cat <<EOS | tee /etc/mysql/conf.d/slave.cnf
[mysqld]
server_id=$(( ( RANDOM % 4294967295 )  + 1 ))
EOS
