#!/bin/bash
. ./functions.sh
topic_name=$1
create_topic "${topic_name}"
exit $?