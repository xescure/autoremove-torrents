FROM python:3.9.5-buster

WORKDIR /app

COPY . .

RUN python3 setup.py install

ENTRYPOINT ["autoremove-torrents", "--conf=/config/config.yaml", "--log=/logs", "--view"]
