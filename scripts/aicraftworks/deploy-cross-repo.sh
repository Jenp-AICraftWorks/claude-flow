#!/bin/bash

################################################################################
# Deploy Agent Swarm Across Multiple Repositories
# 
# Usage: ./deploy-cross-repo.sh "task description" "repo1,repo2,repo3"
################################################################################

set -e

# Configuration
ORG_NAME="AICraftWorksOrg"
MEMORY_NAMESPACE="aicraftworks"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 '<task description>' 'repo1,repo2,repo3'"
    echo ""
    echo "Example:"
    echo "  $0 'implement authentication' 'user-service,api-gateway'"
    echo ""
    echo "  $0 'add logging' 'user-service,payment-service,api-gateway'"
    exit 1
fi

TASK=$1
REPOS=$2

print_message "$BLUE" "=========================================="
print_message "$BLUE" "Multi-Repo Agent Swarm Deployment"
print_message "$BLUE" "=========================================="
echo ""
print_message "$YELLOW" "Task: $TASK"
print_message "$YELLOW" "Repos: $REPOS"
echo ""

# Initialize swarm coordination
print_message "$BLUE" "Initializing multi-repo swarm coordination..."
npx claude-flow@alpha swarm init \
  --topology mesh \
  --max-agents 15 \
  --multi-repo true

# Deploy agents
print_message "$BLUE" "Deploying specialized agents across repositories..."

# Split repos into array
IFS=',' read -ra REPO_ARRAY <<< "$REPOS"

# Spawn agents for each repo
for repo in "${REPO_ARRAY[@]}"; do
    print_message "$YELLOW" "Spawning agents for $repo..."
    
    npx claude-flow@alpha agent_spawn \
      --type backend-dev \
      --repo "$repo" \
      --memory-namespace "${MEMORY_NAMESPACE}/repos/$repo" &
    
    npx claude-flow@alpha agent_spawn \
      --type tester \
      --repo "$repo" \
      --memory-namespace "${MEMORY_NAMESPACE}/repos/$repo" &
done

# Wait for all background spawns
wait

# Execute the task
print_message "$BLUE" "Executing task across repositories..."
npx claude-flow@alpha hive-mind spawn "$TASK" \
  --repos "$REPOS" \
  --coordination hierarchical \
  --memory-shared true \
  --claude

print_message "$GREEN" "✅ Multi-repo deployment complete!"
echo ""
print_message "$BLUE" "To monitor progress:"
echo "  npx claude-flow@alpha swarm status"
echo ""
print_message "$BLUE" "To view agent activity:"
echo "  npx claude-flow@alpha logs agent-activity --repos '$REPOS'"
