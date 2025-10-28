# AICraftWorksOrg Claude-Flow Configuration

## 🚨 CRITICAL: CONCURRENT EXECUTION & FILE MANAGEMENT

**ABSOLUTE RULES**:
1. ALL operations MUST be concurrent/parallel in a single message
2. **NEVER save working files, text/mds and tests to the root folder**
3. ALWAYS organize files in appropriate subdirectories
4. **USE CLAUDE CODE'S TASK TOOL** for spawning agents concurrently, not just MCP

### ⚡ GOLDEN RULE: "1 MESSAGE = ALL RELATED OPERATIONS"

**MANDATORY PATTERNS:**
- **TodoWrite**: ALWAYS batch ALL todos in ONE call (5-10+ todos minimum)
- **Task tool (Claude Code)**: ALWAYS spawn ALL agents in ONE message with full instructions
- **File operations**: ALWAYS batch ALL reads/writes/edits in ONE message
- **Bash commands**: ALWAYS batch ALL terminal operations in ONE message
- **Memory operations**: ALWAYS batch ALL memory store/retrieve in ONE message

### 🎯 CRITICAL: Claude Code Task Tool for Agent Execution

**Claude Code's Task tool is the PRIMARY way to spawn agents:**
```javascript
// ✅ CORRECT: Use Claude Code's Task tool for parallel agent execution
[Single Message]:
  Task("Research agent", "Analyze requirements and patterns...", "researcher")
  Task("Coder agent", "Implement core features...", "coder")
  Task("Tester agent", "Create comprehensive tests...", "tester")
  Task("Reviewer agent", "Review code quality...", "reviewer")
  Task("Architect agent", "Design system architecture...", "system-architect")
```

### 📁 File Organization Rules

**NEVER save to root folder. Use these directories:**
- `/src` - Source code files
- `/tests` - Test files
- `/docs` - Documentation and markdown files
- `/config` - Configuration files
- `/scripts` - Utility scripts
- `/examples` - Example code

## AICraftWorksOrg Project Overview

This organization uses SPARC (Specification, Pseudocode, Architecture, Refinement, Completion) methodology with Claude-Flow orchestration for systematic Test-Driven Development across multiple repositories.

## Organization Structure

```
AICraftWorksOrg/
├── central-repository/          # Claude-Flow orchestration hub
├── user-service/               # User management microservice
├── payment-service/            # Payment processing
├── api-gateway/                # API gateway and routing
├── frontend-web/               # Web frontend application
├── frontend-mobile/            # Mobile application
└── shared-libraries/           # Shared code and utilities
```

## SPARC Commands for Multi-Repo

### Core Commands
- `npx claude-flow@alpha sparc modes` - List available modes
- `npx claude-flow@alpha sparc run <mode> "<task>"` - Execute specific mode
- `npx claude-flow@alpha sparc tdd "<feature>"` - Run complete TDD workflow
- `npx claude-flow@alpha sparc info <mode>` - Get mode details

### Multi-Repo Commands
- `npx claude-flow@alpha github multi-repo "<task>" --repos "user-service,payment-service"`
- `npx claude-flow@alpha swarm batch --repos "AICraftWorksOrg/*"`
- `npx claude-flow@alpha hive-mind spawn "<task>" --multi-repo true`

### Build Commands (Per Repository)
- `npm run build` - Build project
- `npm run test` - Run tests
- `npm run lint` - Linting
- `npm run typecheck` - Type checking

## Agent Configuration for AICraftWorksOrg

### 🚀 Available Agents (54 Total)

#### Core Development (Use for all repos)
`coder`, `reviewer`, `tester`, `planner`, `researcher`

#### Swarm Coordination (Multi-repo work)
`hierarchical-coordinator`, `mesh-coordinator`, `adaptive-coordinator`, `collective-intelligence-coordinator`, `swarm-memory-manager`

