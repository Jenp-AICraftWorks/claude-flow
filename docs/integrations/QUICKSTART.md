# AICraftWorksOrg Claude-Flow Integration - Quick Start Guide

## Overview

This guide provides everything you need to integrate Claude-Flow into the AICraftWorksOrg enterprise for AI-powered agent swarming across all repositories.

## What You Get

### 🤖 54+ Specialized AI Agents
- **Core Development**: coder, reviewer, tester, planner, researcher
- **Backend**: backend-dev for microservices
- **Mobile**: mobile-dev for mobile apps
- **GitHub**: Automated PR reviews, issue triage, release management
- **Swarm Coordination**: Multi-agent orchestration across repos

### 🧠 Advanced Memory Systems
- **AgentDB**: 96x-164x faster vector search with semantic understanding
- **ReasoningBank**: Pattern matching with 2-3ms latency
- **Cross-Repo Memory**: Shared knowledge across all repositories

### 🛠️ 100+ MCP Tools
- Swarm coordination and orchestration
- Memory management and search
- GitHub integration and automation
- Performance monitoring and analytics

### ⚡ SPARC Methodology
- Systematic Test-Driven Development
- Specification → Pseudocode → Architecture → Refinement → Code
- Parallel execution across multiple repos

## Quick Start (5 Minutes)

### 1. Setup Central Repository

```bash
# Clone this repository
git clone https://github.com/Jenp-AICraftWorks/claude-flow
cd claude-flow

# Run automated setup
./scripts/aicraftworks/setup-central-repo.sh
```

This creates:
- `.aicraftworks/` - Configuration and scripts
- `.swarm/` - Memory and session storage
- Helper scripts for common operations

### 2. Test Installation

```bash
# Simple test
npx claude-flow@alpha swarm "create hello world API"

# Check status
npx claude-flow@alpha --version
```

### 3. Deploy to First Repository

```bash
# Single repository
./examples/aicraftworks/single-repo-example.sh

# Multiple repositories
./scripts/aicraftworks/deploy-cross-repo.sh \
  "implement authentication" \
  "user-service,api-gateway"
```

### 4. Monitor Activity

```bash
# Start monitoring dashboard
./scripts/aicraftworks/monitor-org.sh

# View at: http://localhost:3000
```

## Key Files and Directories

```
claude-flow/
├── docs/integrations/
│   ├── AICRAFTWORKS_ENTERPRISE_INTEGRATION.md  # Complete integration guide
│   ├── AICRAFTWORKS_CLAUDE_CONFIG.md           # Configuration reference
│   └── workflows/                              # GitHub Actions templates
│       ├── pr-review.yml                       # Automated PR reviews
│       ├── multi-repo-sync.yml                 # Cross-repo sync
│       └── memory-sync.yml                     # Memory synchronization
├── scripts/aicraftworks/
│   ├── setup-central-repo.sh                   # Initial setup
│   ├── deploy-cross-repo.sh                    # Multi-repo deployment
│   ├── sync-memories.sh                        # Memory sync
│   ├── monitor-org.sh                          # Monitoring dashboard
│   └── generate-report.sh                      # Performance reports
├── examples/aicraftworks/
│   ├── single-repo-example.sh                  # Single repo example
│   ├── cross-repo-example.sh                   # Multi-repo example
│   └── README.md                               # Examples documentation
└── .aicraftworks/                              # Created by setup script
    ├── agentdb.config.js                       # AgentDB configuration
    ├── permissions.yml                         # Agent permissions
    ├── repos.json                              # Repository registry
    └── scripts/                                # Helper scripts
```

## Common Use Cases

### Use Case 1: Single Feature Development

```bash
# Deploy agents to build a feature in one repo
npx claude-flow@alpha sparc tdd \
  "user authentication with JWT" \
  --repo user-service \
  --agents backend-dev,tester,reviewer
```

### Use Case 2: Cross-Repository Feature

```bash
# Coordinate feature across multiple repos
npx claude-flow@alpha hive-mind spawn \
  "implement payment gateway" \
  --repos "user-service,payment-service,api-gateway" \
  --coordination hierarchical
```

### Use Case 3: Organization-Wide Refactoring

```bash
# Deploy swarm across all repos
npx claude-flow@alpha swarm batch \
  --task "migrate to TypeScript" \
  --repos "AICraftWorksOrg/*" \
  --agents code-analyzer,coder,tester \
  --parallel true
```

### Use Case 4: Automated PR Reviews

Copy `.github/workflows/pr-review.yml` to each repository:

```bash
# Setup automated reviews
cp docs/integrations/workflows/pr-review.yml \
   ../user-service/.github/workflows/
```

## Memory Management

### Store Knowledge

```bash
# Store org-wide standards
npx claude-flow@alpha memory store \
  "typescript_standards" \
  "Use strict mode and explicit types" \
  --namespace aicraftworks/shared/standards \
  --agentdb
```

### Search Semantically

```bash
# Find related patterns
npx claude-flow@alpha memory vector-search \
  "authentication patterns" \
  --namespaces "aicraftworks/repos/*" \
  --k 10 \
  --threshold 0.7
```

### Sync Across Repos

