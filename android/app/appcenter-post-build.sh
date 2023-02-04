#!/usr/bin/env bash
##Place this script in project/android/app/
echo ------------- appcenter-post-build.sh called

## copy the APK where AppCenter will find it
#mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/flutter-apk/app-appcenter-release.apk "$_"
## copy the AAB where AppCenter will find it
##mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab "$_"