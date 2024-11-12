#!/bin/sh

# POST PUB.DEV
fvm flutter analyze

fvm flutter test

fvm dart pub login

fvm dart pub publish --dry-run

fvm dart pub publish