#!/bin/bash

# Ensure we are running under bash
if [ "$BASH_SOURCE" = "" ]; then
    /bin/bash "$0"
    exit 0
fi

. functions/menus.sh
. constants/constants

storeSystem() {

    setDebian() {
        menuSystem="Debian"
    }

    setRHEL() {
        menuSystem="RHEL"
    }

    setArch() {
        menuSystem="Arch"
    }

    menuItems=(
        "1. Debian (Ubuntu, Linux Mint, ElementaryOS)"
        "2. Red Hat Enterprise Linux (Fedora)"
        "3. Arch (Manjaro, Arch Linux)"
        "4. Exit"
    )

    ## Menu Item Actions
    menuActions=(
        setDebian
        setRHEL
        setArch
        exit
    )

    ## Override some menu defaults
    menuTitle=" Please select what system you are on"
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