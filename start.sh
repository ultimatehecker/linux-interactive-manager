#!/bin/bash

# Ensure we are running under bash
if [ "$BASH_SOURCE" = "" ]; then
    /bin/bash "$0"
    exit 0
fi

# Load bash-menu script
#
# NOTE: Ensure this is done before using
#       or overriding menu functions/variables.

. functions/menus.sh
. constants/constants

################################
## First time setup
################################

if [!menuSystem]; then
    storeSystem
fi

startmenu() {
    menuItems=(
        "1. Update your system"
        "2. Exit"
    )

    ## Menu Item Actions
    menuActions=(
        updating_system
        exitmenu
    )

    ## Override some menu defaults
    menuTitle=" Welcome to the Linux System Manager! Select an option:"
    menuFooter=" Enter=Select, Navigate via Up/Down/First number/letter"
    menuWidth=60
    menuLeft=25
    menuHighlight=$DRAW_COL_YELLOW


    ################################
    ## Run Menu
    ################################

    menuInit
    menuLoop

    exit 0
}

startmenu