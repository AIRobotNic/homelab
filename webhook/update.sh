#!/bin/bash
set -e

REPO_DIR="/project"
REPO_URL="git@github.com:NeuronsUII/neuro_english_tutor.git"

echo "[Webhook] Checking repository..."

# Если нет папки → делаем clone
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[Webhook] Repository not found. Cloning..."
    export GIT_SSH_COMMAND="ssh -i /root/.ssh/id_ed25519 -o StrictHostKeyChecking=no"
    git clone "$REPO_URL" "$REPO_DIR"
else

    echo "[Webhook] Stopping containers..."
    docker-compose down
    echo "[Webhook] Repository exists. Pulling latest changes..."
    export GIT_SSH_COMMAND="ssh -i /root/.ssh/id_ed25519 -o StrictHostKeyChecking=no"
    git -C "$REPO_DIR" pull --ff-only
fi


echo "[Webhook] Current directory:"
cd "$REPO_DIR/Nicolai_Petrov"
pwd

ls -la

echo "[Webhook] Building new images..."
docker-compose build

echo "[Webhook] Starting services..."
docker-compose up -d

echo "[Webhook] Update complete!"
~                                 