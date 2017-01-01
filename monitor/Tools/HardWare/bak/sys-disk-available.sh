#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
GetInfo "touch ~/.TouchTest.file 2>&1"