#### GitHub & Repository (Automated workflows)
`github-modes`, `pr-manager`, `code-review-swarm`, `issue-tracker`, `release-manager`, `workflow-automation`, `project-board-sync`, `repo-architect`, `multi-repo-swarm`

#### Specialized Development (Per service type)
- **Backend**: `backend-dev` (for user-service, payment-service, api-gateway)
- **Frontend**: `mobile-dev` (for frontend-mobile)
- **ML/AI**: `ml-developer` (for AI features)
- **Architecture**: `system-architect` (for cross-service design)

#### SPARC Methodology
`sparc-coord`, `sparc-coder`, `specification`, `pseudocode`, `architecture`, `refinement`

#### Testing & Validation
`tdd-london-swarm`, `production-validator`

## Memory System Configuration

### Namespace Strategy for AICraftWorksOrg

```
aicraftworks/
├── central/                    # Central coordination
├── shared/                     # Org-wide knowledge
│   ├── standards/             # Coding standards
│   ├── patterns/              # Design patterns
│   └── best-practices/        # Best practices
├── repos/
│   ├── user-service/          # User service memory
│   ├── payment-service/       # Payment service memory
│   ├── api-gateway/           # API gateway memory
│   ├── frontend-web/          # Web frontend memory
│   └── frontend-mobile/       # Mobile memory
└── projects/
    ├── auth-system/           # Cross-cutting projects
    └── payment-integration/
```

### Memory Commands

```bash
# Store org-wide knowledge
npx claude-flow@alpha memory store \
  "typescript_standards" "Use strict mode and explicit types" \
  --namespace aicraftworks/shared/standards \
  --agentdb

# Query across repositories
npx claude-flow@alpha memory vector-search \
  "authentication patterns" \
  --namespaces "aicraftworks/repos/*" \
  --k 10 --threshold 0.7

# Share learnings
npx claude-flow@alpha memory sync \
  --from aicraftworks/repos/user-service \
  --to aicraftworks/shared/patterns
```

## 🎯 Agent Execution Patterns

### Pattern 1: Single Repository Feature
```javascript
[Single Message - Deploy to one repo]:
  Task("Backend Developer", "Build user authentication API in user-service. Use hooks for coordination.", "backend-dev")
  Task("Tester", "Write tests for authentication. Check memory for API contracts.", "tester")
  Task("Reviewer", "Review authentication code. Document findings.", "reviewer")
  
  // Memory operations
  memory_store("user-service/auth", "Authentication endpoints implemented")
  
  // Batch todos
  TodoWrite { todos: [
    {id: "1", content: "Implement auth API", status: "in_progress"},
    {id: "2", content: "Write tests", status: "in_progress"},
    {id: "3", content: "Code review", status: "pending"},
    {id: "4", content: "Deploy to staging", status: "pending"}
  ]}
```

### Pattern 2: Cross-Repository Feature
```javascript
[Single Message - Deploy across repos]:
  Task("System Architect", "Design payment gateway integration across services.", "system-architect")
  Task("Backend Dev 1", "Implement payment service endpoints. Coordinate with API gateway.", "backend-dev")
  Task("Backend Dev 2", "Update API gateway routing for payments.", "backend-dev")
  Task("Tester", "Create integration tests across services.", "tester")
  
  // Cross-repo memory
  memory_store("aicraftworks/projects/payment-integration", "Payment flow design")
  
  // Coordination todos
  TodoWrite { todos: [
    {id: "1", content: "Design payment architecture", status: "in_progress"},
    {id: "2", content: "Implement in payment-service", status: "pending"},
    {id: "3", content: "Update api-gateway", status: "pending"},
    {id: "4", content: "Integration testing", status: "pending"},
    {id: "5", content: "Deploy coordination", status: "pending"}
  ]}
```

