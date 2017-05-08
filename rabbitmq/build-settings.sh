defineEnvVar PARENT_IMAGE_TAG "The tag of the base image" "201705";
defineEnvVar UBUNTU_VERSION "The version available in Ubuntu" "$(docker run --rm -it ${REGISTRY}/${NAMESPACE}/base:${PARENT_IMAGE_TAG} remote-ubuntu-version rabbitmq-server | sed 's/[^0-9a-zA-Z\._-]//g')";
overrideEnvVar TAG '${UBUNTU_VERSION}';
defineEnvVar RABBITMQ_USER "The RabbitMQ user" "rabbitmq";
defineEnvVar RABBITMQ_PASSWORD "The RabbitMQ password" "secret" "${RANDOM_PASSWORD}";
defineEnvVar RABBITMQ_EXCHANGE "The RabbitMQ exchange" '${NAMESPACE}';
defineEnvVar RABBITMQ_VIRTUALHOST "The RabbitMQ virtual host" '${NAMESPACE}';
defineEnvVar RABBITMQ_QUEUE "The queue in RabbitMQ" "exchange@queue";
defineEnvVar RABBITMQ_ROUTING_KEY "The RabbitMQ routing queue" "#";
defineEnvVar RABBITMQ_ULIMIT_N "The ulimit -n value to use when launching RabbitMQ" "50000";
defineEnvVar SERVICE_USER "The service user" '${RABBITMQ_USER}';
defineEnvVar SERVICE_GROUP "The service group" '${SERVICE_USER}';
defineEnvVar SERVICE_USER_HOME "The home of the service user" '/home/${SERVICE_USER}';
defineEnvVar SERVICE_USER_SHELL "The shell of the service user" '/bin/bash';
