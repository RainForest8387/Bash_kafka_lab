#!/bin/bash
. ./functions.sh
user="$1"
topic_name="$2"
group_name="$3"

#add operation permission for specific user
define_sasl_user_operation ${user} ${topic_name}
#add producer permission for for specific user
define_sasl_user_producer ${user} ${topic_name}
#add consumer permission for for specific user and group
define_sasl_user_consumer ${user} ${topic_name} ${group_name}

exit $?