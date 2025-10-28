#!/bin/bash

################################################################################
# Generate Organization Performance Report
# 
# Usage: ./generate-report.sh [time-range]
################################################################################

TIME_RANGE=${1:-7d}

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "=========================================="
print_message "$BLUE" "AICraftWorksOrg Performance Report"
print_message "$BLUE" "=========================================="
echo ""
print_message "$YELLOW" "Generating report for last $TIME_RANGE..."
echo ""

# Create reports directory if it doesn't exist
mkdir -p .aicraftworks/reports

REPORT_FILE=".aicraftworks/reports/performance-$(date +%Y%m%d-%H%M%S).json"

# Generate metrics report
npx claude-flow@alpha metrics report \
  --org AICraftWorksOrg \
  --time-range "$TIME_RANGE" \
  --include agents,memory,performance,github \
  --output "$REPORT_FILE"

print_message "$GREEN" "✅ Report generated: $REPORT_FILE"
echo ""

# Display summary
print_message "$BLUE" "Summary Statistics:"
npx claude-flow@alpha metrics summary \
  --file "$REPORT_FILE"

echo ""
print_message "$BLUE" "Full report saved to: $REPORT_FILE"
