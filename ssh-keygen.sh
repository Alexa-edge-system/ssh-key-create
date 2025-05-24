#!/bin/bash

set -e

KEY_NAME="$HOME/.ssh/github_id_rsa"
KEY_TITLE="$(hostname)-$(date +%Y-%m-%d)"

read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your GitHub email: " GITHUB_EMAIL
read -s -p "Enter your GitHub personal access token (PAT): " GITHUB_TOKEN
echo

# 1. Generate SSH key
ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL" -f "$KEY_NAME" -N ""

# 2. Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add "$KEY_NAME"

# 3. Upload to GitHub
PUB_KEY_CONTENT=$(<"$KEY_NAME.pub")
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" \
  --data "{\"title\":\"$KEY_TITLE\",\"key\":\"$PUB_KEY_CONTENT\"}" \
  https://api.github.com/user/keys)

if [ "$HTTP_CODE" -ne 201 ]; then
  echo "❌ Failed to upload SSH key to GitHub. HTTP status: $HTTP_CODE"
  exit 1
fi

# 4. SSH config
echo "Host github.com
  HostName github.com
  User git
  IdentityFile $KEY_NAME
  IdentitiesOnly yes" >> ~/.ssh/config

# 5. Test SSH connection
echo "✅ SSH key added. Testing GitHub SSH access:"
ssh -T git@github.com

