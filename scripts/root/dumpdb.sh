#!/bin/bash
adb start-server
adb wait-for-device

adb -d shell "su -c 'cp /data/data/com.whatsapp/databases/msgstore.db /sdcard/msgstore.db'"
adb -d shell "su -c 'cp /data/data/com.whatsapp/databases/wa.db /sdcard/wa.db'"
adb -d shell "su -c 'cp /data/data/com.whatsapp/files/key /sdcard/key'"
#sleep 1

adb -d pull /sdcard/msgstore.db
adb -d pull /sdcard/wa.db
adb -d pull /sdcard/key
echo Files copied
adb -d shell "rm /sdcard/msgstore.db /sdcard/wa.db /sdcard/key"

adb kill-server

