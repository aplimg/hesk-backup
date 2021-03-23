#!/bin/sh
#
# heskbackup.sh
# Steven R. Stuart, Applied Imagination, Inc. 23mar2021
#
# create backup files in /var/bak/hesk/DOW/ with names like:
# 23Mar2021-heskdb.sql.gz  23Mar2021-heskfiles.gz

DOW=$(date +%a)
NOW=$(date +%d%b%Y)
DEST="/var/bak/hesk.bak/$DOW"
echo $DEST

mkdir -p $DEST
rm -rf $DEST/*

mysqldump --opt hesk | gzip > $DEST/$NOW-heskdb.sql.gz

tar czf $DEST/$NOW-heskfiles.tgz /var/www/hesk/*

# Push a copy to the NAS
USR=admin
RMT=10.10.10.250
ssh $USR@$RMT mkdir -p hesk.bak/$DOW
ssh $USR@$RMT rm -rf hesk.bak/$DOW/*
scp $DEST/* $USR@$RMT:hesk.bak/$DOW/

# end
