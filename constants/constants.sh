#!/bin/bash

# Ensure we are running under bash (will not work under sh or dash etc)
if [ "$BASH_SOURCE" = "" ]; then
    echo "ERROR: bash-draw requires to be running under bash"
    exit 1
fi

################################
# These should not be overridden
################################

declare -a menuItems
declare -a menuActions

menuHeaderText=""
menuFooterText=""
menuBorderText=""

################################
# These are defaults which should
# be overridden as required.
################################

# Top of menu (row 2)
menuTop=2

# Left offset for menu items (not border)
menuLeft=15

# Width of menu
menuWidth=42

# Left offset for menu border (not menu items)
menuMargin=4

menuItems[0]="Exit"
menuActions[0]="return 0"

menuItemCount=1
menuLastItem=0

menuColour=$DRAW_COL_WHITE
menuHighlight=$DRAW_COL_GREEN

menuTitle=" Super Bash Menu System"
menuFooter=" Enter=Select, Up/Down=Prev/Next Option"