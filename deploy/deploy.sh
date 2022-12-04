#!/bin/bash

APPS_DIR="../apps"
DEBIAN_PACKAGES_DIR="../debian"
CONTROL_FILE_RELATIVE_PATH="DEBIAN/control"

function getFieldValue() {
    filePath="$1"
    fieldName="$2"

    grep "$fieldName" "$filePath" | sed -e "s/$fieldName: *//" 
}

mkdir -p $DEBIAN_PACKAGES_DIR

for appDir in $APPS_DIR/*; do
    controlFilePath="$appDir/$CONTROL_FILE_RELATIVE_PATH"
    appName=$(getFieldValue "$controlFilePath" "Package")
    appVersion=$(getFieldValue "$controlFilePath" "Version")
    debFileName="${appName}_v${appVersion}.deb"
    debFilePath="${DEBIAN_PACKAGES_DIR}/${debFileName}"

    dpkg-deb --build "$appDir"
    mv "$APPS_DIR/$appName.deb" "$DEBIAN_PACKAGES_DIR"
    
    # if [[ ! -f "$debFilePath" ]]; then
        # dpkg-deb --build "$appDir" "$debFilePath"
    # fi
done

dpkg-scanpackages $DEBIAN_PACKAGES_DIR | gzip -c9  > "${DEBIAN_PACKAGES_DIR}/Packages.gz"