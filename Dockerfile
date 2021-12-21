FROM alpinelinux/docker-cli

RUN apk add --no-cache bash

ADD update.sh /update.sh
RUN chmod +x /update.sh

RUN mkdir /var/log/cron && touch /var/log/cron/cron.log
CMD /update.sh && crond -b -L /var/log/cron/cron.log && tail -f /var/log/cron/cron.log
