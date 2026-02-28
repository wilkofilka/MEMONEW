#!/bin/bash

# Mainza Consciousness System - Change Verification Script
# This script verifies that changes are reflected in the running dev containers

set -e  # Exit on any error

COMPOSE_FILE="docker-compose.dev.yml"

if command -v docker >/dev/null 2>&1; then
  COMPOSE_BIN="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE_BIN="docker-compose"
else
  echo "❌ Docker Compose is required (docker compose or docker-compose)."
  exit 1
fi

COMPOSE_CMD="${COMPOSE_BIN} -f ${COMPOSE_FILE}"

echo "🔍 Verifying Changes in Running Containers..."
echo "============================================="
echo "📦 Compose file: ${COMPOSE_FILE}"

# Static consistency checks for compose and scripts
echo "🧩 Running static consistency checks..."
python3 - <<'PYTHON'
from pathlib import Path
import sys

dev = Path('docker-compose.dev.yml').read_text()
prod = Path('docker-compose.yml').read_text()
build = Path('scripts/build-dev.sh').read_text()

errors = []
if 'LIVEKIT_URL=${LIVEKIT_URL:-ws://livekit-server:7880}' not in dev:
    errors.append('docker-compose.dev.yml: LIVEKIT_URL default is inconsistent')
if 'LIVEKIT_URL=${LIVEKIT_URL:-ws://livekit-server:7880}' not in prod:
    errors.append('docker-compose.yml: LIVEKIT_URL default is inconsistent')
if '5173:5173' not in dev:
    errors.append('docker-compose.dev.yml: frontend dev port 5173 missing')
if 'COMPOSE_FILE="docker-compose.dev.yml"' not in build:
    errors.append('scripts/build-dev.sh: does not default to docker-compose.dev.yml')

if errors:
    print('❌ Consistency checks failed:')
    for e in errors:
        print(f' - {e}')
    sys.exit(1)

print('✅ Consistency checks passed')
PYTHON

echo ""
# Check if containers are running
echo "📋 Checking container status..."
${COMPOSE_CMD} ps

echo ""

# Verify frontend availability
echo "🌐 Verifying frontend availability..."
if curl -sf http://localhost:5173 >/dev/null; then
    echo "✅ Frontend dev server is reachable on :5173"
else
    echo "❌ Frontend dev server is not reachable on :5173"
fi

echo ""

# Verify backend health
echo "🔧 Verifying backend health endpoint..."
if curl -sf http://localhost:8000/health >/dev/null; then
    echo "✅ Backend health endpoint is reachable on :8000/health"
else
    echo "❌ Backend health endpoint is not reachable on :8000/health"
fi

echo ""

# Verify runtime env values in backend container
echo "🧪 Verifying backend environment wiring..."
${COMPOSE_CMD} exec -T backend /bin/sh -c 'echo "LIVEKIT_URL=$LIVEKIT_URL"; echo "REDIS_URL=$REDIS_URL"; echo "NEO4J_URI=$NEO4J_URI"; echo "OLLAMA_BASE_URL=$OLLAMA_BASE_URL"'

echo ""

# Print resolved image/container mapping from compose
echo "📊 Service images resolved by compose:"
${COMPOSE_CMD} images

echo ""
echo "📝 Recent backend logs:"
${COMPOSE_CMD} logs --tail=20 backend || true

echo ""
echo "✅ Change verification completed!"
