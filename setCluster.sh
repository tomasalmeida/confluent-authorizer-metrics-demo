#!/usr/bin/env bash

docker compose down -v
docker compose up -d  

# Wait brokers is UP
echo "Waiting kafka UP..."
sleep 20

# create topics
kafka-topics --bootstrap-server localhost:19092 --command-config ./clients/admin.properties --create --topic topic-admin
kafka-topics --bootstrap-server localhost:19092 --command-config ./clients/admin.properties --create --topic topic-bob
kafka-topics --bootstrap-server localhost:19092 --command-config ./clients/admin.properties --create --topic topic-all
kafka-topics --bootstrap-server localhost:19092 --command-config ./clients/admin.properties --create --topic topic-alice

# create permissions to admin
kafka-acls --bootstrap-server localhost:19092 --command-config ./clients/admin.properties \
  --add --consumer --producer --allow-principal "User:admin" --group '*' \
  --topic _confluent-command --topic _confluent-telemetry-metrics --topic _confluent_balancer_api_state --topic confluent-audit-log-events --topic topic-admin

# create permissions to alice
kafka-acls --bootstrap-server localhost:19092 --command-config ./clients/admin.properties \
  --add --consumer --producer --allow-principal "User:alice" --group '*' \
  --topic topic-alice --topic topic-all 

# create permissions to bob
kafka-acls --bootstrap-server localhost:19092 --command-config ./clients/admin.properties \
  --add --consumer --producer --allow-principal "User:bob" --group '*' \
  --topic topic-bob --topic topic-all

# show permissions
kafka-acls --bootstrap-server localhost:19092 --command-config ./clients/admin.properties --list 