#!/bin/bash

################################################################################
# Monitor Organization-Wide Agent Activity
# 
# Usage: ./monitor-org.sh [--port 3000]
################################################################################

PORT=${1:-3000}

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "=========================================="
print_message "$BLUE" "AICraftWorksOrg Monitoring Dashboard"
print_message "$BLUE" "=========================================="
echo ""
print_message "$BLUE" "Starting monitoring on port $PORT..."
print_message "$GREEN" "Dashboard will be available at: http://localhost:$PORT"
echo ""

npx claude-flow@alpha monitor \
  --repos "AICraftWorksOrg/*" \
  --agents all \
  --realtime true \
  --port "$PORT" \
  --metrics-export true
