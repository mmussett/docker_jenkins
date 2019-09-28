#! /bin/bash -e

: "${JENKINS_WAR:="/usr/share/jenkins/jenkins.war"}"
: "${JENKINS_HOME:="/var/jenkins_home"}"

exec java -Duser.home="$JENKINS_HOME" -jar ${JENKINS_WAR} --httpPort=8000