### Pattern 3: Organization-Wide Refactoring
```javascript
[Single Message - Org-wide swarm]:
  Task("Code Analyzer", "Analyze TypeScript migration needs across all repos.", "code-analyzer")
  Task("Architect", "Design migration strategy and dependencies.", "system-architect")
  
  // Per-repo agents (spawned in parallel)
  Task("Coder 1", "Migrate user-service to TypeScript.", "coder")
  Task("Coder 2", "Migrate payment-service to TypeScript.", "coder")
  Task("Coder 3", "Migrate api-gateway to TypeScript.", "coder")
  
  // Testing swarm
  Task("Test Coordinator", "Coordinate testing across all repos.", "tdd-london-swarm")
  
  // Batch todos for entire org
  TodoWrite { todos: [
    {id: "1", content: "Analyze migration scope", status: "in_progress"},
    {id: "2", content: "Design migration strategy", status: "in_progress"},
    {id: "3", content: "Migrate user-service", status: "pending"},
    {id: "4", content: "Migrate payment-service", status: "pending"},
    {id: "5", content: "Migrate api-gateway", status: "pending"},
    {id: "6", content: "Integration testing", status: "pending"},
    {id: "7", content: "Update documentation", status: "pending"},
    {id: "8", content: "Deploy coordinated rollout", status: "pending"}
  ]}
```

## 📋 Agent Coordination Protocol

### Every Agent Spawned via Task Tool MUST:

**1️⃣ BEFORE Work:**
```bash
npx claude-flow@alpha hooks pre-task --description "[task]" --repo "[repo-name]"
npx claude-flow@alpha hooks session-restore --session-id "aicraftworks-[id]"
npx claude-flow@alpha memory query "[context]" --namespace "aicraftworks/repos/[repo-name]"
```

**2️⃣ DURING Work:**
```bash
npx claude-flow@alpha hooks post-edit --file "[file]" --memory-key "aicraftworks/repos/[repo]/[step]"
npx claude-flow@alpha hooks notify --message "[what was done]" --broadcast true
npx claude-flow@alpha memory store "[key]" "[value]" --namespace "aicraftworks/repos/[repo]" --agentdb
```

**3️⃣ AFTER Work:**
```bash
npx claude-flow@alpha hooks post-task --task-id "[task]"
npx claude-flow@alpha hooks session-end --export-metrics true
npx claude-flow@alpha memory sync --from "aicraftworks/repos/[repo]" --to "aicraftworks/shared"
```

## GitHub Workflows Integration

### Automated PR Review
```yaml
# .github/workflows/claude-flow-review.yml
name: AICraftWorks PR Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Claude-Flow Review
        run: |
          npx claude-flow@alpha github pr-review \
            --pr ${{ github.event.pull_request.number }} \
            --agents code-review-swarm,security-manager \
            --memory-namespace aicraftworks/repos/${{ github.repository }}
```

### Cross-Repo Coordination
```yaml
# .github/workflows/multi-repo-sync.yml
name: Multi-Repo Sync
on:
  push:
    branches: [main]
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Sync Changes
        run: |
          npx claude-flow@alpha github multi-repo sync \
            --source ${{ github.repository }} \
            --targets "user-service,payment-service,api-gateway" \
            --agent multi-repo-swarm
```

## MCP Tools Configuration

### Required MCP Servers
```bash
# Core Claude Flow (Required)
claude mcp add claude-flow npx claude-flow@alpha mcp start

# Enhanced Coordination (Recommended)
claude mcp add ruv-swarm npx ruv-swarm mcp start

# Cloud Features (Optional)
claude mcp add flow-nexus npx flow-nexus@latest mcp start
```

### MCP Tool Usage Patterns

#### Coordination
```javascript
// Initialize org-wide swarm
mcp__claude-flow__swarm_init({
  topology: "mesh",
  maxAgents: 20,
  namespace: "aicraftworks",
  repos: ["user-service", "payment-service", "api-gateway"]
})

// Spawn specialized agents
mcp__claude-flow__agent_spawn({
  type: "backend-dev",
  count: 3,
  repos: ["user-service", "payment-service", "api-gateway"]
})
```

