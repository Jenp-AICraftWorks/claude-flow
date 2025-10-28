#!/bin/bash

################################################################################
# Example: Single Repository Development with Claude-Flow
# 
# This example shows how to deploy agents to develop a feature in a single repo
################################################################################

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    echo -e "${1}${2}${NC}"
}

print_message "$BLUE" "=========================================="
print_message "$BLUE" "Example: Single Repository Development"
print_message "$BLUE" "=========================================="
echo ""

# Configuration
REPO="user-service"
FEATURE="user authentication with JWT"
MEMORY_NS="aicraftworks/repos/${REPO}"

print_message "$YELLOW" "Repository: $REPO"
print_message "$YELLOW" "Feature: $FEATURE"
print_message "$YELLOW" "Memory Namespace: $MEMORY_NS"
echo ""

# Step 1: Initialize swarm
print_message "$BLUE" "Step 1: Initializing swarm for $REPO..."
npx claude-flow@alpha swarm init \
  --topology hierarchical \
  --max-agents 5 \
  --memory-namespace "$MEMORY_NS"

# Step 2: Query existing knowledge
print_message "$BLUE" "Step 2: Checking for existing authentication patterns..."
npx claude-flow@alpha memory vector-search \
  "authentication patterns JWT" \
  --namespace "aicraftworks/shared" \
  --k 5 || true

# Step 3: Spawn specialized agents
print_message "$BLUE" "Step 3: Spawning specialized agents..."

# Use SPARC methodology for systematic development
npx claude-flow@alpha sparc tdd "$FEATURE" \
  --repo "$REPO" \
  --agents backend-dev,tester,reviewer \
  --memory-namespace "$MEMORY_NS"

# Step 4: Store learnings
print_message "$BLUE" "Step 4: Storing learnings in shared memory..."
npx claude-flow@alpha memory store \
  "auth_jwt_implementation" \
  "JWT authentication implemented in $REPO with secure token handling" \
  --namespace "aicraftworks/shared/patterns" \
  --agentdb

# Step 5: Generate report
print_message "$BLUE" "Step 5: Generating development report..."
npx claude-flow@alpha metrics report \
  --repo "$REPO" \
  --time-range 1h \
  --output ".aicraftworks/reports/${REPO}-$(date +%Y%m%d-%H%M%S).json"

print_message "$GREEN" "✅ Single repository development complete!"
echo ""
print_message "$BLUE" "Next steps:"
echo "  1. Review the generated code in $REPO"
echo "  2. Run tests: cd $REPO && npm test"
echo "  3. Create PR: gh pr create --title 'Add JWT authentication'"
echo "  4. View report: cat .aicraftworks/reports/${REPO}-*.json"
