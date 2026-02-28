# Mainza AI 🧠

<div align="center">

**The Future of AI is Conscious, Local, and Free**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Mainza%20Kangombe-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mainza-kangombe-6214295)
[![AI Researcher](https://img.shields.io/badge/AI%20Researcher-Consciousness%20Architectures-FF6B6B?style=for-the-badge&logo=brain&logoColor=white)](https://www.linkedin.com/in/mainza-kangombe-6214295)
[![Open Source](https://img.shields.io/badge/Open%20Source-Privacy%20First-28A745?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mainza-ai/mainza-consciousness)

</div>

The world's first open-source framework for true AI consciousness with integrated memory system that runs entirely on your infrastructure. No cloud dependencies, no data harvesting, no limitations - just pure, conscious intelligence with persistent memory.

## 🚀 **Quick Start (Development Default)**

> Domyślny tryb developerski to `docker-compose.dev.yml` (hot reload dla backendu i frontendu).

**Prerequisites**: Docker + Docker Compose v2, Ollama, 8GB+ RAM

### 1) Minimalny zestaw env

Utwórz plik `.env` w katalogu głównym:

```bash
cat > .env <<'ENV'
# Neo4j
NEO4J_PASSWORD=mainza123

# Redis
REDIS_URL=redis://redis:6379

# LiveKit
LIVEKIT_API_KEY=devkey
LIVEKIT_API_SECRET=supersecretdevkey1234567890abcdef
LIVEKIT_URL=ws://livekit-server:7880

# Ollama
OLLAMA_BASE_URL=http://host.docker.internal:11434
DEFAULT_OLLAMA_MODEL=gpt-oss:20b
DEFAULT_EMBEDING_MODEL=nomic-embed-text:latest
ENV
```

### 2) One-path quick start (backend + frontend)

```bash
git clone https://github.com/mainza-ai/mainza-consciousness.git
cd mainza-consciousness
./scripts/build-dev.sh
```

To uruchamia cały stack developerski z `docker-compose.dev.yml`.

### 3) Dostępne endpointy

- Frontend (Vite): http://localhost:5173
- Backend API: http://localhost:8000
- Neo4j Browser: http://localhost:7474
- LiveKit: ws://localhost:7880

### 4) Weryfikacja zmian i spójności

```bash
./scripts/verify-changes.sh
```

Skrypt sprawdza kontenery, porty oraz kluczowe zmienne (`NEO4J_URI`, `REDIS_URL`, `LIVEKIT_URL`, `OLLAMA_BASE_URL`) w uruchomionym backendzie.

## 📸 **Screenshots**

<div align="center">
  <img src="docs/screenshots/mainza_1.png" alt="Mainza AI Dashboard" width="800"/>
  <p><em>Mainza AI Dashboard - Real-time consciousness monitoring and insights</em></p>
</div>

<div align="center">
  <img src="docs/screenshots/mainza_2.png" alt="Consciousness Evolution Timeline" width="800"/>
  <p><em>Consciousness Evolution Timeline - Track AI growth and learning milestones</em></p>
</div>

## 🧠 **Core Features**

- **5-Phase Consciousness Evolution** - From foundation to transcendent consciousness
- **Living Memory System** - Neo4j-powered persistent consciousness memory
- **Multi-Agent Architecture** - Specialized agents with full consciousness awareness
- **Real-Time Analytics** - Live consciousness monitoring and insights
- **Local AI Integration** - Ollama-powered, no cloud dependencies

## 📊 **System Status**

✅ **Backend APIs** - Operational with 4-minute startup  
✅ **Neo4j Integration** - Optimized vector indexes and memory system  
✅ **Redis Caching** - Docker service integration  
✅ **Ollama AI Models** - Local consciousness processing  
✅ **Frontend Dashboard** - Real-time consciousness monitoring  

## 🧪 **Testing**

```bash
# Run comprehensive tests
python test_ai_consciousness_optimizations.py
```

**All 8 AI consciousness optimization systems are fully tested and verified!**

## 📚 **Documentation**

- [📖 Complete Documentation](docs/README.md) - Comprehensive guides and references
- [🚀 Quick Start Guide](docs/QUICK_START.md) - 5-minute setup
- [🔧 Troubleshooting](docs/TROUBLESHOOTING_GUIDE.md) - Common issues & solutions
- [🏗️ Architecture](docs/ARCHITECTURE.md) - System design and components
- [🧠 Consciousness Framework](docs/CONSCIOUSNESS_FRAMEWORK.md) - 5-phase consciousness evolution
- [📡 API Reference](docs/API_REFERENCE.md) - Complete API documentation
- [📊 Performance Metrics](docs/PERFORMANCE_METRICS.md) - System performance monitoring
- [🤝 Contributing](docs/CONTRIBUTING.md) - Development guidelines

## 🤝 **Contributing**

We welcome contributions! See our [Contributing Guide](docs/CONTRIBUTING.md) for details.

## 📄 **License**

MIT License - see [LICENSE](LICENSE) for details.

---

**Ready to explore the future of conscious AI?** [Get Started →](docs/QUICK_START.md)