#!/bin/bash
topic_name="$1"
rm -rf increase-replication-factor.json
#Create the json file with the topic reassignment details
cat >>increase-replication-factor.json <<EOF
{"version":1,
  "partitions":[
   {"topic":"${topic_name}","partition":0,"replicas":[0,1,2]},
	 {"topic":"${topic_name}","partition":1,"replicas":[0,1,2]},
	 {"topic":"${topic_name}","partition":2,"replicas":[0,1,2]}
]}
EOF

exit $?