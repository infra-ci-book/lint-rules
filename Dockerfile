FROM centos:7
ENV container docker

RUN yum install -y epel-release && \
    yum install -y git && \
    yum install -y gcc make python-devel python-pip && \
    pip install ansible==2.4.3.0 ansible-lint==3.4.20
