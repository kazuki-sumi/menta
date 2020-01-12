#!/bin/bash

# バックアップの保存期間(days)
period=3

# バックアップ保存用ディレクトリの指定
dirpath='/mysql/backup'

# ファイル名を指定する(※ファイル名で日付がわかるようにしておきます)
filename=`date +%y%m%d`

# 指定したDBのスキーマおよびデータをすべて吐き出す
mysqldump -u root --password=password -h localhost wordpress > $dirpath/$filename.sql

# パーミッション変更
sudo chmod 700 $dirpath/$filename.sql

# 保存期間を過ぎたバックアップを削除
oldfile=`date --d "$period days ago" +%y%m%d`
sudo rm -f $dirpath/$oldfile.sql
