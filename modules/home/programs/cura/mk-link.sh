#!/usr/bin/env bash

CURA_VERSION=5.8
CURA_BASE="$HOME/.var/app/com.ultimaker.cura"

# https://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

makeCuraLink()
{
    ln -s "$SCRIPTPATH/config/$1" "$CURA_BASE/data/cura/$CURA_VERSION/$1"
}

ln -s "$SCRIPTPATH/config/cura_config" "$CURA_BASE/config/cura/$CURA_VERSION"

makeCuraLink "definition_changes"
makeCuraLink "extruders"
makeCuraLink "machine_instances"
makeCuraLink "materials"
makeCuraLink "user"