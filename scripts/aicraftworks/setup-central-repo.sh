#!/bin/bash

################################################################################
# AICraftWorksOrg Central Repository Setup Script
# 
# This script initializes Claude-Flow in the central repository and configures
# it for enterprise-wide agent swarm coordination across all organization repos.
#
# Usage: ./setup-central-repo.sh
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ORG_NAME="AICraftWorksOrg"
CENTRAL_REPO="central-repository"
MEMORY_NAMESPACE="aicraftworks"

# Print colored message
print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo ""
    print_message "$BLUE" "=========================================="
    print_message "$BLUE" "$1"
    print_message "$BLUE" "=========================================="
    echo ""
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_message "$RED" "❌ Node.js is not installed. Please install Node.js 20+ first."
        exit 1
    fi
    
    node_version=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$node_version" -lt 20 ]; then
        print_message "$RED" "❌ Node.js version 20+ is required. Current version: $(node -v)"
        exit 1
    fi
    print_message "$GREEN" "✅ Node.js $(node -v) detected"
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        print_message "$RED" "❌ npm is not installed."
        exit 1
    fi
    print_message "$GREEN" "✅ npm $(npm -v) detected"
    
    # Check git
    if ! command -v git &> /dev/null; then
        print_message "$RED" "❌ git is not installed."
        exit 1
    fi
    print_message "$GREEN" "✅ git $(git --version | cut -d' ' -f3) detected"
}

# Install Claude-Flow
install_claude_flow() {
    print_header "Installing Claude-Flow"
    
    print_message "$YELLOW" "Installing Claude-Flow alpha version..."
    npm install -g claude-flow@alpha --silent
    
    if [ $? -eq 0 ]; then
        print_message "$GREEN" "✅ Claude-Flow installed successfully"
        npx claude-flow@alpha --version
    else
        print_message "$RED" "❌ Failed to install Claude-Flow"
        exit 1
    fi
}

# Initialize Claude-Flow
initialize_claude_flow() {
    print_header "Initializing Claude-Flow"
    
    print_message "$YELLOW" "Initializing Claude-Flow with project name: ${ORG_NAME}-${CENTRAL_REPO}..."
    npx claude-flow@alpha init --force --project-name "${ORG_NAME}-${CENTRAL_REPO}"
    
    if [ $? -eq 0 ]; then
        print_message "$GREEN" "✅ Claude-Flow initialized successfully"
    else
        print_message "$RED" "❌ Failed to initialize Claude-Flow"
        exit 1
    fi
}

# Setup directory structure
setup_directories() {
    print_header "Setting Up Directory Structure"
    
    print_message "$YELLOW" "Creating AICraftWorks configuration directories..."
    
    # Create main config directory
    mkdir -p .aicraftworks/claude-flow
    mkdir -p .aicraftworks/configs
    mkdir -p .aicraftworks/templates
    mkdir -p .aicraftworks/scripts
    mkdir -p .aicraftworks/logs
    
    print_message "$GREEN" "✅ Created .aicraftworks/ directory structure"
    
    # Create memory directories
    mkdir -p .swarm/memory
    mkdir -p .swarm/sessions
    mkdir -p .swarm/metrics
    
    print_message "$GREEN" "✅ Created .swarm/ directory structure"
    
    # Create docs directory if it doesn't exist
    mkdir -p docs/aicraftworks
    mkdir -p docs/workflows
    mkdir -p docs/agents
    
    print_message "$GREEN" "✅ Created documentation directories"
}

# Configure memory system
configure_memory() {
    print_header "Configuring Memory System"
    
    print_message "$YELLOW" "Initializing AgentDB and ReasoningBank..."
    
    # Initialize memory with org namespace
    npx claude-flow@alpha memory init --namespace "${MEMORY_NAMESPACE}-central"
    
    if [ $? -eq 0 ]; then
        print_message "$GREEN" "✅ Memory system initialized"
    else
        print_message "$YELLOW" "⚠️  Memory initialization had warnings (this is normal)"
    fi
    
    # Create memory namespace structure
    print_message "$YELLOW" "Creating memory namespace structure..."
    npx claude-flow@alpha memory store "org_name" "${ORG_NAME}" --namespace "${MEMORY_NAMESPACE}/central"
    npx claude-flow@alpha memory store "setup_date" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" --namespace "${MEMORY_NAMESPACE}/central"
    
    print_message "$GREEN" "✅ Memory namespaces configured"
}