#### Memory Management
```javascript
// Store org knowledge
mcp__claude-flow__memory_usage({
  operation: "store",
  key: "aicraftworks/shared/patterns/auth",
  value: "OAuth2 with JWT tokens",
  agentdb: true
})

// Vector search across repos
mcp__claude-flow__memory_search({
  query: "payment processing patterns",
  namespaces: ["aicraftworks/repos/*"],
  k: 10,
  semantic: true
})
```

## Performance Optimization

### AgentDB Configuration
```javascript
// .aicraftworks/agentdb.config.js
module.exports = {
  vectorSearch: {
    algorithm: 'hnsw',
    quantization: 'binary',     // 32x memory reduction
    dimensions: 1024,
    threshold: 0.7
  },
  rl: {
    algorithm: 'ppo',
    learningRate: 0.001
  },
  reflexion: {
    enabled: true,
    maxHistory: 100
  }
};
```

### Batch Processing
```bash
# Process multiple repos in parallel
npx claude-flow@alpha sparc batch \
  research,architecture,code \
  "implement observability" \
  --repos "user-service,payment-service,api-gateway" \
  --parallel true \
  --max-concurrent 3
```

## Security Configuration

### API Keys & Secrets
```bash
# Store in GitHub Secrets
ANTHROPIC_API_KEY="your-key"
GITHUB_TOKEN="your-token"

# Or use secure secret management
npx claude-flow@alpha secrets init \
  --provider github-secrets \
  --org AICraftWorksOrg
```

### Agent Permissions
```yaml
# .aicraftworks/permissions.yml
agents:
  coder:
    repos: ["*"]
    operations: ["read", "write"]
    require_review: true
  
  release-manager:
    repos: ["*"]
    operations: ["read", "tag", "release"]
    require_approval: true
  
  multi-repo-swarm:
    repos: ["*"]
    operations: ["read", "coordinate"]
    cross_repo: true
```

## Monitoring & Analytics

### Dashboard
```bash
# Start monitoring for all repos
npx claude-flow@alpha monitor \
  --repos "AICraftWorksOrg/*" \
  --agents all \
  --realtime true \
  --port 3000
```

### Metrics
```bash
# Generate org-wide metrics
npx claude-flow@alpha metrics report \
  --org AICraftWorksOrg \
  --time-range 7d \
  --include agents,memory,performance,github
```

## Best Practices for AICraftWorksOrg

### 1. Repository Organization
- One agent swarm per repository for focused work
- Use multi-repo-swarm for cross-cutting concerns
- Maintain clear ownership boundaries

### 2. Memory Management
- Use AgentDB for semantic search and learning
- Organize namespaces by repo and project
- Sync important learnings to shared namespace
- Regular cleanup to prevent bloat

### 3. Agent Coordination
- Hierarchical for well-defined tasks
- Mesh for exploratory/research work
- Adaptive for complex multi-phase projects
- Limit to 5-10 concurrent agents per repo

### 4. GitHub Integration
- Automate PR reviews for consistency
- Use issue triage for faster response
- Implement release automation
- Setup webhooks for real-time coordination

### 5. Performance
- Enable AgentDB quantization for memory efficiency
- Use batch processing for multiple repos
- Pre-warm caches with common queries
- Monitor and optimize regularly

## Support

- **Documentation**: https://github.com/ruvnet/claude-flow
- **Issues**: https://github.com/AICraftWorksOrg/central-repository/issues
- **Internal Wiki**: (Add your internal wiki link)
- **Team Channel**: (Add your Slack/Discord channel)

---

Remember: **Claude Flow coordinates, Claude Code creates!**

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
Never save working files, text/mds and tests to the root folder.

---

**Version**: 1.0.0  
**Last Updated**: 2025-10-28  
**Organization**: AICraftWorksOrg
