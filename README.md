Docker Cron - Labels
====

A simple docker container to schedule the starting of docker containers using cron. Cron schedules are provided in the labels of a container, allowing "jobs" to be created on simple schedules.

# Getting started
Start the `jaci/cron-label` container, passing through the docker socket to allow the container access to the host's docker runtime.

```sh
# Shell
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" -v "/etc/localtime:/etc/localtime:ro" jaci/cron-label:latest
```

```yaml
# Docker-compose
services:
  cron:
    image: jaci/cron-label:latest
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "/etc/localtime:/etc/localtime:ro"
```

# Scheduling containers
Containers can be scheduled by applying the `cron.schedule` label. These containers must be persistent (without the `--rm` flag), but limited in run time (one-shot, otherwise there is no point to scheduling jobs). Restart policy should not be set.

The `cron.schedule` label is directly applied to the crontab file. Any crontab format that is supported by alpine linux cron is supported.

```sh
# Shell
docker run -d --label "cron.schedule=0 0 * * *" my-image:latest
```

```yaml
# Docker-compose
services:
  my-service:
    image: my-image:latest
    restart: "no"
    labels:
      - "cron.schedule=0 0 * * *"
```
