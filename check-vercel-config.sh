#!/bin/bash

# Vercel Configuration Checker Script
# This script checks for Vercel configuration files and account information

echo "🔍 Vercel Configuration Checker"
echo "=============================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: Not in a git repository${NC}"
    echo "Please run this script from the root of your repository"
    exit 1
fi

# Get repository info
REPO_URL=$(git config --get remote.origin.url 2>/dev/null)
echo -e "${GREEN}📦 Repository:${NC} $REPO_URL"
echo ""

# Check for vercel.json
echo -e "${GREEN}Checking for Vercel configuration files...${NC}"
echo ""

if [ -f "vercel.json" ]; then
    echo -e "${GREEN}✅ Found vercel.json${NC}"
    echo "Contents:"
    cat vercel.json | head -20
    echo ""
else
    echo -e "${YELLOW}⚠️  vercel.json not found${NC}"
fi

# Check for .vercel directory
if [ -d ".vercel" ]; then
    echo -e "${GREEN}✅ Found .vercel directory${NC}"
    echo ""

    # Check for project.json
    if [ -f ".vercel/project.json" ]; then
        echo -e "${GREEN}📄 Project Configuration:${NC}"
        cat .vercel/project.json
        echo ""
    fi

    # Check for .vercelignore
    if [ -f ".vercelignore" ]; then
        echo -e "${GREEN}📄 Found .vercelignore${NC}"
        echo ""
    fi

    # List all files in .vercel
    echo -e "${GREEN}Files in .vercel directory:${NC}"
    ls -la .vercel/
    echo ""
else
    echo -e "${YELLOW}⚠️  .vercel directory not found${NC}"
    echo "This directory is created when you link a project with Vercel CLI"
    echo ""
fi

# Check package.json for Vercel scripts
if [ -f "package.json" ]; then
    echo -e "${GREEN}📦 Checking package.json for Vercel scripts...${NC}"
    if grep -q "vercel" package.json; then
        echo -e "${GREEN}✅ Found Vercel references in package.json${NC}"
        grep -i "vercel" package.json | head -5
        echo ""
    else
        echo -e "${YELLOW}⚠️  No Vercel scripts found in package.json${NC}"
        echo ""
    fi
fi

# Check for environment variables
echo -e "${GREEN}🔐 Checking for Vercel environment variables...${NC}"
if [ -f ".env.local" ] || [ -f ".env" ]; then
    echo "Found environment files (check manually for VERCEL_* variables)"
else
    echo -e "${YELLOW}⚠️  No .env files found${NC}"
fi
echo ""

# Check GitHub repository settings (if accessible)
echo -e "${GREEN}🔗 GitHub Integration Check:${NC}"
echo "To check Vercel integration in GitHub:"
echo "1. Go to: https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/settings/installations"
echo "2. Look for Vercel in the installed GitHub Apps"
echo ""

# Vercel CLI check
echo -e "${GREEN}🛠️  Vercel CLI Check:${NC}"
if command -v vercel &> /dev/null; then
    echo -e "${GREEN}✅ Vercel CLI is installed${NC}"
    echo "Version: $(vercel --version 2>/dev/null || echo 'Unknown')"
    echo ""
    echo "To check linked project, run:"
    echo "  vercel inspect"
    echo "  vercel whoami"
    echo ""
else
    echo -e "${YELLOW}⚠️  Vercel CLI not installed${NC}"
    echo "Install with: npm i -g vercel"
    echo ""
fi

# Summary
echo -e "${GREEN}📊 Summary:${NC}"
echo "=============================="
if [ -f "vercel.json" ] || [ -d ".vercel" ]; then
    echo -e "${GREEN}✅ Vercel configuration detected${NC}"
    echo ""
    echo "To find the connected Vercel account:"
    echo "1. Log in to https://vercel.com"
    echo "2. Search for project: $(basename $(pwd))"
    echo "3. Check Settings → Git to see connected repository"
else
    echo -e "${YELLOW}⚠️  No Vercel configuration found${NC}"
    echo ""
    echo "This repository may not be connected to Vercel yet, or"
    echo "the configuration files are not present in this directory."
fi

echo ""
echo -e "${GREEN}✨ Done!${NC}"

