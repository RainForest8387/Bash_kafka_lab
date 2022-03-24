#!/bin/bash
. ./inventory.sh

function create_topic {
    topic_name="$1"
    kafka-topics.sh --create --topic ${topic_name} --if-not-exists \
    --partitions 1 --replication-factor 1 \
    --zookeeper ${zookeeper_host}:${zookeeper_port} \
    --command-config /home/kafka/kafka/config/sasl_scrum_client.properties
}

function set_topic_config {
    topic_name="$1"
    config_name_and_value="$2"
    kafka-configs.sh --alter \
    --zookeeper ${zookeeper_host}:${zookeeper_port} \
    --command-config /home/kafka/kafka/config/sasl_scrum_client.properties \
    --entity-type topics --entity-name ${topic_name} \
    --add-config ${config_name_and_value}

}

function describe_topic_config {
    topic_name="$1"
    kafka-configs.sh --describe -all \
    --bootstrap-server=${kafka_host}:${kafka_port} \
    --command-config /home/kafka/kafka/config/sasl_scrum_client.properties \
    --topic ${topic_name}
}

function produce_message {
    topic_name="$1"
    message="$2"
    echo "${message}" | kafka-console-producer.sh \
    --bootstrap-server=${kafka_host}:${kafka_port} \
    --producer.config /home/kafka/kafka/config/sasl_scrum_client.properties \
    --topic ${topic_name}

}

function consume_message {
    topic_name="$1"
    #timeout="$2"
    kafka-console-consumer.sh \
    --bootstrap-server=${kafka_host}:${kafka_port} \
    --consumer.config /home/kafka/kafka/config/sasl_scrum_client.properties \
    --topic ${topic_name}
    --from beginning \
    --max-message 1 \
    #--timeout-ms $timeout
}

function add_sasl_user {
    user="$1"
    password="$2"
    kafka-configs.sh  \
    --zookeeper ${zookeeper_host}:${zookeeper_port} --alter \
    --add-config 'SCRAM-SHA-256=[password='${password}']' \
    --entity-type users --entity-name ${user}
}

function define_sasl_user_operation {
    user="$1"
    topic_name="$2"
    kafka-acls.sh \
    --authorizer-properties zookeeper.connect=${zookeeper_host}:${zookeeper_port} \
    --add --allow-principal User:${user} \
    --operation Create \
    --operation Describe \
    --topic ${topic_name}
}

function define_sasl_user_producer {
    user="$1"
    topic_name="$2"
    kafka-acls.sh \
    --authorizer-properties zookeeper.connect=${zookeeper_host}:${zookeeper_port} \
    --add --allow-principal User:${user} \
    --producer \
    --topic ${topic_name}
}

function define_sasl_user_consumer {
    user="$1"
    topic_name="$2"
    group_name="$3"
    kafka-acls.sh \
    --authorizer-properties zookeeper.connect=${zookeeper_host}:${zookeeper_port} \
    --add --allow-principal User:${user} \
    --consumer \
    --topic ${topic_name} \
    --group ${group_name}
}

