#FROM debian:stable
FROM alpine:3.14
RUN apk add ca-certificates tzdata curl rsync
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get task-mon for health check integration
ADD https://github.com/bdd/runitor/releases/download/v0.9.2/runitor-v0.9.2-linux-amd64 /bin/runitor
RUN chmod +x /bin/runitor

# Get restic executable
ARG RESTIC_VERSION=0.13.1
ARG RCLONE_VERSION=v1.58.0
ARG ARCH=amd64
ADD https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2 /
RUN bzip2 -d restic_${RESTIC_VERSION}_linux_amd64.bz2 && mv restic_${RESTIC_VERSION}_linux_amd64 /bin/restic && chmod +x /bin/restic
ADD http://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip /
RUN unzip rclone-${RCLONE_VERSION}-linux-${ARCH}.zip
RUN mv rclone-*-linux-${ARCH}/rclone /bin/rclone
RUN chmod +x /bin/rclone
RUN rm -rf rclone*

#https://downloads.rclone.org/v1.56.1/rclone-v1.56.1-linux-amd64.zip

RUN mkdir -p /mnt/restic /var/spool/cron/crontabs /var/log /mnt/root

# /data is the dir where you have to put the data to be backed up


COPY entry.sh /entry.sh
COPY *.sh /bin/

RUN touch /var/log/cron.log
RUN mkdir /secrets

VOLUME [ "/secrets" ]

WORKDIR "/"

ENV RCLONE_CONFIG=/secrets/rclone.conf
ENV RCLONE_DRIVE_USE_TRASH=false
ENV RCLONE_STATS=1m
ENV RCLONE_STATS_ONE_LINE_DATE=true
ENV RCLONE_CONFIG_DIR=/secrets
ENV RCLONE_PROGRESS=true
ENV RCLONE_FAST_LIST=true
ENV RESTIC_PASSWORD_FILE=/secrets/pass_file.txt
ENV RCLONE_TRANSFERS=8

ENTRYPOINT ["/entry.sh"]

