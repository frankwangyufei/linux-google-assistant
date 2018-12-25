#!/bin/bash
PRG=$0
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
    if expr "$link" : '^/' 2> /dev/null >/dev/null; then
        PRG="$link"
    else
        PRG="`dirname "$PRG"`/$link"
    fi
done

INSTALL_BIN=`dirname "$PRG"`

# absolutize dir
oldpwd=`pwd`
cd "${INSTALL_BIN}"
INSTALL_BIN=`pwd`
cd "${oldpwd}"

ICON_NAME=google-assistant
TMP_DIR=`mktemp --directory`
DESKTOP_FILE=$TMP_DIR/google-assistant.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=Google Assistant
Keywords=Google
Comment=Google Assistant
Type=Application
Terminal=false
Exec="$INSTALL_BIN/google-assistant.sh"
Icon=$ICON_NAME.png
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --size 512 "$INSTALL_BIN/google-assistant.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
