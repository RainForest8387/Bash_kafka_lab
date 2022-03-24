#/bin/bash
. ./functions.sh
topic_name="$1"
#timeout="$2"

consume_message ${topic_name} #${timeout}
exit $?