#!/bin/bash

################################################################################
# Example: Cross-Repository Feature Development
# 
# This example shows how to coordinate feature development across multiple repos
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
print_message "$BLUE" "Example: Cross-Repository Development"
print_message "$BLUE" "=========================================="
echo ""

# Configuration
FEATURE="payment gateway integration"
REPOS="user-service,payment-service,api-gateway"
PROJECT_NS="aicraftworks/projects/payment-gateway"

print_message "$YELLOW" "Feature: $FEATURE"
print_message "$YELLOW" "Repositories: $REPOS"
print_message "$YELLOW" "Project Namespace: $PROJECT_NS"
echo ""

# Step 1: Architecture planning
print_message "$BLUE" "Step 1: Planning cross-repository architecture..."
npx claude-flow@alpha sparc run architect \
  "$FEATURE across microservices" \
  --multi-repo true

# Step 2: Initialize multi-repo swarm
print_message "$BLUE" "Step 2: Initializing multi-repository swarm..."
npx claude-flow@alpha swarm init \
  --topology mesh \
  --max-agents 12 \
  --multi-repo true

# Step 3: Create shared context
print_message "$BLUE" "Step 3: Creating shared project context..."
npx claude-flow@alpha memory store \
  "payment_architecture" \
  "Payment gateway integrates user-service for auth, payment-service for processing, api-gateway for routing" \
  --namespace "$PROJECT_NS" \
  --agentdb

# Step 4: Deploy coordinated agents
print_message "$BLUE" "Step 4: Deploying coordinated agent swarm..."
npx claude-flow@alpha hive-mind spawn \
  "$FEATURE" \
  --repos "$REPOS" \
  --coordination hierarchical \
  --memory-shared true \
  --agents system-architect,backend-dev,tester

# Step 5: Coordinate testing
print_message "$BLUE" "Step 5: Coordinating integration testing..."
npx claude-flow@alpha sparc run integration \
  "payment gateway integration tests" \
  --repos "$REPOS"

# Step 6: Sync memories across repos
print_message "$BLUE" "Step 6: Syncing learnings across repositories..."
IFS=',' read -ra REPO_ARRAY <<< "$REPOS"
for repo in "${REPO_ARRAY[@]}"; do
    npx claude-flow@alpha memory sync \
      --from "aicraftworks/repos/$repo" \
      --to "$PROJECT_NS" \
      --pattern "payment*" || true
done

# Step 7: Generate cross-repo report
print_message "$BLUE" "Step 7: Generating cross-repository report..."
mkdir -p .aicraftworks/reports
npx claude-flow@alpha metrics report \
  --repos "$REPOS" \
  --time-range 2h \
  --include agents,coordination,memory \
  --output ".aicraftworks/reports/payment-gateway-$(date +%Y%m%d-%H%M%S).json"

print_message "$GREEN" "✅ Cross-repository feature development complete!"
echo ""
print_message "$BLUE" "Next steps:"
echo "  1. Review changes in all repositories"
echo "  2. Run integration tests: ./test-integration.sh"
echo "  3. Create coordinated PRs:"
echo "     - gh pr create --repo user-service"
echo "     - gh pr create --repo payment-service"
echo "     - gh pr create --repo api-gateway"
echo "  4. Monitor swarm status: npx claude-flow@alpha swarm status"
