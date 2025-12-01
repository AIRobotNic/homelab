FROM python:3.11-slim

RUN pip install flask

# Устанавливаем bash, git, ssh, curl, docker
RUN apt-get update && apt-get install -y \
    bash \
    git \
    openssh-client \
    curl \
    docker.io \
    && apt-get clean

# Устанавливаем docker-compose вручную
RUN curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

WORKDIR /app

# Копируем файлы webhook
COPY webhook.py .
COPY update.sh .
RUN chmod +x update.sh

# Папка для SSH ключей
RUN mkdir -p /root/.ssh
VOLUME ["/root/.ssh"]

CMD ["python", "webhook.py"]
