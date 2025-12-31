# Vercel Configuration Checker

This directory contains scripts to check for Vercel configuration and find which Vercel account is connected to a GitHub repository.

## Quick Start

### Option 1: Bash Script (Mac/Linux)

```bash
# Make the script executable
chmod +x check-vercel-config.sh

# Run the script (from the repository root)
./check-vercel-config.sh
```

### Option 2: Node.js Script

```bash
# Make the script executable
chmod +x check-vercel-config.js

# Run the script (from the repository root)
./check-vercel-config.js
```

Or with Node.js directly:

```bash
node check-vercel-config.js
```

## What the Scripts Check

1. **vercel.json** - Vercel deployment configuration
2. **.vercel/** directory - Contains project linking information
3. **package.json** - Vercel scripts and dependencies
4. **Environment files** - Vercel environment variables
5. **Vercel CLI** - Installation status

## Finding the Vercel Account

### Method 1: Using the Scripts

The scripts will show:
- Project ID (if `.vercel/project.json` exists)
- Organization ID (if available)
- Repository connection information

### Method 2: Vercel Dashboard

1. Go to [vercel.com](https://vercel.com) and log in
2. Search for the project name in your dashboard
3. Click on the project → **Settings** → **Git**
4. Check the connected repository

### Method 3: Vercel CLI

If you have Vercel CLI installed:

```bash
# Check who you're logged in as
vercel whoami

# Inspect the project (if linked)
vercel inspect

# Link to a project
vercel link
```

### Method 4: GitHub Repository Settings

1. Go to the repository on GitHub
2. Click **Settings** (requires admin access)
3. Go to **Integrations** → **Vercel**
4. This shows the connected Vercel account/team

## For the Repository: cyber-evangelists/cyberevangelists_web

To check this specific repository:

1. **Clone the repository** (if you have access):
   ```bash
   git clone https://github.com/cyber-evangelists/cyberevangelists_web.git
   cd cyberevangelists_web
   ```

2. **Run the checker script**:
   ```bash
   ./check-vercel-config.sh
   # or
   node check-vercel-config.js
   ```

3. **Check Vercel Dashboard**:
   - Log in to your Vercel account(s)
   - Search for `cyberevangelists_web`
   - Check project settings

## Troubleshooting

### Script Not Working?

- Make sure you're in the repository root directory
- Ensure you have read permissions for the files
- Check if `.git` directory exists (indicates a git repository)

### Can't Find Vercel Account?

- The repository might not be connected to Vercel yet
- It might be connected to a different Vercel account/team
- You might need admin access to the repository or Vercel account
- Contact the repository owner or organization admins

### No Access to Repository?

If the repository is private and you don't have access:
1. Request access from the repository owner
2. Check if you're part of the organization
3. Contact the team lead or admin

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Vercel CLI Documentation](https://vercel.com/docs/cli)
- [GitHub Integration Guide](https://vercel.com/docs/concepts/git)

