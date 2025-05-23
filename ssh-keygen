#!/bin/bash

# Exit on error
set -e

# Variables
KEY_NAME="$HOME/.ssh/github_id_rsa"
GITHUB_USER="<your-github-username>"
GITHUB_EMAIL="<your-email@example.com>"
GITHUB_TOKEN="<your-personal-access-token>"
KEY_TITLE="$(hostname)-$(date +%Y-%m-%d)"

# Step 1: Generate SSH key
echo "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL" -f "$KEY_NAME" -N ""

# Step 2: Start ssh-agent and add key
echo "Adding SSH key to ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add "$KEY_NAME"

# Step 3: Add public key to GitHub via API
PUB_KEY_CONTENT=$(<"$KEY_NAME.pub")

echo "Adding SSH key to GitHub account..."
curl -s -o /dev/null -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" \
  --data "{\"title\":\"$KEY_TITLE\",\"key\":\"$PUB_KEY_CONTENT\"}" \
  https://api.github.com/user/keys

# Step 4: Configure SSH for GitHub
echo "Setting up SSH config for GitHub..."
{
  echo -e "Host github.com"
  echo -e "  HostName github.com"
  echo -e "  User git"
  echo -e "  IdentityFile $KEY_NAME"
  echo -e "  IdentitiesOnly yes"
} >> ~/.ssh/config

# Step 5: Test connection
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

echo "✅ SSH setup for GitHub completed."
