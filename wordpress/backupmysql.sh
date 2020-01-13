#!/bin/bash

# バックアップの保存期間(days)
PERIOD=3

# バックアップ保存用ディレクトリの指定
DIRPATH='/mysql/backup'

# ファイル名を指定する(※ファイル名で日付がわかるようにしておきます)
FILENAME=`date +%y%m%d`

# 指定したDBのスキーマおよびデータをすべて吐き出す
mysqldump -u root --password=password -h localhost wordpress > $DIRPATH/$FILENAME.sql

# パーミッション変更
sudo chmod 700 $DIRPATH/$FILENAME.sql

# 保存期間を過ぎたバックアップを削除
OLDFILE=`date --d "$PERIOD days ago" +%y%m%d`
sudo rm -f $DIRPATH/$OLDFILE.sql
