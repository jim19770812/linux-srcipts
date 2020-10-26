#!/usr/bin/bash

NEW_DB_FILE=/data/mnt/mysql-`date +%Y%m%d`.sql.gz;
DEL_DB_FILE=/data/mnt/mysql-`date -d '-7 days' "+%Y%m%d"`.sql.gz;

echo 数据库备份开始，目标文件$NEW_DB_FILE
mysqldump -u账号 -p密码 --default-character-set=utf8mb4 --single-transaction --master-data=2 --flush-logs --all-databases | gzip > $NEW_DB_FILE

echo 数据库备份完成，开始检查过期备份文件
if [ -f "$DEL_DB_FILE" ]; then
	rm -f $DEL_DB_FILE
	echo $DEL_DB_FILE文件已删除
fi
echo 数据库备份完成