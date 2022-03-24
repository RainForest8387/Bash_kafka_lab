#!/bin/bash

kafka-reassign-partitions.sh --bootstrap-server=wso2-kfk2.mcb.ru:9094 \
--command-config /home/kafka/kafka/config/sasl_scrum_client.properties \
--reassignment-json-file increase-replication-factor.json \
--execute 

exit $?