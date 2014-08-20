FROM centos:centos6

MAINTAINER yo-tanaka

RUN yum install -y http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y --enablerepo=centosplus openssl-devel 
RUN yum install -y readline-devel libyaml-devel gdbm-devel tcl-devel db4-devel wget tar which tree git make gcc
RUN yum install -y supervisor


RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm list -r
RUN /usr/local/rvm/bin/rvm install ruby-2.1.2
ADD .bashrc /root/
ENV PATH $PATH:/usr/local/rvm/rubies/ruby-2.1.2/bin/

RUN gem update --system
RUN gem install chef --no-ri --no-rdoc
RUN cd /root && knife configure --defaults --user "" --repository ""
RUN gem install knife-solo --no-ri --no-rdoc
RUN gem install berkshelf -v 2.0.18 --no-ri --no-rdoc
