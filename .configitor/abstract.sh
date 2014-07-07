#!/bin/sh

if [ -z $CONFIGITOR_BASE_DIR ]; then
    echo "Please provide an env variable: CONFIGITOR_BASE_DIR, e.g.:"
    echo "export CONFIGITOR_BASE_DIR=<absolute path to the configitor base dir>"
    exit 1
fi
if [ ! -f $CONFIGITOR_BASE_DIR/.configitor/abstract.sh ]; then
    echo "Invalid env variable: CONFIGITOR_BASE_DIR. It does not point to the"
    echo "configitor project. Please provide an absolute path to configitor dir:"
    echo "export CONFIGITOR_BASE_DIR=<absolute path to the configitor base dir>"
    exit 1
fi

current_dir=`dirname "$BASH_SOURCE"`
. $CONFIGITOR_BASE_DIR/.configitor/abstract/methods.sh
. $CONFIGITOR_BASE_DIR/.configitor/abstract/variables/static.sh
. $CONFIGITOR_BASE_DIR/.configitor/abstract/variables/global.sh