```bash
# Sync learnings from repo to shared
./scripts/aicraftworks/sync-memories.sh user-service
```

## GitHub Actions Integration

### Setup in Each Repository

1. Copy workflow files:
```bash
cp docs/integrations/workflows/*.yml \
   ../your-repo/.github/workflows/
```

2. Add secrets in GitHub:
   - `ANTHROPIC_API_KEY`: Your Anthropic API key
   - `GITHUB_TOKEN`: Auto-provided by GitHub

3. Workflows automatically run on:
   - PRs (reviews and checks)
   - Issues (triage and labeling)
   - Pushes (sync and deploy)
   - Schedule (memory sync daily)

## Configuration

### AgentDB Configuration

Edit `.aicraftworks/agentdb.config.js`:

```javascript
module.exports = {
  vectorSearch: {
    algorithm: 'hnsw',        // Fast semantic search
    quantization: 'binary',   // 32x memory reduction
    dimensions: 1024,
    threshold: 0.7
  },
  rl: {
    algorithm: 'ppo',         // Reinforcement learning
    learningRate: 0.001
  },
  reflexion: {
    enabled: true,            // Learn from mistakes
    maxHistory: 100
  }
};
```

### Agent Permissions

Edit `.aicraftworks/permissions.yml`:

```yaml
agents:
  coder:
    repos: ["*"]
    operations: ["read", "write"]
    require_review: true
  
  release-manager:
    repos: ["*"]
    operations: ["read", "tag", "release"]
    require_approval: true
```

### Repository Registry

Edit `.aicraftworks/repos.json`:

```json
{
  "organization": "AICraftWorksOrg",
  "repositories": [
    {
      "name": "user-service",
      "type": "backend",
      "agents": ["backend-dev", "tester", "reviewer"],
      "memory_namespace": "aicraftworks/repos/user-service"
    }
  ]
}
```

## Monitoring & Reports

### Start Dashboard

```bash
# Real-time monitoring
./scripts/aicraftworks/monitor-org.sh
```

### Generate Reports

```bash
# Performance report for last 7 days
./scripts/aicraftworks/generate-report.sh 7d
```

### View Metrics

```bash
# Organization metrics
npx claude-flow@alpha metrics report \
  --org AICraftWorksOrg \
  --time-range 7d \
  --include agents,memory,performance,github
```

## Troubleshooting

### Common Issues

**Issue**: Agents not spawning
```bash
# Check swarm status
npx claude-flow@alpha swarm status

# Check logs
npx claude-flow@alpha logs agent-activity --last 1h
```

**Issue**: Memory not syncing
```bash
# Check memory health
npx claude-flow@alpha memory status --all-namespaces

# Repair if needed
npx claude-flow@alpha memory repair --namespace aicraftworks/shared
```

**Issue**: Performance slow
```bash
# Run diagnostics
npx claude-flow@alpha diagnostics --full

# Optimize
npx claude-flow@alpha memory optimize --vacuum --reindex
```

## Best Practices

1. **Start Small**: Test on one repo before expanding
2. **Use Memory**: Store and share learnings across repos
3. **Monitor Regularly**: Check dashboard daily
4. **Sync Frequently**: Run memory sync weekly
5. **Review Permissions**: Audit agent access monthly
6. **Batch Operations**: Use parallel processing for efficiency
7. **Namespace Organization**: Keep memory organized by domain
8. **Agent Coordination**: Use appropriate topology for task type

## Performance Benefits

- **10x faster development** through automation
- **Consistent quality** via automated reviews
- **Knowledge retention** through persistent memory
- **96x-164x faster search** with AgentDB
- **2.8-4.4x speed improvement** with parallel coordination

## Next Steps

1. **Week 1**: Setup central repo, test on pilot repo
2. **Week 2**: Deploy to 2-3 repositories
3. **Week 3**: Enable GitHub Actions automation
4. **Week 4**: Expand to all repositories
5. **Ongoing**: Monitor, optimize, and train agents

## Support & Resources

- **Documentation**: `/docs/integrations/`
- **Examples**: `/examples/aicraftworks/`
- **Scripts**: `/scripts/aicraftworks/`
- **GitHub Issues**: Report problems or request features
- **Team Wiki**: (Add your internal wiki)
- **Chat**: (Add your Slack/Discord)

## Key Benefits for AICraftWorksOrg

✅ **Enterprise-Wide Coordination**: Single source of truth for AI agents
✅ **Distributed Memory**: Shared knowledge across all repositories
✅ **Automated Workflows**: GitHub Actions for continuous automation
✅ **Multi-Repo Swarms**: Coordinate complex features across services
✅ **Performance Optimized**: AgentDB with 96x-164x faster search
✅ **54+ Specialized Agents**: Expert agents for every task
✅ **100+ MCP Tools**: Complete automation toolkit
✅ **SPARC Methodology**: Systematic TDD approach

---

**Ready to swarm? Start with the setup script:**

```bash
./scripts/aicraftworks/setup-central-repo.sh
```

**Questions?** See full documentation in `/docs/integrations/AICRAFTWORKS_ENTERPRISE_INTEGRATION.md`

---

**Version**: 1.0.0  
**Last Updated**: 2025-10-28  
**Organization**: AICraftWorksOrg
