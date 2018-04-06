FROM centos:7
ENV container docker

ENV ANSIBLE_VERSION 2.4.2.0
ENV LINT_VERSION 3.4.21

RUN yum install -y epel-release && \
    yum install -y git && \
    yum install -y ansible-${ANSIBLE_VERSION:?} && \
    yum install -y ansible-lint-${LINT_VERSION:?} && \
    yum clean all
