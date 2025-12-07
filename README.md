# Micro service

Service for customer's something…

### Build prerequisities
Java 17

### Build info
mvn clean package

### Run info
/usr/lib/jvm/java-17-openjdk-amd64/bin/java -jar target/testing-1.0.0-SNAPSHOT.jar

### Environment info
* server port: 8888
* endpoints:
  - localhost:8888/customers

### Task
Implement:

- Spring Boot micro-service written in Java
- Build with Maven
- Data will be stored in embeded H2 database
- micro-service will be able to run locally without any other external DB (etc.) dependencies
- provide source code to us preferably with link publicly available on the internet or via ZIP file attached to the email

### Customer

Create endpoint for updating Customer attributes.
Endpoint for updating Customer should be able to update and/or remove existing values of any/all attributes.

Customer has business attributes:

- firstName
- lastName
- middleName
- email
- phoneNumber
- birthDate

# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)

### Guides
The following guides illustrate how to use some features concretely:

* [Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)
* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/bookmarks/)
* [Messaging with Redis](https://spring.io/guides/gs/messaging-redis/)

