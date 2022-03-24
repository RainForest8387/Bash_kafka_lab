#!/bin/bash
. ./functions.sh
topic_name="$1"
#format for config_name_and_value var is name=value, for example retention.ms=86400000
config_name_and_value="$2"
set_topic_config ${topic_name} ${config_name_and_value}
exit $?