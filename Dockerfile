# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM ubuntu:16.04 
RUN apt-get update && apt-get install -y rsyslog
# copy all the configuration information into the right place
COPY src/etc/rsyslog-min.conf /etc/rsyslog-min.conf
COPY src/etc/rsyslog.d /etc/rsyslog.d
# need a config file that removes the /dev/xconsole redirect as the docker container doesn't have it
COPY src/etc/50-default-trim.conf /etc/rsyslog.d/50-default.conf
# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
# VOLUME /var/run/rsyslog/dev
ENTRYPOINT [ "rsyslogd", "-n", "-f","/etc/rsyslog-min.conf" ]
