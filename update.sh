#!/bin/bash

echo "* * * * * /update.sh" > /tmp/cron.tmp
docker ps -a --filter "label=cron.schedule" --format '{{.Label "cron.schedule"}} docker start {{.ID}} || true' >> /tmp/cron.tmp

if ! cmp -s /tmp/cron.tmp /etc/crontabs/root; then
  echo "Crontab differs - containers have updated. Updating..."
  mv /tmp/cron.tmp /etc/crontabs/root
  crontab -l
fi
