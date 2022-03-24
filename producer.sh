#!/bin/bash
. ./functions.sh
topic_name="$1"
message="$2"

produce_message ${topic_name} ${message}
exit $?