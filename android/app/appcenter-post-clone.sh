#!/usr/bin/env bash
#Place this script in project/android/app/
echo ------------- appcenter-post-clone.sh called

cd ..
# fail if any command fails
set -e
# debug log
set -x
cd ..

echo FLUTTER_ROOT="${FLUTTER_ROOT}"
if [[ -z "${FLUTTER_ROOT}" ]]; then
  echo Downloading Flutter ...
  git clone https://github.com/flutter/flutter.git
  export PATH=${PWD}/flutter/bin:$PATH
  flutter channel stable
  flutter upgrade
  echo "------- installed flutter to <n>------- ${PWD}/flutter"
else
  echo Flutter exist already, skipping download
fi

echo "------- calling config.sh ..."
./config.sh

echo "------- building APK ..."
flutter precache
flutter pub get


#if [[ ! -z "${FLUTTER_ROOT}" ]]; then

  # if you get "Execution failed for task ':app:lintVitalRelease'." error, uncomment next two lines
  flutter build apk --debug --no-sound-null-safety --flavor appCenter
  flutter build apk --profile --no-sound-null-safety --flavor appCenter
  flutter build apk --release --no-sound-null-safety --flavor appCenter

  # if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
  #flutter build appbundle --release --build-number $APPCENTER_BUILD_ID

  # copy the APK where AppCenter will find it
  mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/flutter-apk/app-appcenter-release.apk "$_"
  # copy the AAB where AppCenter will find it
  #mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab "$_"

#fi

echo appcenter-post-clone done