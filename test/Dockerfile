FROM tomcat8:jdk1.8
MAINTAINER ZQQ
#USER root
COPY JDBCTest.war tomcat/webapps/ROOT/ROOT.war
RUN cd tomcat/webapps/ROOT && \
jar -xf ROOT.war && \
rm -rf ROOT.war

