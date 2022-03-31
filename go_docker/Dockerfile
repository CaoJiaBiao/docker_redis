FROM centos:7
RUN yum -y install wget \
    && wget https://golang.org/dl/go1.17.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz \
    && yum -y install gcc \
    && yum -y install git \
    && yum -y install automake autoconf libtool make \
    && echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN yum -y install dos2unix
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
ENV TZ=Asia/Shanghai
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.io,direct
WORKDIR /go