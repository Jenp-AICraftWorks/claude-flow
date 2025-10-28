#!/bin/bash

################################################################################
# Sync Memory Across Repositories
# 
# Usage: ./sync-memories.sh [source-repo] [target-namespace]
################################################################################

set -e

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

print_message "$BLUE" "=========================================="
print_message "$BLUE" "Memory Synchronization Tool"
print_message "$BLUE" "=========================================="
echo ""

if [ $# -eq 0 ]; then
    # Sync all repos to shared
    print_message "$YELLOW" "Syncing all repositories to shared namespace..."
    
    for repo in user-service payment-service api-gateway frontend-web frontend-mobile; do
        print_message "$BLUE" "Syncing $repo..."
        npx claude-flow@alpha memory sync \
          --from "${MEMORY_NAMESPACE}/repos/$repo" \
          --to "${MEMORY_NAMESPACE}/shared" \
          --pattern "*" || true
    done
    
elif [ $# -eq 1 ]; then
    # Sync specific repo to shared
    SOURCE_REPO=$1
    print_message "$YELLOW" "Syncing $SOURCE_REPO to shared namespace..."
    
    npx claude-flow@alpha memory sync \
      --from "${MEMORY_NAMESPACE}/repos/$SOURCE_REPO" \
      --to "${MEMORY_NAMESPACE}/shared" \
      --pattern "*"
      
else
    # Sync specific repo to specific target
    SOURCE_REPO=$1
    TARGET=$2
    print_message "$YELLOW" "Syncing $SOURCE_REPO to $TARGET..."
    
    npx claude-flow@alpha memory sync \
      --from "${MEMORY_NAMESPACE}/repos/$SOURCE_REPO" \
      --to "${TARGET}" \
      --pattern "*"
fi

print_message "$GREEN" "✅ Memory synchronization complete!"
echo ""
print_message "$BLUE" "To verify synced memories:"
echo "  npx claude-flow@alpha memory list --namespace ${MEMORY_NAMESPACE}/shared"
