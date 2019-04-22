FROM docker.io/openshift/jenkins-2-centos7 

ARG JENKINS_VERS='2.164.2'
ENV JENKINS_VERSION=$JENKINS_VERS

USER 0


RUN \
 ln -sf ../usr/share/zoneinfo/Europe/Warsaw /etc/localtime; 
 
RUN \
 curl -s -L http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo && \
 echo "retries=0" >> /etc/yum.repos.d/jenkins.repo && \
 echo "timeout=120"  >> /etc/yum.repos.d/jenkins.repo && \
 echo "minrate=1" >> /etc/yum.repos.d/jenkins.repo && \
 rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key &&\
 yum install -y jenkins-${JENKINS_VERSION} &&\
 yum update --exclude=jenkins* --enablerepo=updates --assumeyes &&\
 yum clean all 
# rm -f /etc/yum.repos.d/*

RUN \
yum update --assumeyes &&\
yum clean all 
#rm -f /etc/yum.repos.d/redhat.repo

#RUN \
# curl -s -L http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo && \
# echo "retries=0" >> /etc/yum.repos.d/jenkins.repo && \
# rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key &&\
# yum clean all
 


USER 1001 
