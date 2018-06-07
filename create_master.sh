#!/bin/bash

cat <<EOS | tee /etc/mysql/conf.d/repl.cnf
[mysqld]
log_bin=node
server_id=$(( ( RANDOM % 4294967295 )  + 1 ))
relay_log=relay_node
EOS

cat <<'EOS' | mysql -uroot
CREATE USER 'repl'@'%' IDENTIFIED BY 'replic@ti0n';
GRANT SELECT, REPLICATION SLAVE ON *.* TO 'repl'@'%';

GRANT RELOAD, SUPER ON *.* TO 'mha'@'%';
GRANT SELECT ON `mysql`.* TO 'mha'@'%';
GRANT ALL PRIVILEGES ON `mysql`.`apply_diff_relay_logs` TO 'mha'@'%';
GRANT ALL PRIVILEGES ON `mysql`.`apply_diff_relay_logs_test` TO 'mha'@'%';
EOS
