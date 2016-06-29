# rabbitmq-dockerized-sample
Sample runnable " as this " in multiple languages, leveraging docker.

The idea is to publish AMQP based samples in multiple languages, leveraging docker to provide multiple languages consumer and producers, and why not multiple Rabbitmq configurations, without installing anything but docker on its local machine.

**Let start the message broker with management plugin :**
```
docker run -d --hostname my-rabbit --name rabbitmq-test-broker -p 8888:15672 -p 5672:5672 rabbitmq:3.6.2-management
```
## Docker commands
```
docker build ./ruby -t bunny-amqp
```

**run ruby producer :**
```
docker run --rm --net="host" -e BUNNY_ROLE="producer" --name ruby-producer bunny-amqp
```

**run ruby consumer :**
```
docker run --rm --net="host" -e BUNNY_ROLE="consumer" --name ruby-consumer bunny-amqp
```

If there are no message within the queue, you will have to hit CTRL+C to quit the consumer.

## Sources
* https://github.com/docker-library/rabbitmq/
* https://www.rabbitmq.com/configure.html
* https://github.com/docker-library/docs/tree/master/rabbitmq
