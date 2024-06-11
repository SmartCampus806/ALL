# Справка
При клонировании репозитория с подмодулями, поддиректории подмодулей будут пустыми. Чтобы получить содержимое подмодулей, нужно выполнить: ``` init.sh ```

Чтобы обновить подмодули до последних коммитов, используется команда: ``` update.sh ```

# Репозитории:
- [Frontend](https://github.com/hell-lumpen/room-booking-vite) //Вынести в организацию
- [RoomBooking](https://github.com/SmartCampus806/RoomBooking)
- [Analytics](https://github.com/hell-lumpen/sc-analytics) //Вынести в организацию
- [Notifications](https://github.com/SmartCampus806/notification)

# Запуск
```
docker network create smart-campus
```

```
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
```

```
docker build -t roombooking RoomBooking/

docker run -d --name room_booking --network smart-campus -p 8000:8000 roombooking
```

```
docker build -t email-notification Notifications/email_notification/

docker run -d --name email-notification --network smart-campus email-notification
```

```
docker build -t frontend Frontend/

docker run -d --name frontend --network smart-campus -p 5173:5173 frontend
```