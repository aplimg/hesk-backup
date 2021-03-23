#!/bin/sh
#
# heskbackup.sh
# Steven R. Stuart, Applied Imagination, Inc. 23mar2021
#
# create backup files in /var/bak/hesk/DOW/ with names like:
# 23Mar2021-heskdb.sql.gz  23Mar2021-heskfiles.gz

DOW=$(date +%a)
NOW=$(date +%d%b%Y)
DEST="/var/bak/hesk/$DOW"
#echo $DEST

mkdir -p $DEST
rm -rf $DEST/*

mysqldump --opt hesk | gzip > $DEST/$NOW-heskdb.sql.gz

tar czf $DEST/$NOW-heskfiles.tgz /var/www/hesk/*


