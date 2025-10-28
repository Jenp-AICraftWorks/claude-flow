# Claude-Flow DevContainer Configuration

## 🔒 Security-First Approach

This DevContainer configuration ensures Claude-Flow runs in an isolated GitHub Codespace environment, protecting your local machine from potential security risks.

## Features

- **Node.js 20**: Pre-configured with the required Node.js version
- **GitHub CLI**: Integrated for repository operations
- **Docker-in-Docker**: Support for containerized workflows
- **VSCode Extensions**: Pre-installed development tools
- **Port Forwarding**: Automatic setup for monitoring dashboard (3000) and alternative services (8080)

## Quick Start

### Option 1: Open in GitHub Codespace (Recommended)

1. Navigate to the repository on GitHub
2. Click the **Code** button
3. Select **Codespaces** tab
4. Click **Create codespace on [branch]**

The environment will automatically:
- Install all dependencies
- Configure the development environment
- Set up Claude-Flow

### Option 2: Open in VSCode with Dev Containers

1. Install the **Dev Containers** extension in VSCode
2. Open the repository folder
3. Press `F1` and select **Dev Containers: Reopen in Container**

## Security Benefits

✅ **Isolated Environment**: Runs in a sandboxed container
✅ **No Local Installation**: No packages installed on your machine
✅ **Disposable**: Can be deleted and recreated anytime
✅ **Controlled Access**: Limited file system access
✅ **Reproducible**: Consistent environment for all team members

## Post-Creation Steps

After the DevContainer starts:

1. Run the setup script:
   ```bash
   ./scripts/aicraftworks/setup-central-repo.sh
   ```

2. Configure your API keys (optional):
   ```bash
   # Set in CodeSpace secrets or environment variables
   export ANTHROPIC_API_KEY="your-key-here"
   ```

3. Test the installation:
   ```bash
   npx claude-flow@alpha --version
   ```

## Managing Secrets

For security, store API keys in GitHub Codespace secrets:

1. Go to your repository **Settings**
2. Navigate to **Secrets and variables** > **Codespaces**
3. Add secrets like `ANTHROPIC_API_KEY`
4. These will be automatically available in your Codespace

## Mounted Volumes

The container mounts `~/.anthropic` from your local machine (when using local Dev Containers) to preserve API configurations. This mount is ignored in GitHub Codespaces.

## Ports

- **3000**: Claude-Flow monitoring dashboard
- **8080**: Alternative services port

Both ports are automatically forwarded and accessible from your browser.

## Troubleshooting

### DevContainer fails to build
- Ensure you have Docker installed (for local dev containers)
- Check your internet connection
- Try rebuilding: `F1` > **Dev Containers: Rebuild Container**

### Dependencies fail to install
- The container uses `--legacy-peer-deps` for npm install
- Check the console output for specific errors
- Manual install: `npm install --legacy-peer-deps`

## Customization

You can customize the DevContainer by editing `.devcontainer/devcontainer.json`:

- Add more VSCode extensions
- Change Node.js version
- Add additional features
- Modify port forwarding

## Learn More

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Containers Specification](https://containers.dev/)
- [VSCode Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
