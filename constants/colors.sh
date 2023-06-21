#!/bin/bash

# Ensure we are running under bash (will not work under sh or dash etc)
if [ "$BASH_SOURCE" = "" ]; then
    echo "ERROR: bash-draw requires to be running under bash"
    exit 1
fi


DRAW_COL_DEF=39
DRAW_COL_BLACK=30
DRAW_COL_WHITE=97
DRAW_COL_RED=31
DRAW_COL_GREEN=32
DRAW_COL_YELLOW=33
DRAW_COL_BLUE=34
DRAW_COL_GRAY=37