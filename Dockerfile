# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS build
ARG BUILD_HASH

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates && \
    apt-get install -y cron bash-completion curl busybox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install rclone
RUN curl https://rclone.org/install.sh | bash

# Copy source code
WORKDIR /app/
COPY . .

# To use with other images source this image and copy rclone 
# COPY --from=build /usr/bin/rclone /usr/bin/rclone
# COPY --from=build /app/restore_backup_start.sh /app/restore_backup_start.sh
# COPY --from=build /app/backup_start.sh /app/backup_start.sh
# Replace build with the offical name of the build stage or image


# Set default values for environment variables
# Make sure to set these values during docker run
# Change the values to match your project
ENV BACKUP_PATH=project-backups
ENV BACKUP_CRON="0 2 *"  
ENV BACKUP_NAME=project-backup
ENV NOTIFY_URL=https://your-webhook-url.com/notify




CMD [ "bash", "restore_backup_start.sh", "server" ] \
    # To enable dev mode: \
    # 1. Set DEV_MODE=true during docker build: --build-arg DEV_MODE=true \
    # 2. Run: docker run -it --rm <image_name> npm run dev
