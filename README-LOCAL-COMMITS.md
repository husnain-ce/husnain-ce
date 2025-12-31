# Local Daily Commit Script

This repository now uses a **local script** instead of GitHub Actions for daily commits. This gives you more control and ensures commits are properly attributed to your account.

## Quick Start

### Manual Execution

Run the script manually whenever you want to make contributions:

```bash
./local-daily-commit.sh
```

This will:
- Make 10 separate commits
- Push them to your GitHub repository
- Ensure commits are attributed to your account

### Automatic Execution (Cron Job)

To run the script automatically every day:

1. **Set up the cron job:**
   ```bash
   ./setup-cron.sh
   ```

2. **Or manually add to crontab:**
   ```bash
   crontab -e
   ```
   
   Add this line (adjust the path):
   ```cron
   0 0 * * * /Users/muhammadhusnain/Documents/Husnain-Github-Readme-File/local-daily-commit.sh >> /Users/muhammadhusnain/Documents/Husnain-Github-Readme-File/local-daily-commit.sh.log 2>&1
   ```

   This runs daily at midnight UTC.

## Configuration

### Git Configuration

The script uses your local git configuration. Make sure it's set correctly:

```bash
git config user.name "husnain-ce"
git config user.email "bitsol44@gmail.com"
```

### Authentication

The script uses your local git credentials. You can authenticate using:

1. **SSH (Recommended):**
   ```bash
   git remote set-url origin git@github.com:husnain-ce/husnain-ce.git
   ```

2. **Personal Access Token:**
   ```bash
   git remote set-url origin https://x-access-token:YOUR_TOKEN@github.com/husnain-ce/husnain-ce.git
   ```

## Features

- ✅ Makes 10 separate commits per run
- ✅ Uses discrete commit messages
- ✅ Automatically syncs with remote before pushing
- ✅ Handles merge conflicts gracefully
- ✅ Shows commit history for verification
- ✅ Colored output for better readability

## Troubleshooting

### Script fails with authentication error

Make sure your git credentials are configured:
- For SSH: Ensure your SSH key is added to GitHub
- For HTTPS: Use a Personal Access Token

### Cron job not running

1. Check if cron is running:
   ```bash
   ps aux | grep cron
   ```

2. Check cron logs:
   ```bash
   tail -f local-daily-commit.sh.log
   ```

3. Verify cron job exists:
   ```bash
   crontab -l
   ```

### Commits not showing on GitHub

- Ensure your git email matches your GitHub account email
- Check that commits are being pushed successfully
- Verify the commits appear in `git log`

## Removing the Cron Job

To remove the automatic cron job:

```bash
crontab -l | grep -v 'local-daily-commit.sh' | crontab -
```

## Differences from GitHub Actions

| Feature | GitHub Actions | Local Script |
|---------|---------------|--------------|
| Runs on | GitHub servers | Your local machine |
| Authentication | PAT token in secrets | Your local git credentials |
| Control | Limited | Full control |
| Privacy | Commits visible in Actions | Private execution |
| Reliability | Depends on GitHub | Depends on your machine |

## Notes

- The script creates commits in `.github/.private/` directory
- Commits use discrete messages: "docs: update activity log"
- Each run creates 10 separate commits for maximum contribution count
- The script automatically handles syncing with remote repository

