FROM centos:7

MAINTAINER ChenglongQian "qian_cheng_long@163.com"

RUN yum install -y gcc gcc-c++ \
                   libtool libtool-ltdl \
                   make cmake \
                   git \
                   pkgconfig \
                   sudo \
                   automake autoconf \
                   yum-utils rpm-build && \
    yum clean all

RUN useradd builder -u 1000 -m -G users,wheel && \
    echo "builder ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "# macros"                      >  /home/builder/.rpmmacros && \
    echo "%_topdir    /home/builder/rpmbuild/" >> /home/builder/.rpmmacros && \
    mkdir /home/builder/rpmbuild/ && \
    chown -R builder /home/builder

USER builder
WORKDIR /home/builder/rpmbuild

ENV FLAVOR=rpmbuild OS=centos DIST=el7
ENTRYPOINT ["rpmbuild"]
