#!/bin/bash

# Local Daily Commit Script
# This script makes 10 daily contributions to maintain GitHub activity streak
# Run this script manually or set it up with cron for automatic daily execution

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Local Daily Commit Script${NC}"
echo "=============================="
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    echo "Please run this script from the root of your repository"
    exit 1
fi

# Get repository info
REPO_URL=$(git config --get remote.origin.url 2>/dev/null)
echo -e "${GREEN}📦 Repository:${NC} $REPO_URL"
echo ""

# Verify git config
GIT_USER=$(git config user.name)
GIT_EMAIL=$(git config user.email)

if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
    echo -e "${YELLOW}⚠️  Git user not configured${NC}"
    echo "Setting git config..."
    git config user.name "husnain-ce"
    git config user.email "bitsol44@gmail.com"
    echo -e "${GREEN}✅ Git config set${NC}"
else
    echo -e "${GREEN}✅ Git user:${NC} $GIT_USER <$GIT_EMAIL>"
fi
echo ""

# Sync with remote
echo -e "${BLUE}🔄 Syncing with remote...${NC}"
git fetch origin main || echo "Fetch completed or failed"
git checkout main 2>/dev/null || echo "Already on main"
git pull origin main --no-edit --no-rebase || echo "Pull completed or no changes"
echo ""

# Create private directory for contributions
echo -e "${BLUE}📁 Creating private directory...${NC}"
mkdir -p .github/.private
echo ""

# Make 10 daily contributions
echo -e "${BLUE}📝 Making 10 daily contributions...${NC}"
DATE=$(date -u '+%Y-%m-%d')
TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M:%S UTC')
RANDOM_ID=$(openssl rand -hex 4)

echo -e "${GREEN}Committing as:${NC} $(git config user.name) <$(git config user.email)>"
echo ""

# Make 10 separate commits for daily contributions
for i in {1..10}; do
    echo -e "${BLUE}Making contribution $i/10...${NC}"
    
    # Use a more private location and less obvious file names
    FILE_NAME=".github/.private/activity-$(date -u +%s)-$i.txt"
    echo "$(date -u '+%s')" > "$FILE_NAME"
    echo "$TIMESTAMP" >> "$FILE_NAME"
    echo "$RANDOM_ID" >> "$FILE_NAME"
    
    git add "$FILE_NAME"
    if ! git diff --staged --quiet; then
        # More discrete commit messages
        git commit -m "docs: update activity log" --quiet
        echo -e "${GREEN}✅ Contribution $i/10 committed${NC}"
    else
        # If no changes, make an empty commit to ensure contribution count
        git commit -m "docs: update activity log" --allow-empty --quiet
        echo -e "${GREEN}✅ Contribution $i/10 committed (empty)${NC}"
    fi
    
    # Small delay to ensure unique timestamps
    sleep 2
done

echo ""
echo -e "${GREEN}✅ All 10 contributions created${NC}"
echo ""

# Show recent commits to verify author
echo -e "${BLUE}📋 Recent commits:${NC}"
git log --oneline -5 --pretty=format:"%h - %an (%ae) : %s"
echo ""

# Sync and push all contributions
echo -e "${BLUE}🔄 Syncing before push...${NC}"
git fetch origin main
# Try to rebase on top of latest main
if git rebase origin/main 2>/dev/null; then
    echo -e "${GREEN}✅ Rebase successful${NC}"
else
    # If rebase fails, abort and merge instead
    git rebase --abort 2>/dev/null || true
    git pull origin main --no-edit --no-rebase || true
    echo -e "${YELLOW}⚠️  Used merge strategy${NC}"
fi
echo ""

# Push all commits
echo -e "${BLUE}🚀 Pushing all contributions...${NC}"
if git push origin main; then
    echo -e "${GREEN}✅ Successfully pushed all contributions!${NC}"
else
    echo -e "${RED}❌ Push failed. Please check your git credentials and try again.${NC}"
    echo ""
    echo "If you need to set up authentication, you can:"
    echo "1. Use SSH: git remote set-url origin git@github.com:husnain-ce/husnain-ce.git"
    echo "2. Use Personal Access Token: git remote set-url origin https://x-access-token:YOUR_TOKEN@github.com/husnain-ce/husnain-ce.git"
    exit 1
fi

echo ""
echo -e "${GREEN}✨ Done! Your contributions have been pushed to GitHub.${NC}"
echo ""
echo -e "${BLUE}💡 Tip:${NC} To run this automatically, set up a cron job:"
echo "   crontab -e"
echo "   Add: 0 0 * * * /path/to/local-daily-commit.sh"
echo ""

