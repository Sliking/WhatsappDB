#!/bin/bash
adb start-server
adb wait-for-device

echo "Press the backup button. Don't put a password."

adb shell am force-stop com.whatsapp
adb pull /data/app/com.whatsapp-2/base.apk whatsappcurrent.apk
adb install -r -d whatsapp211.apk
adb backup -noapk -f whatsapp.ab com.whatsapp

( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 whatsapp.ab ) |  tar xfvz -

adb install -r whatsappcurrent.apk

adb kill-server