# Install optional dependencies
install_optional_deps() {
    print_header "Installing Optional Dependencies"
    
    print_message "$YELLOW" "Installing AgentDB for high-performance vector search..."
    npm install agentdb@1.3.9 --save-optional --silent
    
    if [ $? -eq 0 ]; then
        print_message "$GREEN" "✅ AgentDB installed"
    else
        print_message "$YELLOW" "⚠️  AgentDB installation had warnings (optional)"
    fi
}

# Setup MCP servers
setup_mcp_servers() {
    print_header "Setting Up MCP Servers"
    
    print_message "$YELLOW" "Configuring MCP servers..."
    print_message "$BLUE" "Run these commands manually to add MCP servers:"
    echo ""
    echo "  claude mcp add claude-flow npx claude-flow@alpha mcp start"
    echo "  claude mcp add ruv-swarm npx ruv-swarm mcp start"
    echo "  claude mcp add flow-nexus npx flow-nexus@latest mcp start"
    echo ""
}

# Create configuration files
create_config_files() {
    print_header "Creating Configuration Files"
    
    # Create AgentDB config
    cat > .aicraftworks/agentdb.config.js << 'EOF'
module.exports = {
  vectorSearch: {
    algorithm: 'hnsw',
    quantization: 'binary',     // 32x memory reduction
    dimensions: 1024,
    threshold: 0.7
  },
  rl: {
    algorithm: 'ppo',            // Proximal Policy Optimization
    learningRate: 0.001
  },
  reflexion: {
    enabled: true,
    maxHistory: 100
  },
  cache: {
    enabled: true,
    ttl: 3600
  }
};
EOF
    print_message "$GREEN" "✅ Created AgentDB configuration"
    
    # Create agent permissions
    cat > .aicraftworks/permissions.yml << EOF
# AICraftWorksOrg Agent Permissions
agents:
  coder:
    repos: ["*"]
    operations: ["read", "write"]
    require_review: true
  
  reviewer:
    repos: ["*"]
    operations: ["read", "comment"]
    auto_approve: false
  
  tester:
    repos: ["*"]
    operations: ["read", "write"]
    require_review: true
  
  release-manager:
    repos: ["*"]
    operations: ["read", "tag", "release"]
    require_approval: true
  
  multi-repo-swarm:
    repos: ["*"]
    operations: ["read", "coordinate", "sync"]
    cross_repo: true
  
  security-manager:
    repos: ["*"]
    operations: ["read", "audit"]
    auto_block: true
EOF
    print_message "$GREEN" "✅ Created agent permissions"
    
    # Create repository registry
    cat > .aicraftworks/repos.json << EOF
{
  "organization": "${ORG_NAME}",
  "central_repo": "${CENTRAL_REPO}",
  "repositories": [
    {
      "name": "user-service",
      "type": "backend",
      "agents": ["backend-dev", "tester", "reviewer"],
      "memory_namespace": "${MEMORY_NAMESPACE}/repos/user-service"
    },
    {
      "name": "payment-service",
      "type": "backend",
      "agents": ["backend-dev", "tester", "reviewer"],
      "memory_namespace": "${MEMORY_NAMESPACE}/repos/payment-service"
    },
    {
      "name": "api-gateway",
      "type": "backend",
      "agents": ["backend-dev", "tester", "reviewer"],
      "memory_namespace": "${MEMORY_NAMESPACE}/repos/api-gateway"
    },
    {
      "name": "frontend-web",
      "type": "frontend",
      "agents": ["coder", "tester", "reviewer"],
      "memory_namespace": "${MEMORY_NAMESPACE}/repos/frontend-web"
    },
    {
      "name": "frontend-mobile",
      "type": "mobile",
      "agents": ["mobile-dev", "tester", "reviewer"],
      "memory_namespace": "${MEMORY_NAMESPACE}/repos/frontend-mobile"
    }
  ]
}
EOF
    print_message "$GREEN" "✅ Created repository registry"
}

