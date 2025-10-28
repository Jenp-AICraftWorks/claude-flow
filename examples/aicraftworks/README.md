# AICraftWorksOrg Examples

This directory contains practical examples for using Claude-Flow across the AICraftWorksOrg enterprise.

## Examples

### 1. Single Repository Development
See `single-repo-example.sh` for deploying agents to a single repository.

### 2. Cross-Repository Feature Development
See `cross-repo-example.sh` for coordinating work across multiple repositories.

### 3. Organization-Wide Refactoring
See `org-wide-refactor.sh` for large-scale changes across all repositories.

### 4. Automated PR Review
See `../docs/integrations/workflows/pr-review.yml` for GitHub Actions integration.

### 5. Memory Management
See `memory-examples.sh` for working with shared memory across repos.

## Quick Start

```bash
# 1. Setup central repository (run once)
cd central-repository
../scripts/aicraftworks/setup-central-repo.sh

# 2. Deploy to single repo
./examples/aicraftworks/single-repo-example.sh

# 3. Deploy across multiple repos
./examples/aicraftworks/cross-repo-example.sh

# 4. Monitor activity
./scripts/aicraftworks/monitor-org.sh
```

## Configuration Examples

### AgentDB Configuration
```javascript
// .aicraftworks/agentdb.config.js
module.exports = {
  vectorSearch: {
    algorithm: 'hnsw',
    quantization: 'binary',
    dimensions: 1024,
    threshold: 0.7
  },
  rl: {
    algorithm: 'ppo',
    learningRate: 0.001
  }
};
```

### Repository Registry
```json
// .aicraftworks/repos.json
{
  "organization": "AICraftWorksOrg",
  "repositories": [
    {
      "name": "user-service",
      "type": "backend",
      "agents": ["backend-dev", "tester", "reviewer"]
    }
  ]
}
```

### Agent Permissions
```yaml
# .aicraftworks/permissions.yml
agents:
  coder:
    repos: ["*"]
    operations: ["read", "write"]
    require_review: true
```

## Directory Structure

```
examples/aicraftworks/
├── README.md                    # This file
├── single-repo-example.sh       # Single repo deployment
├── cross-repo-example.sh        # Multi-repo coordination
├── org-wide-refactor.sh         # Organization-wide changes
├── memory-examples.sh           # Memory management examples
└── config-templates/            # Configuration templates
    ├── agentdb.config.js
    ├── permissions.yml
    └── repos.json
```

## Best Practices

1. **Start Small**: Begin with a single repository before expanding
2. **Use Memory Wisely**: Organize namespaces by domain
3. **Monitor Regularly**: Use monitoring dashboard to track agent activity
4. **Sync Frequently**: Sync learnings to shared memory regularly
5. **Review Permissions**: Ensure agents have appropriate access levels

## Troubleshooting

See main documentation:
- `/docs/integrations/AICRAFTWORKS_ENTERPRISE_INTEGRATION.md`
- `/docs/integrations/AICRAFTWORKS_CLAUDE_CONFIG.md`

## Support

- GitHub Issues: Report problems or request features
- Internal Wiki: (Add your wiki link)
- Team Channel: (Add your Slack/Discord)
