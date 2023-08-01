#!/bin/bash

. root.sh

# Ensure we are running under bash (will not work under sh or dash etc)
if [ "$BASH_SOURCE" = "" ]; then
    echo "ERROR: bash-menu requires to be running under bash"
    exit 1
fi

# Ensure we can access our dependencies
if [ ! -s "$menuRoot/functions/draw.sh" ]; then
    echo "ERROR: Missing required draw.sh script"
    exit 1
fi

# Load terminal drawing functions
. "$menuRoot/functions/draw.sh"

# Load terminal drawing constants
. "$menuRoot/constants/colors.sh"
. "$menuRoot/constants/constants.sh"

################################
# Initialise Menu
################################

menuInit() {
    menuItemCount=${#menuItems[@]}
    menuLastItem=$((menuItemCount-1))

    # Ensure header and footer are padded appropriately
    menuHeaderText=`printf "%-${menuWidth}s" "$menuTitle"`
    menuFooterText=`printf "%-${menuWidth}s" "$menuFooter"`

    # Menu (side) borders
    local marginSpaces=$((menuMargin-1))
    local menuSpaces=$((menuWidth-2))
    local leftGap=`printf "%${marginSpaces}s" ""`
    local midGap=`printf "%${menuSpaces}s" ""`
    menuBorderText="${leftGap}x${midGap}x"
}

################################
# Show Menu
################################

menu_Display() {
    local menuSize=$((menuItemCount+2))
    local menuEnd=$((menuSize+menuTop+1))

    drawClear
    drawColour $menuColour $menuHighlight

    # Menu header
    drawHighlightAt $menuTop $menuMargin "$menuHeaderText" 1

    # Menu (side) borders
    for row in $(seq 1 $menuSize); do
        drawSpecial "$menuBorderText" 1
    done

    # Menu footer
    drawHighlightAt $menuEnd $menuMargin "$menuFooterText" 1

    # Menu items
    for item in $(seq 0 $menuLastItem); do
        menu_ClearItem $item
    done
}

################################
# Mark Menu Items
################################

# Ensure menu item is not highlighted
menu_ClearItem() {
    local item=$1
    local top=$((menuTop+item+2))
    local menuText=${menuItems[$item]}

    drawPlainAt $top $menuLeft "$menuText"
}

# Highlight menu item
menu_HighlightItem() {
    local item=$1
    local top=$((menuTop+item+2))
    local menuText=${menuItems[$item]}

    drawHighlightAt $top $menuLeft "$menuText"
}


################################
# Wait for and process user input
################################

menu_HandleInput() {
    local choice=$1

    local after=$((choice+1))
    [[ $after -gt $menuLastItem ]] && after=0

    local before=$((choice-1))
    [[ $before -lt 0 ]] && before=$menuLastItem

    # Clear highlight from prev/next menu items
    menu_ClearItem $before
    menu_ClearItem $after

    # Highlight current menu item
    menu_HighlightItem $choice

    # Get keyboard input
    local key=""
    local extra=""

    read -s -n1 key 2> /dev/null >&2
    while read -s -n1 -t .05 extra 2> /dev/null >&2 ; do
        key="$key$extra"
    done

    # Handle known keys
    local escKey=`echo -en "\033"`
    local upKey=`echo -en "\033[A"`
    local downKey=`echo -en "\033[B"`

    if [[ $key = $upKey ]]; then
        return $before
    elif [[ $key = $downKey ]]; then
        return $after
    elif [[ $key = $escKey ]]; then
        if [[ $choice -eq $menuLastItem ]]; then

            # Pressing Esc while on last menu item will trigger action
            # This is a helper as we assume the last menu option is exit
            key=""
        else
            # Jumping possibly more than 1 (next/prev) item
            menu_ClearItem $choice
            return $menuLastItem
        fi
    elif [[ ${#key} -eq 1 ]]; then

        # See if we wanrt to jump to a menu item
        # by entering the first character
        for index in $(seq 0 $menuLastItem) ; do
            local item=${menuItems[$index]}
            local startChar=${item:0:1}
            if [[ "$key" = "$startChar" ]]; then
                # Jumping possibly more than 1 (next/prev) item
                menu_ClearItem $choice
                return $index
            fi
        done
    fi

    if [[ "$key" = "" ]]; then
        # Notify that Enter key was pressed
        return 255
    fi

    return $choice
}

################################
# Main Menu Loop
################################

menuLoop() {
    local choice=0
    local running=1

    menu_Display

    while [[ $running -eq 1 ]]; do
        # Enable case insensitive matching
        local caseMatch=`shopt -p nocasematch`
        shopt -s nocasematch

        menu_HandleInput $choice
        local newChoice=$?

        # Revert to previous case matching
        $caseMatch

        if [[ $newChoice -eq 255 ]]; then
            # Enter pressed - run menu action
            drawClear
            action=${menuActions[$choice]}
            $action
            running=$?

            # Back from action
            # If we are still running, redraw menu

            [[ $running -eq 1 ]] && menu_Display

        elif [[ $newChoice -lt $menuItemCount ]]; then
            # Update selected menu item
            choice=$newChoice
        fi
    done

    # Cleanup screen
    drawClear
}