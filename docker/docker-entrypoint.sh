#!/bin/bash

args="$@"

# Check if a schedule has been set using the env variable
if [ -z "$SCHEDULE" ]
then
    # Run the pgoram only once (and exit the container)
    echo "No schedule was set."

    echo "Running program once ($args)..."
    /usr/local/bin/autoremove-torrents $args

else
    # Run the program in a cron job
    echo "Schedule was set."

    cron_job="$SCHEDULE /usr/local/bin/autoremove-torrents $args >> /var/log/cron.log 2>&1"

    echo "Creating cron job ($cron_job)..."
    echo -e "$cron_job" >> /etc/cron.d/autoremove-torrents
    touch /var/log/cron.log

    echo "Setting cron job permissions..."
    chmod 0644 /etc/cron.d/autoremove-torrents

    echo "Applying cron job..."
    crontab /etc/cron.d/autoremove-torrents

    echo "Running cron and showing logs..."
    cron && tail -f /var/log/cron.log
fi