# Create helper scripts
create_helper_scripts() {
    print_header "Creating Helper Scripts"
    
    # Multi-repo deployment script
    cat > .aicraftworks/scripts/deploy-multi-repo.sh << 'EOF'
#!/bin/bash
# Deploy agent swarm across multiple repositories
TASK=$1
REPOS=$2

if [ -z "$TASK" ] || [ -z "$REPOS" ]; then
    echo "Usage: ./deploy-multi-repo.sh '<task>' 'repo1,repo2,repo3'"
    exit 1
fi

npx claude-flow@alpha hive-mind spawn "$TASK" \
  --repos "$REPOS" \
  --coordination hierarchical \
  --memory-shared true \
  --claude
EOF
    chmod +x .aicraftworks/scripts/deploy-multi-repo.sh
    print_message "$GREEN" "✅ Created deploy-multi-repo.sh"
    
    # Monitor script
    cat > .aicraftworks/scripts/monitor.sh << 'EOF'
#!/bin/bash
# Start monitoring dashboard for all repositories
npx claude-flow@alpha monitor \
  --repos "AICraftWorksOrg/*" \
  --agents all \
  --realtime true \
  --port 3000
EOF
    chmod +x .aicraftworks/scripts/monitor.sh
    print_message "$GREEN" "✅ Created monitor.sh"
    
    # Memory sync script
    cat > .aicraftworks/scripts/sync-memory.sh << 'EOF'
#!/bin/bash
# Sync memory from individual repos to shared namespace
REPO=$1

if [ -z "$REPO" ]; then
    echo "Usage: ./sync-memory.sh <repo-name>"
    exit 1
fi

npx claude-flow@alpha memory sync \
  --from "aicraftworks/repos/$REPO" \
  --to "aicraftworks/shared" \
  --pattern "*"
EOF
    chmod +x .aicraftworks/scripts/sync-memory.sh
    print_message "$GREEN" "✅ Created sync-memory.sh"
}

# Create .gitignore
create_gitignore() {
    print_header "Configuring Git"
    
    # Add to .gitignore
    cat >> .gitignore << EOF

# AICraftWorks Claude-Flow
.aicraftworks/logs/
.aicraftworks/secrets/
.swarm/sessions/
.swarm/memory/*.db-wal
.swarm/memory/*.db-shm
.claude-flow/training/
node_modules/
EOF
    print_message "$GREEN" "✅ Updated .gitignore"
}

# Display summary
display_summary() {
    print_header "Setup Complete!"
    
    print_message "$GREEN" "✅ Claude-Flow has been successfully configured for ${ORG_NAME}"
    echo ""
    print_message "$BLUE" "📁 Configuration Location:"
    echo "   .aicraftworks/"
    echo ""
    print_message "$BLUE" "🚀 Next Steps:"
    echo ""
    echo "1. Review configuration files:"
    echo "   - .aicraftworks/agentdb.config.js"
    echo "   - .aicraftworks/permissions.yml"
    echo "   - .aicraftworks/repos.json"
    echo ""
    echo "2. Setup MCP servers:"
    echo "   claude mcp add claude-flow npx claude-flow@alpha mcp start"
    echo ""
    echo "3. Test the installation:"
    echo "   npx claude-flow@alpha swarm 'test hello world'"
    echo ""
    echo "4. Deploy to your first repository:"
    echo "   .aicraftworks/scripts/deploy-multi-repo.sh 'build authentication' 'user-service'"
    echo ""
    echo "5. Start monitoring:"
    echo "   .aicraftworks/scripts/monitor.sh"
    echo ""
    print_message "$BLUE" "📚 Documentation:"
    echo "   docs/integrations/AICRAFTWORKS_ENTERPRISE_INTEGRATION.md"
    echo "   docs/integrations/AICRAFTWORKS_CLAUDE_CONFIG.md"
    echo ""
    print_message "$GREEN" "Happy swarming! 🐝"
}

# Main execution
main() {
    print_header "AICraftWorksOrg Central Repository Setup"
    print_message "$BLUE" "This script will configure Claude-Flow for enterprise-wide agent coordination"
    
    check_prerequisites
    install_claude_flow
    initialize_claude_flow
    setup_directories
    configure_memory
    install_optional_deps
    create_config_files
    create_helper_scripts
    create_gitignore
    setup_mcp_servers
    display_summary
}

# Run main function
main
