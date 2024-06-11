docker run -d --name zookeeper --network smart-campus -p 2181:2181 wurstmeister/zookeeper

docker run -d --name kafka --network smart-campus -p 9092:9092 \
  -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
  -e KAFKA_ADVERTISED_HOST_NAME=localhost \
  -e KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT \
  -e KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT \
  -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 \
  -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
  wurstmeister/kafka


docker run -d --name kafka-ui --network smart-campus -p 8080:8080 \
  -e KAFKA_CLUSTERS_0_NAME=local-kafka \
  -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka:9092 \
  -e KAFKA_CLUSTERS_0_ZOOKEEPER=zookeeper:2181 \
  provectuslabs/kafka-ui

docker run -d --name database --network smart-campus -p 5432:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=admin \
  -e POSTGRES_DB=roombookingdb \
  postgres:latest