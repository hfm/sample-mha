FROM centos:7

RUN yum install -y epel-release
RUN yum install -y curl rsync unzip rpmdevtools perl-ExtUtils-MakeMaker make perl-Module-Install perl-Config-Tiny perl-DBD-mysql perl-Parallel-ForkManager perl-Log-Dispatch
RUN rpmdev-setuptree
WORKDIR /root/rpmbuild
RUN curl -L https://github.com/yoshinorim/mha4mysql-node/archive/v0.58.tar.gz -o SOURCES/mha4mysql-node-0.58.tar.gz
RUN curl -L https://github.com/yoshinorim/mha4mysql-manager/archive/v0.58.tar.gz -o SOURCES/mha4mysql-manager-0.58.tar.gz
RUN tar xf SOURCES/mha4mysql-node-0.58.tar.gz -C SPECS/ --strip=2 mha4mysql-node-0.58/rpm/masterha_node.spec
RUN tar xf SOURCES/mha4mysql-manager-0.58.tar.gz -C SPECS/ --strip=2 mha4mysql-manager-0.58/rpm/masterha_manager.spec
RUN rpmbuild -ba SPECS/masterha_node.spec
RUN rpm -i RPMS/noarch/mha4mysql-node-0.58-0.el7.centos.noarch.rpm
RUN rpmbuild -ba SPECS/masterha_manager.spec
CMD ["rsync", "-a", "RPMS/noarch/", "/tmp"]
