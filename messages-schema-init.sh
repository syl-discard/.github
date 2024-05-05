#!/usr/bin/env bash

until printf "" 2>>/dev/null >>/dev/tcp/message-db/9042; do 
    sleep 5;
    echo "Waiting for cassandra...";
done

echo "Creating keyspace and tables if needed..."

cqlsh message-db -e "CREATE KEYSPACE IF NOT EXISTS messages WITH REPLICATION = {'class': 'NetworkTopologyStrategy', 'DC1': '1'};"

cqlsh message-db -e "CREATE TABLE IF NOT EXISTS messages.messages (id uuid,message text, serverid uuid, userid uuid, PRIMARY KEY (id));"

