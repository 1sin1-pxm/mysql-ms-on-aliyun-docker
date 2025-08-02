#!/bin/bash
set -e
DATE=$(date +%F)
BACKUP_DIR="/tmp/mysql_backup"
BUCKET="docker-pxm"

mkdir -p  /tmp/mysql_backup

# 1. dump
docker exec mysql-master mysqldump -uroot -pRoot@123 --all-databases --single-transaction --master-data=2 > $BACKUP_DIR/all-$DATE.sql

# 2. 上传 OSS（需先安装 ossutil）
ossutil cp $BACKUP_DIR/all-$DATE.sql oss://$BUCKET/mysql/

# 3. 只保留 7 天
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
ossutil rm oss://$BUCKET/mysql/ -r -f --include "all-$(date -d '7 days ago' +%F)*"

