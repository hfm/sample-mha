#!/bin/bash

while ! mysqladmin ping -urepl -preplic@ti0n -hnode_master --silent 2>/dev/null; do
    sleep 3
done

mysqldump -uroot -hnode_master --all-databases --single-transaction --flush-logs --events > /tmp/master_dump.sql

while ! mysqladmin ping -uroot --silent; do
    sleep 3
done

mysql -uroot < /tmp/master_dump.sql

log_file=$(mysql -BN -uroot -hnode_master -e "SHOW MASTER STATUS" | awk '{print $1}')
log_pos=$(mysql -BN -uroot -hnode_master -e "SHOW MASTER STATUS" | awk '{print $2}')

cat <<EOS | mysql -uroot
CHANGE MASTER TO
    MASTER_HOST='node_master',
    MASTER_USER='repl',
    MASTER_PASSWORD='replic@ti0n',
    MASTER_LOG_FILE='${log_file}',
    MASTER_LOG_POS=${log_pos};

START SLAVE;
EOS

sleep 1

echo 'SHOW SLAVE STATUS\G' | mysql -uroot
