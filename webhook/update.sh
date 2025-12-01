#!/bin/bash
set -e  # остановка при любой ошибке

REPO_DIR="/project"
REPO_URL="git@github.com:YOUR_USER/YOUR_REPO.git"
DOCKER_DIR="$REPO_DIR/Nicolai_Petrov"
SSH_KEY="/root/.ssh/id_ed25519"

echo "[Webhook] Starting update.sh ..."
echo "[Webhook] Checking repository..."

# Клонируем, если репозиторий ещё нет
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[Webhook] Repository not found. Cloning..."
    export GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no"
    git clone "$REPO_URL" "$REPO_DIR"
else
    echo "[Webhook] Repository exists. Resetting to latest version..."
    export GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no"
    git -C "$REPO_DIR" fetch --all
    git -C "$REPO_DIR" reset --hard origin/main
fi

# Переходим в директорию с docker-compose.yml
echo "[Webhook] Moving to docker-compose directory: $DOCKER_DIR"
cd "$DOCKER_DIR"

# Логи для проверки
echo "[Webhook] Current directory: $(pwd)"
ls -la

# Строим и запускаем контейнеры
echo "[Webhook] Building new images and starting containers..."
docker-compose up -d --build

echo "[Webhook] Update complete!"