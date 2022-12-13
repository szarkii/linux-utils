#!/bin/bash

APPS_DIR="../apps"
DEFAULT_DEBIAN_PACKAGES_DIR="../debian"
DEBIAN_PACKAGES_DIR="$DEFAULT_DEBIAN_PACKAGES_DIR"
CONTROL_FILE_RELATIVE_PATH="DEBIAN/control"
CONFIGURATION_FILE_PATH="config.sh"

function getFieldValue() {
    filePath="$1"
    fieldName="$2"

    grep "$fieldName" "$filePath" | sed -e "s/$fieldName: *//" 
}

source "$CONFIGURATION_FILE_PATH"

mkdir -p "$DEBIAN_PACKAGES_DIR"
rm -rv "$DEBIAN_PACKAGES_DIR"/*

for appDir in $APPS_DIR/*; do
    controlFilePath="$appDir/$CONTROL_FILE_RELATIVE_PATH"
    appName=$(getFieldValue "$controlFilePath" "Package")
    appVersion=$(getFieldValue "$controlFilePath" "Version")
    debFileName="${appName}_v${appVersion}.deb"
    debFilePath="${DEBIAN_PACKAGES_DIR}/${debFileName}"

    # -Zxz prevents error: archive uses unknown compression for member 'control.tar.zst', giving up
    dpkg-deb -Zxz --build "$appDir"
    mv "$APPS_DIR/$appName.deb" "$DEBIAN_PACKAGES_DIR"
done

cd "$DEBIAN_PACKAGES_DIR"
dpkg-scanpackages . | gzip -c9  > "Packages.gz"
cd -