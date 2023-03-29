#!/bin/bash

# Import nessacary files
source ../constants/constants.bash

color_red() {
    echo -ne "${RED}$1${RESET}"
}

color_green() {
    echo -ne "${GREEN}$1${RESET}"
}

color_yellow() {
    echo -ne "${YELLOW}$1${RESET}"
}

color_cyan() {
    echo -ne "${CYAN}$1${RESET}"
}

color_blue() {
    echo -ne "${BLUE}$1${RESET}"
}

color_magenta() {
    echo -ne "${MAGENTA}$1${RESET}"
}

color_white() {
    echo -ne "${WHITE}$1${RESET}"
}

color_black() {
    echo -ne "${BLACK}$1${RESET}"
}

color_default() {
    echo -ne "${DEFAULT}$1${RESET}"
}

color_reset() {
    echo -ne "${RESET}$1${RESET}"
}