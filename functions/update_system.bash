#!/usr/bin/env bash

update_system() {
    echo -ne "
    ${YELLOW}Updating System...${RESET}
    "
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y; sudo snap refresh; flutter upgrade
    echo -ne "
    ${GREEN}System Updated!${RESET}
    "
}