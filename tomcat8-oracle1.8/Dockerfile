FROM centos:notroot1.8
LABEL maintainer "qiangqiang.zhou@changhong.com"

WORKDIR /srv/zqq
#不要下载到那些root权限的目录下面
RUN curl -O  http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz && tar -xf apache-tomcat-8.5.20.tar.gz

ENV CATALINA_HOME=/srv/zqq/tomcat \ 
PATH=$PATH:${CATALINA_HOME}/bin:${CATALINA_HOME}/scripts \
JAVA_OPTS="-Xms512m -Xmx2048m" \
TOMCAT_VER=apache-tomcat-8.5.20

#ADD apache-tomcat-8.5.4.tar.gz /opt/
RUN mv /srv/zqq/apache-tomcat-8.5.20 ${CATALINA_HOME} && chmod +x ${CATALINA_HOME}/bin/*sh

USER root
#没运行创建用户脚本
COPY scripts/ ${CATALINA_HOME}/scripts/
RUN chown -R zqq ${CATALINA_HOME}/scripts/ && chmod +x ${CATALINA_HOME}/scripts/*.sh

#settings
#去除webapps下面的示例文档和管理入口，只留ROOT
Run rm -rf ${CATALINA_HOME}/webapps/* && \
rm -rf /srv/zqq/apache-tomcat-8.5.20.tar.gz && \
mkdir -p ${CATALINA_HOME}/webapps/ROOT

#隐藏版本信息和其他安全设置(删除用户 日志开启 默认列表关闭)
COPY ./settings/conf/* ${CATALINA_HOME}/conf/ 
COPY ./settings/ServerInfo/ ${CATALINA_HOME}/lib/

#以非root运行tomcat
RUN chown -R zqq:user_grp $CATALINA_HOME
USER zqq

#检查健康状态
HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

EXPOSE 8080 8009
CMD ["/srv/zqq/tomcat/scripts/tomcat-boot.sh"]

