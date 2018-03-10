FROM centos:7
ENV container docker

RUN yum install -y epel-release && \
    yum install -y gcc make python-devel python-pip && \
    pip install ansible ansible-lint
