#!/bin/bash
adb start-server
adb wait-for-device

echo
echo "Press the backup button. Don't put a password."
echo

adb shell am force-stop com.whatsapp
adb pull /data/app/com.whatsapp-2/base.apk whatsappcurrent.apk
adb install -r -d whatsapp211.apk
adb backup -noapk -f whatsapp.ab com.whatsapp
adb install -r whatsappcurrent.apk

( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 whatsapp.ab ) |  tar xfvz -

cp apps/com.whatsapp/db/msgstore.db ../../whatsapp/src/main/resources/msgstore.db
cp apps/com.whatsapp/db/wa.db ../../whatsapp/src/main/resources/wa.db

adb kill-server
