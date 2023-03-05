#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
REPOSITORY_PATH="$SCRIPT_PATH/.."
APPS_DIR="$REPOSITORY_PATH/apps"
DEFAULT_DEBIAN_PACKAGES_DIR="$REPOSITORY_PATH/debian"
DEBIAN_PACKAGES_DIR="$DEFAULT_DEBIAN_PACKAGES_DIR"
CONTROL_FILE_RELATIVE_PATH="DEBIAN/control"
CONFIGURATION_FILE_PATH="$SCRIPT_PATH/config.sh"
EXECUTABLES_DIR="usr/bin"

function getFieldValue() {
    filePath="$1"
    fieldName="$2"

    grep "$fieldName" "$filePath" | sed -e "s/$fieldName: *//" 
}

# Update repository
cd "$REPOSITORY_PATH"
git pull
cd -

[ -f "$CONFIGURATION_FILE_PATH" ] && source "$CONFIGURATION_FILE_PATH"

mkdir -p "$DEBIAN_PACKAGES_DIR"
[ -d "$DEBIAN_PACKAGES_DIR" ] && rm -rv "$DEBIAN_PACKAGES_DIR"/*

for appDir in $APPS_DIR/*; do
    controlFilePath="$appDir/$CONTROL_FILE_RELATIVE_PATH"
    appName=$(getFieldValue "$controlFilePath" "Package")
    appVersion=$(getFieldValue "$controlFilePath" "Version")
    debFileName="${appName}_v${appVersion}.deb"
    debFilePath="${DEBIAN_PACKAGES_DIR}/${debFileName}"

    [ -d "$appDir/$EXECUTABLES_DIR" ] && chmod +x -v "$appDir/$EXECUTABLES_DIR/"*

    # -Zxz prevents error: archive uses unknown compression for member 'control.tar.zst', giving up
    dpkg-deb --build --root-owner-group -Zxz "$appDir"
    mv "$APPS_DIR/$appName.deb" "$DEBIAN_PACKAGES_DIR"
done

# Update packages
cd "$DEBIAN_PACKAGES_DIR"
dpkg-scanpackages . | gzip -c9  > "Packages.gz"
