FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

COPY WordCount.jar /opt/hadoop/applications/WordCount2.jar
COPY hdfsDemo-1.0-SNAPSHOT.jar /opt/hadoop/applications/hdfsDemo-1.0-SNAPSHOT.jar
#ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount2.jar"
ENV JAR_FILEPATH="/opt/hadoop/applications/hdfsDemo-1.0-SNAPSHOT.jar"
#ENV CLASS_TO_RUN="com.cecdata.hdfs.demo.CombinerApp"
#ENV CLASS_TO_RUN="com.cecdata.hdfs.demo.HDFSApp"
ENV CLASS_TO_RUN="com.cecdata.hdfs.demo.ParititonerApp"
#ENV CLASS_TO_RUN="com.cecdata.hdfs.demo.WordCountApp"
#ENV CLASS_TO_RUN="com.cecdata.hdfs.demo.WordCount2App"
#ENV CLASS_TO_RUN="WordCount"
ENV PARAMS="/input /output"

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "sh /run.sh" ]
