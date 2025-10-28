# 🚀 Quick Launch in CodeSpace

Click the button below to instantly open Claude-Flow in a secure GitHub Codespace:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Jenp-AICraftWorks/claude-flow)

## What This Does

1. Creates a new GitHub Codespace
2. Automatically installs all dependencies
3. Configures the development environment
4. Sets up Claude-Flow in an isolated container

## After Opening

Once your Codespace is ready, run:

```bash
# Setup the central repository
./scripts/aicraftworks/setup-central-repo.sh

# Test the installation
npx claude-flow@alpha --version

# Try a simple task
npx claude-flow@alpha swarm "create hello world API"
```

## Why Codespace?

✅ **Secure**: Isolated from your local machine  
✅ **Fast**: Pre-configured and ready to use  
✅ **Consistent**: Same environment for everyone  
✅ **Disposable**: Delete and recreate anytime  

## Alternative: Local Dev Container

If you prefer to run locally in a container:

1. Install [VSCode](https://code.visualstudio.com/)
2. Install [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Clone the repository
4. Open in VSCode
5. Press `F1` → "Dev Containers: Reopen in Container"

## Need Help?

- 📖 [Quick Start Guide](docs/integrations/QUICKSTART.md)
- 🔒 [Security Guidelines](docs/integrations/SECURITY.md)
- 📚 [Full Documentation](docs/integrations/AICRAFTWORKS_ENTERPRISE_INTEGRATION.md)
