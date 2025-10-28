# Security Guidelines for Claude-Flow at AICraftWorksOrg

## 🔒 Mandatory Security Policy

### Core Requirement

**ALL Claude-Flow operations MUST be performed within GitHub Codespaces or DevContainer environments.**

This is a non-negotiable security requirement for AICraftWorksOrg. No exceptions.

## Why This Matters

### Threat Model

Claude-Flow is a powerful orchestration platform that:
- Executes arbitrary code through AI agents
- Installs npm packages dynamically
- Accesses file systems
- Makes network requests
- Runs shell commands

**Potential Risks:**
- Malicious dependencies in the supply chain
- Compromised npm packages
- Vulnerable third-party code
- Unintended file system access
- Data exfiltration attempts

### Protection Through Isolation

By running Claude-Flow exclusively in Codespaces/DevContainers:

✅ **Host Protection**: Your local machine is never exposed
✅ **Disposable**: Compromised containers can be deleted instantly
✅ **Auditable**: All activities logged in GitHub
✅ **Recoverable**: Fresh environment in seconds
✅ **Consistent**: Same security posture for all users
✅ **Minimal Impact**: Breach affects only the container

## Security Features

### GitHub Codespace Security

1. **Isolation**: Each Codespace runs in a separate VM
2. **Secrets Management**: GitHub Codespace secrets never touch local machines
3. **Access Control**: Organization-level policies
4. **Audit Logs**: Full activity tracking
5. **Time-Limited**: Automatic shutdown and cleanup
6. **Ephemeral**: No persistent state by default

### DevContainer Security

1. **Containerized**: Docker isolation from host
2. **Read-Only Mounts**: Controlled file system access
3. **Network Isolation**: Configurable network policies
4. **User Permissions**: Non-root user execution
5. **Resource Limits**: CPU and memory constraints

## Required Practices

### For Developers

1. **Never Clone Locally**: Always use Codespace or Dev Container
2. **Use Secrets Manager**: Store API keys in GitHub secrets, not environment files
3. **Regular Cleanup**: Delete Codespaces when not in use
4. **Monitor Activity**: Review Codespace audit logs regularly
5. **Report Issues**: Immediately report suspicious behavior

### For Team Leads

1. **Enforce Policy**: Audit team compliance monthly
2. **Configure Restrictions**: Set organization Codespace policies
3. **Review Access**: Regularly review who has Codespace access
4. **Training**: Ensure all team members understand requirements
5. **Incident Response**: Have a plan for security incidents

### For Organization Admins

1. **Codespace Policies**: Configure org-wide Codespace settings
2. **Secret Scanning**: Enable GitHub secret scanning
3. **Dependency Review**: Enable Dependabot alerts
4. **Audit Logging**: Ensure audit logs are retained
5. **Access Control**: Implement least-privilege access

## Setup Instructions

### Initial Setup (One-Time)

1. **Enable Codespaces for the Organization**
   - Go to Organization Settings
   - Navigate to Codespaces
   - Enable Codespaces for repositories
   - Set spending limits and policies

2. **Configure Secrets**
   - Organization Settings > Secrets > Codespaces
   - Add `ANTHROPIC_API_KEY`
   - Add `GITHUB_TOKEN` (if needed)
   - Set visibility to appropriate repositories

3. **Set Policies**
   - Require 2FA for organization members
   - Set Codespace timeout (e.g., 4 hours)
   - Configure allowed instance types
   - Set maximum concurrent Codespaces per user

### Per-Repository Setup

1. **Add DevContainer Configuration**
   ```bash
   # Already included in claude-flow repository
   .devcontainer/devcontainer.json
   .devcontainer/README.md
   ```

2. **Add Security Documentation**
   ```bash
   # Link to this document in repository README
   docs/integrations/SECURITY.md
   ```

3. **Configure Branch Protection**
   - Require reviews before merging
   - Run security scans in CI/CD
   - Block force pushes

## Usage Examples

### Correct: Using Codespace ✅

```bash
# 1. Open Codespace from GitHub UI
# 2. In Codespace terminal:
./scripts/aicraftworks/setup-central-repo.sh
npx claude-flow@alpha swarm "implement feature"
```

### Incorrect: Local Execution ❌

```bash
# ❌ NEVER DO THIS
git clone https://github.com/Jenp-AICraftWorks/claude-flow
cd claude-flow
npm install  # Dangerous! Installs packages locally
./scripts/aicraftworks/setup-central-repo.sh  # Risky on host machine
```

## Incident Response

### If Local Installation Occurs

1. **Immediately Stop**: Kill all Claude-Flow processes
2. **Scan System**: Run antivirus and malware scans
3. **Review Logs**: Check system logs for suspicious activity
4. **Change Credentials**: Rotate all API keys and tokens
5. **Report**: Inform security team immediately
6. **Document**: Create incident report

### If Codespace Compromised

1. **Delete Codespace**: Immediately destroy the Codespace
2. **Rotate Secrets**: Change all secrets that were accessible
3. **Review Logs**: Check GitHub audit logs for unusual activity
4. **Investigate**: Determine how compromise occurred
5. **Report**: File incident report with security team
6. **Update**: Apply any necessary security patches

## Compliance Checklist

Use this checklist for monthly security reviews:

- [ ] All team members using Codespaces exclusively
- [ ] No local installations of Claude-Flow detected
- [ ] Organization Codespace policies up to date
- [ ] Secrets properly managed in GitHub
- [ ] Audit logs reviewed for anomalies
- [ ] Dependabot alerts addressed
- [ ] Security training completed by new members
- [ ] Incident response plan tested
- [ ] Documentation up to date
- [ ] Access controls reviewed

## Additional Resources

### GitHub Documentation
- [Codespaces Security](https://docs.github.com/en/codespaces/managing-your-codespaces/security-in-codespaces)
- [Managing Secrets](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces)
- [Organization Policies](https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-repository-access-for-your-organizations-codespaces)

### Security Best Practices
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [npm Security Best Practices](https://docs.npmjs.com/security-best-practices)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security/getting-started/securing-your-organization)

## Questions?

Contact the security team:
- Email: security@aicraftworks.org (replace with actual contact)
- Slack: #security channel
- Emergency: [Emergency contact information]

---

**Last Updated**: 2025-10-28  
**Version**: 1.0.0  
**Owner**: AICraftWorksOrg Security Team
