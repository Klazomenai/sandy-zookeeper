FROM centos:6.9

RUN yum update -y

# Install puppet repo and puppet agent
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y puppet

# Load the puppet config
ADD etc/puppet/puppet.conf /etc/puppet/puppet.conf

ADD rpm/jdk1.8.0_66-1.8.0_66-fcs.x86_64.rpm /tmp/jdk1.8.0_66-1.8.0_66-fcs.x86_64.rpm
RUN rpm -Uvh /tmp/jdk1.8.0_66-1.8.0_66-fcs.x86_64.rpm

# Run the agent. Confirm number of times the agent is needed to be run
# Echoing the nameserver until have some visibility of minikube DNS or the following gets
# merged: https://github.com/moby/moby/issues/25537
# Static IP defined in puppetserver.yaml
RUN echo "10.0.0.200 puppet" > /etc/hosts && cat /etc/hosts && puppet agent --no-daemonize --verbose --debug --onetime

# ENTRYPOINT /usr/bin/java \
