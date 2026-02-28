#!/bin/bash

# Mainza Consciousness System - Development Build Script
# Default development flow uses docker-compose.dev.yml

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

echo "🚀 Starting Mainza Development Build Process..."
echo "=================================================="
echo "📦 Compose file: ${COMPOSE_FILE}"

# Get current timestamp and git commit for cache busting
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
CACHE_BUST=$(date +%s)

echo "📅 Build Date: $BUILD_DATE"
echo "🔗 Git Commit: $GIT_COMMIT"
echo "🔄 Cache Bust: $CACHE_BUST"
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
${COMPOSE_CMD} down 2>/dev/null || true
docker system prune -f

# Build with no cache and cache busting arguments
echo "🔨 Building frontend with no cache..."
${COMPOSE_CMD} build --no-cache \
  --build-arg CACHE_BUST=$CACHE_BUST \
  --build-arg BUILD_DATE="$BUILD_DATE" \
  --build-arg GIT_COMMIT="$GIT_COMMIT" \
  frontend

echo "🔨 Building backend with no cache..."
${COMPOSE_CMD} build --no-cache \
  --build-arg CACHE_BUST=$CACHE_BUST \
  --build-arg BUILD_DATE="$BUILD_DATE" \
  --build-arg GIT_COMMIT="$GIT_COMMIT" \
  backend

# Start services
echo "🚀 Starting services..."
${COMPOSE_CMD} up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Health check
echo "🏥 Performing health checks..."
echo "Frontend health:"
curl -f http://localhost:5173 >/dev/null 2>&1 && echo "✅ Frontend healthy" || echo "❌ Frontend unhealthy"

echo "Backend health:"
curl -f http://localhost:8000/health >/dev/null 2>&1 && echo "✅ Backend healthy" || echo "❌ Backend unhealthy"

echo ""
echo "✅ Development build completed successfully!"
echo "🌐 Frontend (Vite dev server): http://localhost:5173"
echo "🔧 Backend: http://localhost:8000"
echo "📊 Neo4j: http://localhost:7474"
echo ""
echo "📝 To view logs:"
echo "   Frontend: ${COMPOSE_CMD} logs -f frontend"
echo "   Backend:  ${COMPOSE_CMD} logs -f backend"
echo "   All:      ${COMPOSE_CMD} logs -f"
