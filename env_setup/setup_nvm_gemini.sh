#!/bin/bash

# NVM and Gemini CLI Setup Script for SageMaker
# This script installs Node Version Manager and Google Gemini CLI

set -e

echo "🚀 Starting NVM and Gemini CLI setup..."

# Step 1: Install NVM (Node Version Manager)
echo "📦 Installing NVM (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    echo "   ✅ NVM installed"
else
    echo "   NVM already installed, skipping..."
fi

# Step 2: Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Step 3: Install Node LTS via NVM
echo "📦 Installing Node.js LTS via NVM..."
nvm install --lts
nvm alias default node
echo "   ✅ Node.js LTS installed"

# Step 4: Install Gemini CLI
echo "🤖 Installing Gemini CLI..."

# Install official Gemini CLI via npm
npm install -g @google/gemini-cli 2>/dev/null || echo "   Note: Could not install @google/gemini-cli via npm"

# Step 5: Verify installations
echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Installed Versions:"
echo "   NVM version: $(nvm --version)"
echo "   Node version: $(node --version)"
echo "   NPM version: $(npm --version)"
echo ""
echo "🔧 Make sure to add to .zshrc:"
echo "   export NVM_DIR=\"\$HOME/.nvm\""
echo "   [ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\""
echo ""
echo "📚 For Gemini CLI usage:"
echo "   Run 'gemini --help' to get started."
echo "   You may need to set a GEMINI_API_KEY environment variable or login depending on the tool's requirements."
