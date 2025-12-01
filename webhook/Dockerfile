FROM python:3.11-slim

# Создаём группу docker с GID хоста
ARG DOCKER_GID=999
RUN groupadd -g ${DOCKER_GID} docker

# Создаём пользователя deploy
RUN useradd -m -s /bin/bash deploy \
    && usermod -aG root deploy

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
RUN mkdir -p /deploy/.ssh
VOLUME ["/deploy/.ssh"]

# Выполняем контейнер от имени deploy
USER deploy

CMD ["python", "webhook.py"]
