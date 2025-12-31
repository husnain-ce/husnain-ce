#!/bin/bash

# Setup Cron Job for Local Daily Commit Script
# This script helps you set up a cron job to run the daily commit script automatically

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/local-daily-commit.sh"
CRON_TIME="0 0 * * *"  # Daily at midnight UTC

echo "🕐 Setting up cron job for daily commits"
echo "========================================"
echo ""
echo "Script path: $SCRIPT_PATH"
echo "Schedule: $CRON_TIME (Daily at 00:00 UTC)"
echo ""

# Check if script exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "❌ Error: Script not found at $SCRIPT_PATH"
    exit 1
fi

# Make script executable
chmod +x "$SCRIPT_PATH"
echo "✅ Script is executable"
echo ""

# Check if cron job already exists
if crontab -l 2>/dev/null | grep -q "local-daily-commit.sh"; then
    echo "⚠️  Cron job already exists!"
    echo ""
    echo "Current cron jobs:"
    crontab -l | grep "local-daily-commit.sh"
    echo ""
    read -p "Do you want to remove the existing cron job and add a new one? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Remove existing cron job
        crontab -l 2>/dev/null | grep -v "local-daily-commit.sh" | crontab -
        echo "✅ Removed existing cron job"
    else
        echo "Keeping existing cron job. Exiting."
        exit 0
    fi
fi

# Add new cron job
(crontab -l 2>/dev/null; echo "$CRON_TIME $SCRIPT_PATH >> $SCRIPT_PATH.log 2>&1") | crontab -

echo "✅ Cron job added successfully!"
echo ""
echo "To view your cron jobs, run:"
echo "  crontab -l"
echo ""
echo "To edit your cron jobs, run:"
echo "  crontab -e"
echo ""
echo "To remove the cron job, run:"
echo "  crontab -l | grep -v 'local-daily-commit.sh' | crontab -"
echo ""
echo "Logs will be saved to: $SCRIPT_PATH.log"
echo ""

