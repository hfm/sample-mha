#!/bin/bash

cat <<EOS | tee /etc/mysql/conf.d/repl.cnf
[mysqld]
log_bin=node
server_id=$(( ( RANDOM % 4294967295 )  + 1 ))
relay_log=relay_node
EOS

cat <<'EOS' | mysql -uroot
CREATE USER 'repl'@'%' IDENTIFIED BY 'replic@ti0n';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

GRANT SUPER, REPLICATION CLIENT ON *.* TO 'mha'@'%';
EOS
