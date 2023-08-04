#!/bin/bash

################################
## This is a built-in menu to upgrade
# your operating system
################################

# Ensure we are running under bash
if [ "$BASH_SOURCE" = "" ]; then
    /bin/bash "$0"
    exit 0
fi

updating_system() {
    debian() {
        echo "Updating Debian system..."
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get dist-upgrade
        sudo apt-get autoremove
        sudo apt-get autoclean
        echo "Done!"
        return 1
    }

    rhel() {
        echo "Updating RHEL system..."
        sudo dnf upgrade
        sudo dnf autoremove
        echo "Done!"
        return 1
    }

    arch() {
        echo "Updating Arch system..."
        sudo pacman -Syu
        echo "Done!"
        return 1
    }

    exit() {
        echo "Exiting..."
        return 1
    }

    menuItems=(
        "1. Debian"
        "2. Red Hat Enterprise Linux"
        "3. Arch Linux"
        "4. Exit"
    )

    ## Menu Item Actions
    menuActions=(
        debian
        rhel
        arch
        exit
    )

    ## Override some menu defaults
    menuTitle="What system is your operating system based on?"
    menuFooter=" Enter=Select, Navigate via Up/Down/First number/letter"
    menuWidth=60
    menuLeft=25
    menuHighlight=$DRAW_COL_YELLOW

    menuInit
    menuLoop
}