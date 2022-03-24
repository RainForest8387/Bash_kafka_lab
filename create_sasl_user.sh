#!/bin/bash
. ./functions.sh
user="$1"
password="$2"
add_sasl_user "${user}" "${password}"
exit $?

