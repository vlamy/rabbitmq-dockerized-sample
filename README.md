# rabbitmq-dockerized-sample
Sample runnable " as this " in multiple languages, leveraging docker.

The idea is to publish AMQP based samples in multiple languages, leveraging docker to provide multiple languages consumer and producers, and why not multiple Rabbitmq configurations, without installing anything but docker on its local machine.

**Run server with management plugin :**
```
docker run -d --hostname my-rabbit --name some-rabbit -p 8888:15672 -p 5672:5672 rabbitmq:3.6.2-management
```
## Docker commands
```
docker -t bunny-amqp build .
```

**run ruby producer :**
```
docker run --rm --name ruby-producer bunny-amqp
```


## Sources
* https://github.com/docker-library/rabbitmq/
* https://www.rabbitmq.com/configure.html
* https://github.com/docker-library/docs/tree/master/rabbitmq
