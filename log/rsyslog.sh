#!/bin/sh
sudo /usr/local/sbin/rsyslogd -f ./rsyslog.conf
tail -f debug.log
