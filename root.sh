#!/bin/bash

# Get script root (as we are sourced from another script, $0 will not be us)
menuScript=$(readlink -f ${BASH_SOURCE[0]})
menuRoot=$(dirname "$menuScript")