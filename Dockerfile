FROM        java:8-jdk

ENV         JAVA_HOME /usr
ENV         ACTIVEMQ_OPTS_MEMORY "-Xms3G -Xmx3G"
ENV         ACTIVEMQ_CONF=/opt/activemq/conf

RUN         wget http://archive.apache.org/dist/activemq/5.13.3/apache-activemq-5.13.3-bin.tar.gz && \
            tar xvzf apache-activemq-5.13.3-bin.tar.gz -C /opt/ && \
            mv /opt/apache-activemq-5.13.3 /opt/activemq && \
            rm apache-activemq-5.13.3-bin.tar.gz

RUN         curl -L -O http://search.maven.org/remotecontent\?filepath\=org/apache/ivy/ivy/2.3.0/ivy-2.3.0.jar && \
            java -jar ivy-2.3.0.jar -dependency org.apache.camel camel-jsonpath 2.16.2 -retrieve "/opt/activemq/lib/camel/[artifact]-[revision](-[classifier]).[ext]" && \
            java -jar ivy-2.3.0.jar -dependency org.apache.camel camel-mvel 2.16.2 -retrieve "/opt/activemq/lib/camel/[artifact]-[revision](-[classifier]).[ext]" && \
            java -jar ivy-2.3.0.jar -dependency org.apache.camel camel-script 2.16.2 -retrieve "/opt/activemq/lib/camel/[artifact]-[revision](-[classifier]).[ext]" && \
            rm ivy-2.3.0.jar

ADD         ./conf /opt/activemq/conf/

EXPOSE      8162 61616 61612

CMD         ["/opt/activemq/bin/activemq", "console"]
