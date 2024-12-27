# Simple example of Confluent Authorizer metrics

## Goal

## How to run

1. Clone repo and start docker

```shell 
    git clone git@github.com:tomasalmeida/confluent-authorizer-metrics-demo.git 
    cd confluent-authorizer-metrics-demo
    docker-compose up -d
    ./setAcls.sh
```

Start jconsole and check the metrics

* kafka.server:type=confluent-authorizer-metrics:authorization-request-rate-per-minute
* kafka.server:type=confluent-authorizer-metrics:Authorization-allowed-rate-per-minute
* kafka.server:type=confluent-authorizer-metrics:Authorization-denied-rate-per-minute
* kafka.server:type=confluent-authorizer-metrics:authorizer-authorization-latency-p90
* kafka.server:type=confluent-authorizer-metrics:authorizer-authorization-latency-p99
