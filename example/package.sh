#!/bin/sh

#fvm flutter clean
#fvm flutter pub get

#android
fvm flutter build apk --debug --target=./lib/main.dart
# ios
fvm flutter build ipa --target=./lib/main.dart --export-method ad-hoc # development（default），ad-hoc，app-store，enterprise
