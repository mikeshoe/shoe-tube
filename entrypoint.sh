#!/bin/sh

export APACHE_PID_FILE='/run/apache2/apache2.pid'

# Delete PID file if it ixists
if [ -f "$APACHE_PID_FILE" ]; then
	rm "$APACHE_PID_FILE"
fi

# Start apache in foreground
/usr/sbin/apache2ctl -D FOREGROUND