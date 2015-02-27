# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM debian:7

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -qq  openssh-server openjdk-7-jre-headless wget
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN wget -O /tmp/swarm.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.22/swarm-client-1.22-jar-with-dependencies.jar
# Standard SSH port
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
