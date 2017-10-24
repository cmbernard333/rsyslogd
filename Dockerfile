# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM ubuntu:16.04
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:adiscon/v8-stable # latest rsyslog to get rotation support (8.30 @ 10/20/2017)
RUN apt-get update && apt-get install -y rsyslog logrotate
# copy all the configuration information into the right place
COPY src/etc/rsyslog-min.conf /etc/rsyslog-min.conf
COPY src/etc/rsyslog.d /etc/rsyslog.d
# need a config file that removes the /dev/xconsole redirect as the docker container doesn't have it
COPY src/etc/50-default-trim.conf /etc/rsyslog.d/50-default.conf
COPY src/rotate-messages /usr/local/bin/rotate-messages
# logrotate config
COPY src/etc/logrotate.d/messages /etc/logrotate.d
RUN chmod 644 /etc/logrotate.d/messages # logrotate likes a specific set of permissions
# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
# VOLUME /var/run/rsyslog/dev
ENTRYPOINT [ "rsyslogd", "-n", "-f","/etc/rsyslog-min.conf" ]
