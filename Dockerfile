# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM ubuntu:16.04
RUN apt-get update && apt-get install -y rsyslog
# copy all the configuration information into the right place
copy src/etc/rsyslog-mod.conf /etc/rsyslog-mod.conf
# need to copy out a modified 50-default.conf to replace the config stuff related to /dev/xconsole
copy src/etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf
# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
VOLUME /var/run/rsyslog/dev
ENTRYPOINT [ "rsyslogd", "-n", "-f","/etc/rsyslog-mod.conf" ]
