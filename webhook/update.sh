#!/bin/bash
set -e

echo "[Webhook] Starting update.sh ..."
cd /project

echo "[Webhook] Stopping containers..."
docker-compose down

echo "[Webhook] Performing Git pull..."
export GIT_SSH_COMMAND="ssh -i /root/.ssh/id_ed25519 -o StrictHostKeyChecking=no"

git clone git@github.com:AIRobotNic/neuro_english_tutor.git

cd neuro_english_tutor

git pull -f

echo "[Webhook] Sleeping 5 seconds..."
sleep 5

echo "[Webhook] Building new images..."
docker-compose build

echo "[Webhook] Starting services..."
docker-compose up -d

echo "[Webhook] Update complete!"
~                                 