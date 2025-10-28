# AICraftWorksOrg Integration Scripts

This directory contains production-ready automation scripts for deploying and managing Claude-Flow across the AICraftWorksOrg enterprise.

## 📦 Available Scripts

### 1. setup-central-repo.sh (422 lines)
**Purpose**: Complete automated setup of Claude-Flow in the central repository

**Usage**:
```bash
./setup-central-repo.sh
```

**What it does**:
- ✅ Checks prerequisites (Node.js 20+, npm, git)
- ✅ Installs Claude-Flow alpha version
- ✅ Initializes Claude-Flow with org configuration
- ✅ Creates directory structure (.aicraftworks/, .swarm/)
- ✅ Configures memory systems (AgentDB + ReasoningBank)
- ✅ Installs optional dependencies
- ✅ Creates configuration files (agentdb.config.js, permissions.yml, repos.json)
- ✅ Creates helper scripts
- ✅ Updates .gitignore

**Time**: ~2 minutes

### 2. deploy-cross-repo.sh (94 lines)
**Purpose**: Deploy agent swarm across multiple repositories

**Usage**:
```bash
./deploy-cross-repo.sh "task description" "repo1,repo2,repo3"

# Examples:
./deploy-cross-repo.sh "implement authentication" "user-service,api-gateway"
./deploy-cross-repo.sh "add logging" "user-service,payment-service,api-gateway"
```

**What it does**:
- ✅ Initializes multi-repo swarm coordination
- ✅ Spawns specialized agents for each repository
- ✅ Executes task across all repositories
- ✅ Coordinates work via shared memory
- ✅ Provides monitoring instructions

**Time**: ~2-5 minutes depending on task complexity

### 3. sync-memories.sh (67 lines)
**Purpose**: Synchronize memory across repositories

**Usage**:
```bash
# Sync all repos to shared namespace
./sync-memories.sh

# Sync specific repo to shared
./sync-memories.sh user-service

# Sync specific repo to specific target
./sync-memories.sh user-service "aicraftworks/projects/auth"
```

**What it does**:
- ✅ Syncs repo-specific memories to shared namespace
- ✅ Consolidates learnings across organization
- ✅ Makes knowledge available to all agents
- ✅ Prevents knowledge silos

**Time**: ~30 seconds per repository

### 4. monitor-org.sh (35 lines)
**Purpose**: Start real-time monitoring dashboard

**Usage**:
```bash
./monitor-org.sh          # Starts on port 3000
./monitor-org.sh --port 8080  # Custom port
```

**What it does**:
- ✅ Launches web-based monitoring dashboard
- ✅ Shows real-time agent activity
- ✅ Displays metrics and performance
- ✅ Tracks memory usage
- ✅ Monitors all repositories

**Access**: http://localhost:3000

### 5. generate-report.sh (51 lines)
**Purpose**: Generate organization performance report

**Usage**:
```bash
./generate-report.sh      # Default: 7 days
./generate-report.sh 30d  # Last 30 days
./generate-report.sh 1h   # Last hour
```

**What it does**:
- ✅ Generates comprehensive performance report
- ✅ Includes agent activity, memory usage, github operations
- ✅ Saves report to .aicraftworks/reports/
- ✅ Displays summary statistics
- ✅ Exports JSON for further analysis

**Output**: `.aicraftworks/reports/performance-YYYYMMDD-HHMMSS.json`

## 🚀 Quick Start Guide

### Initial Setup
```bash
# 1. Run setup (one time only)
./setup-central-repo.sh

# 2. Verify installation
npx claude-flow@alpha --version
```

### Daily Operations
```bash
# Deploy to single repo
./deploy-cross-repo.sh "add feature X" "repo-name"

# Deploy across multiple repos
./deploy-cross-repo.sh "implement feature Y" "repo1,repo2,repo3"

# Sync memories (run weekly)
./sync-memories.sh

# Generate weekly report
./generate-report.sh 7d
```

### Monitoring
```bash
# Start monitoring dashboard (leave running)
./monitor-org.sh

# View in browser
open http://localhost:3000
```

## 📋 Configuration Files Created

After running `setup-central-repo.sh`, you'll find:

```
.aicraftworks/
├── agentdb.config.js        # AgentDB vector search config
├── permissions.yml          # Agent access control
├── repos.json              # Repository registry
├── configs/
├── templates/
├── scripts/
│   ├── deploy-multi-repo.sh
│   ├── monitor.sh
│   └── sync-memory.sh
├── logs/
└── reports/
```

## 🔧 Script Dependencies

All scripts require:
- **Node.js** 20+ 
- **npm** 9+
- **git** 2+
- **bash** 4+

Optional but recommended:
- **jq** for JSON processing
- **curl** for API calls

## 💡 Best Practices

### Setup Script
- Run once per organization
- Review generated configs before first deployment
- Backup existing .aicraftworks/ if re-running

### Deploy Script
- Start with single repo to test
- Use meaningful task descriptions
- Monitor first deployment before scaling

### Sync Script
- Run weekly to consolidate learnings
- More frequent for active development
- Monitor storage size with many repos

### Monitor Script
- Keep running during active development
- Use for debugging agent issues
- Review metrics regularly

### Report Script
- Generate weekly reports for teams
- Use for sprint retrospectives
- Track improvement over time

## 🐛 Troubleshooting

### Setup fails
```bash
# Check prerequisites
node --version  # Should be 20+
npm --version   # Should be 9+
git --version

# Clean and retry
rm -rf .aicraftworks .swarm
./setup-central-repo.sh
```

### Deploy fails
```bash
# Check swarm status
npx claude-flow@alpha swarm status

# Check logs
npx claude-flow@alpha logs agent-activity --last 1h

# Reset swarm
npx claude-flow@alpha swarm init --force
```

### Memory sync fails
```bash
# Check memory health
npx claude-flow@alpha memory status --all-namespaces

# Repair if needed
npx claude-flow@alpha memory repair --namespace aicraftworks/shared
```

### Monitor won't start
```bash
# Check port availability
lsof -i :3000

# Use different port
./monitor-org.sh --port 8080
```

## 📊 Script Execution Times

| Script | Typical Time | Max Time |
|--------|-------------|----------|
| setup-central-repo.sh | 2 min | 5 min |
| deploy-cross-repo.sh | 2 min | 15 min |
| sync-memories.sh | 30 sec | 2 min |
| monitor-org.sh | instant | - |
| generate-report.sh | 10 sec | 1 min |

## 🔐 Security Notes

- Scripts use environment variables for API keys
- Never commit secrets to git
- Use GitHub Secrets for CI/CD
- Review agent permissions regularly
- Monitor agent activity for anomalies

## 📚 Additional Resources

- **Full Documentation**: `/docs/integrations/`
- **Quick Start**: `/docs/integrations/QUICKSTART.md`
- **Integration Guide**: `/docs/integrations/AICRAFTWORKS_ENTERPRISE_INTEGRATION.md`
- **Configuration**: `/docs/integrations/AICRAFTWORKS_CLAUDE_CONFIG.md`
- **Examples**: `/examples/aicraftworks/`

## 🆘 Support

Issues or questions:
- Check troubleshooting section above
- Review full documentation
- Check GitHub Issues
- Contact team lead

## 📝 Script Maintenance

Scripts are maintained in this repository and versioned with the integration.

**Last Updated**: 2025-10-28  
**Version**: 1.0.0  
**Maintainer**: AICraftWorksOrg Team
