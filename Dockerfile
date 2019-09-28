# Download base image ubuntu 16.04
FROM "ubuntu:16.04"

# Set args
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8000
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home
ARG REF=/usr/share/jenkins/ref

# Set container environment variables
ENV JENKINS_HOME ${JENKINS_HOME}
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV REF ${REF}

ENV DEBIAN_FRONTEND noninteractive

# Jenkins is run with user `jenkins`, uid = 1000
RUN mkdir -p $JENKINS_HOME \
  && chown ${uid}:${gid} $JENKINS_HOME \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}


# Jenkins home directory is a volume so persisted
VOLUME $JENKINS_HOME

# Update the ubuntu software repository and install any dependencies
RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y apt-utils apt-transport-https ca-certificates \
  && apt-get install -y wget sudo git curl dpkg default-jre default-jdk unzip \
  && rm -rf /var/lib/apt/lists/*

# Add Jenkins repository key to the apt package manager repository
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

# Add Debian package repository to the apt package manager server's resource list
RUN echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

# Update apt repository
RUN apt-get update

# Install Jenkins
RUN apt-get install -y jenkins 

# Expose Jenkins web port
EXPOSE ${http_port}

USER ${user}

# Copy startup script
COPY --chown=${user}:${gid} jenkins.sh /usr/local/bin/jenkins.sh

ENTRYPOINT [ "/usr/local/bin/jenkins.sh" ]


