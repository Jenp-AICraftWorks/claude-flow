# AICraftWorksOrg GitHub Workflows for Claude-Flow

This directory contains GitHub Actions workflows for automated agent-based operations across the organization.

## Available Workflows

### 1. PR Review Automation (`pr-review.yml`)
Automatically reviews pull requests using Claude-Flow agents.

**Triggers:** Pull request opened/updated
**Agents:** code-review-swarm, security-manager, reviewer

### 2. Issue Triage (`issue-triage.yml`)
Automatically triages and labels new issues.

**Triggers:** Issue opened
**Agents:** issue-tracker

### 3. Release Automation (`release-automation.yml`)
Automates release preparation and deployment.

**Triggers:** Push to main branch
**Agents:** release-manager

### 4. Multi-Repo Sync (`multi-repo-sync.yml`)
Synchronizes changes across multiple repositories.

**Triggers:** Push to main, manual dispatch
**Agents:** multi-repo-swarm

### 5. Memory Sync (`memory-sync.yml`)
Synchronizes shared memory across repositories.

**Triggers:** Daily schedule, manual dispatch

## Setup Instructions

1. Copy workflow files to `.github/workflows/` in each repository
2. Configure secrets in repository settings:
   - `ANTHROPIC_API_KEY`: Your Anthropic API key
   - `GITHUB_TOKEN`: Automatically provided by GitHub Actions
3. Customize agent configuration in workflow files

## Example Usage

### Manual Workflow Dispatch
```bash
# Trigger multi-repo sync manually
gh workflow run multi-repo-sync.yml

# Trigger memory sync
gh workflow run memory-sync.yml
```

### View Workflow Results
```bash
# List workflow runs
gh run list --workflow=pr-review.yml

# View specific run
gh run view <run-id>
```

## Configuration

Edit workflow files to customize:
- Agent types and count
- Memory namespaces
- Trigger conditions
- Repository filters

## Troubleshooting

If workflows fail:
1. Check GitHub Actions logs
2. Verify API keys are set correctly
3. Ensure Claude-Flow is properly installed
4. Check repository permissions
