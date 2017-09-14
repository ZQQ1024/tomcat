FROM centos:openjdk1.7
LABEL maintainer "qiangqiang.zhou@changhong.com"

ENV CATALINA_HOME=/opt/tomcat \ 
PATH=$PATH:${CATALINA_HOME}/bin:${CATALINA_HOME}/scripts \
JAVA_OPTS="-Xms512m -Xmx2048m" \
TOMCAT_VER=apache-tomcat-8.5.4

ADD apache-tomcat-8.5.4.tar.gz /opt/
RUN mv /opt/apache-tomcat-8.5.4 ${CATALINA_HOME} && chmod +x ${CATALINA_HOME}/bin/*sh

#没运行创建用户脚本
COPY scripts/ ${CATALINA_HOME}/scripts/
RUN chmod +x ${CATALINA_HOME}/scripts/*.sh

#settings
#去除webapps下面的示例文档和管理入口，只留ROOT
Run rm -rf ${CATALINA_HOME}/webapps/* && \
mkdir -p ${CATALINA_HOME}/webapps/ROOT

#隐藏版本信息和其他安全设置(删除用户 日志开启 默认列表关闭)
COPY ./settings/conf/* ${CATALINA_HOME}/conf/ 
COPY ./settings/ServerInfo/ ${CATALINA_HOME}/lib/

#以非root运行tomcat
#RUN groupadd -r user_grp && useradd -r -g user_grp zqq
#RUN chown -R zqq $CATALINA_HOME
#USER zqq

#检查健康状态
HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

EXPOSE 8080 8009
CMD ["/opt/tomcat/scripts/tomcat-boot.sh"]

