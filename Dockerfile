FROM centos:7

RUN rpm -Uvh https://mirrors.ripple.com/ripple-repo-el7.rpm && \
    yum install -y --enablerepo=ripple-stable rippled

CMD ["rippled"]
