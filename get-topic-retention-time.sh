#!/bin/bash
. ./functions.sh
topic_name=$1
describe_topic_config "${topic_name}" | awk 'BEGIN{IFS="=";IRS=" "} /^[ ]*retention.ms/{print $1}'
exit $?