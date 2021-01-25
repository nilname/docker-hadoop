DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bde2020/hadoop-base:$(current_branch) ./base
	docker build -t bde2020/hadoop-namenode:$(current_branch) ./namenode
	docker build -t bde2020/hadoop-datanode:$(current_branch) ./datanode
	docker build -t bde2020/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t bde2020/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t bde2020/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --rm  --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8 hdfs dfs -mkdir -p /input/
	docker run --rm --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /root/bigdata/docker-hadoop/:/root/ bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8 hdfs dfs -copyFromLocal -f /root/fruit.txt /input/
	#docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8 hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	#docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8 hdfs dfs -rm -r /output
	docker run --rm  --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run  --rm --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8 hdfs dfs -cat /output/*
clean:
	docker-compose down
	docker volume rm docker-hadoop_hadoop_datanode
	docker volume rm docker-hadoop_hadoop_datanode3
	docker volume rm docker-hadoop_hadoop_datanode2
	docker volume rm docker-hadoop_hadoop_namenode
