#!/usr/bin/env node

/**
 * Vercel Configuration Checker
 * Checks for Vercel configuration files and provides account information
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const colors = {
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  blue: '\x1b[34m',
  reset: '\x1b[0m',
};

function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

function checkFile(filePath) {
  try {
    return fs.existsSync(filePath);
  } catch {
    return false;
  }
}

function readFile(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf8');
  } catch {
    return null;
  }
}

function getGitRemote() {
  try {
    return execSync('git config --get remote.origin.url', { encoding: 'utf8' }).trim();
  } catch {
    return null;
  }
}

function getRepoName(url) {
  if (!url) return null;
  const match = url.match(/github\.com[:/](.+?)(?:\.git)?$/);
  return match ? match[1] : null;
}

console.log('\n🔍 Vercel Configuration Checker');
console.log('==============================\n');

// Check if in git repository
if (!checkFile('.git')) {
  log('⚠️  Warning: Not in a git repository', 'yellow');
  log('Please run this script from the root of your repository\n', 'yellow');
  process.exit(1);
}

// Get repository info
const repoUrl = getGitRemote();
const repoName = getRepoName(repoUrl);
log(`📦 Repository: ${repoUrl || 'Unknown'}\n`, 'green');

// Check for vercel.json
log('Checking for Vercel configuration files...\n', 'green');

if (checkFile('vercel.json')) {
  log('✅ Found vercel.json', 'green');
  const vercelConfig = readFile('vercel.json');
  if (vercelConfig) {
    try {
      const config = JSON.parse(vercelConfig);
      console.log('Configuration:', JSON.stringify(config, null, 2));
    } catch {
      console.log('Contents:', vercelConfig.substring(0, 500));
    }
  }
  console.log('');
} else {
  log('⚠️  vercel.json not found', 'yellow');
}

// Check for .vercel directory
if (checkFile('.vercel')) {
  log('✅ Found .vercel directory', 'green');
  console.log('');

  // Check for project.json
  if (checkFile('.vercel/project.json')) {
    log('📄 Project Configuration:', 'green');
    const projectConfig = readFile('.vercel/project.json');
    if (projectConfig) {
      try {
        const config = JSON.parse(projectConfig);
        console.log(JSON.stringify(config, null, 2));
        if (config.orgId) {
          log(`\nOrganization ID: ${config.orgId}`, 'blue');
        }
        if (config.projectId) {
          log(`Project ID: ${config.projectId}`, 'blue');
        }
      } catch {
        console.log(projectConfig);
      }
    }
    console.log('');
  }

  // List files in .vercel
  try {
    const files = fs.readdirSync('.vercel');
    log('Files in .vercel directory:', 'green');
    files.forEach(file => {
      console.log(`  - ${file}`);
    });
    console.log('');
  } catch (err) {
    log('Could not read .vercel directory', 'yellow');
  }
} else {
  log('⚠️  .vercel directory not found', 'yellow');
  log('This directory is created when you link a project with Vercel CLI\n', 'yellow');
}

// Check package.json
if (checkFile('package.json')) {
  log('📦 Checking package.json for Vercel scripts...', 'green');
  const packageJson = readFile('package.json');
  if (packageJson && packageJson.includes('vercel')) {
    log('✅ Found Vercel references in package.json', 'green');
    try {
      const pkg = JSON.parse(packageJson);
      if (pkg.scripts) {
        Object.entries(pkg.scripts).forEach(([key, value]) => {
          if (value.includes('vercel')) {
            console.log(`  ${key}: ${value}`);
          }
        });
      }
    } catch {
      // Ignore parse errors
    }
  } else {
    log('⚠️  No Vercel scripts found in package.json', 'yellow');
  }
  console.log('');
}

// Check for environment files
log('🔐 Checking for Vercel environment variables...', 'green');
const envFiles = ['.env.local', '.env.production', '.env'];
const foundEnvFiles = envFiles.filter(checkFile);
if (foundEnvFiles.length > 0) {
  log(`Found environment files: ${foundEnvFiles.join(', ')}`, 'green');
  log('(Check manually for VERCEL_* variables)', 'yellow');
} else {
  log('⚠️  No .env files found', 'yellow');
}
console.log('');

// GitHub integration info
if (repoName) {
  log('🔗 GitHub Integration Check:', 'green');
  console.log('To check Vercel integration in GitHub:');
  console.log(`1. Go to: https://github.com/${repoName}/settings/installations`);
  console.log('2. Look for Vercel in the installed GitHub Apps');
  console.log('');
}

// Vercel CLI check
log('🛠️  Vercel CLI Check:', 'green');
try {
  const version = execSync('vercel --version', { encoding: 'utf8' }).trim();
  log(`✅ Vercel CLI is installed (${version})`, 'green');
  console.log('\nTo check linked project, run:');
  console.log('  vercel inspect');
  console.log('  vercel whoami');
  console.log('');
} catch {
  log('⚠️  Vercel CLI not installed', 'yellow');
  console.log('Install with: npm i -g vercel\n');
}

// Summary
log('📊 Summary:', 'green');
console.log('==============================');
if (checkFile('vercel.json') || checkFile('.vercel')) {
  log('✅ Vercel configuration detected', 'green');
  console.log('\nTo find the connected Vercel account:');
  console.log('1. Log in to https://vercel.com');
  console.log(`2. Search for project: ${path.basename(process.cwd())}`);
  console.log('3. Check Settings → Git to see connected repository');
} else {
  log('⚠️  No Vercel configuration found', 'yellow');
  console.log('\nThis repository may not be connected to Vercel yet, or');
  console.log('the configuration files are not present in this directory.');
}

console.log('\n✨ Done!\n');

