# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM alpine:3.6 
RUN apk --no-cache add rsyslog 
# copy all the configuration information into the right place
copy src/etc/rsyslog-min.conf /etc/rsyslog-min.conf
copy src/etc/rsyslog.d src/etc/rsyslogd.d
# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
VOLUME /var/run/rsyslog/dev
ENTRYPOINT [ "rsyslogd", "-n", "-f","/etc/rsyslog-min.conf" ]
