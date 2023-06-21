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

################################
## They should return 1 to indicate that the menu
## should continue, or return 0 to signify the menu
## should exit.
################################

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
        sudo dnf update
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
        startmenu
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

exitmenu() {
    echo "Exiting..."
    exit 1
}

################################
## Setup Example Menu
################################

## Menu Item Text
##
## It makes sense to have "Exit" as the last item,
## as pressing Esc will jump to last item (and
## pressing Esc while on last item will perform the
## associated action).
##
## NOTE: If these are not all the same width
##       the menu highlight will look wonky
##       (but it will still work).

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