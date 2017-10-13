# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM ubuntu:16.04
RUN apt-get update && apt-get install -y rsyslog
# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
CMD [ "sh","-c" "ln", "-sf" "/var/run/rsyslog/dev/log", "/dev/log" ]
VOLUME /var/run/rsyslog/dev
ENTRYPOINT ["rsyslogd","-n","-f","/etc/rsyslogd.conf"]
