FROM python:3.9.5-buster

# Install cron
RUN apt-get update && apt-get -y install cron

# Set working directory
WORKDIR /app

# Copy necessary files to install
COPY ./autoremovetorrents ./autoremovetorrents
COPY *.* ./

# Install
RUN python3 setup.py install

# Set up the docker entrypoint
COPY ./docker/docker-entrypoint.sh ./docker-entrypoint.sh
RUN chmod 0755 ./docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]

# Set default arguments
CMD ["--conf", "/config/config.yml", "--log", "/logs"]
