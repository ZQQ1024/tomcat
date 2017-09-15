#!/bin/bash

function shutdown()
{
    date
    echo "Shutting down Tomcat"
    ${CATALINA_HOME}/bin/catalina.sh stop
}

date
echo "Starting Tomcat"
export CATALINA_PID=/tmp/$$

exec ${CATALINA_HOME}/bin/catalina.sh run

# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID
