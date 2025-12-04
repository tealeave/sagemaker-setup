#!/bin/bash

# Zsh Setup Script for SageMaker
# This script installs and configures zsh with Powerlevel10k and essential plugins

set -e

echo "🚀 Starting zsh setup..."

# Step 1: Install zsh and dependencies
echo "📦 Installing zsh and dependencies..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y zsh git curl wget fonts-powerline > /dev/null 2>&1

# Step 2: Install Oh My Zsh
echo "🎨 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "   Oh My Zsh already installed, skipping..."
fi

# Step 3: Install Powerlevel10k theme
echo "🎯 Installing Powerlevel10k theme..."
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "   Powerlevel10k already installed, skipping..."
fi

# Step 4: Install zsh-autosuggestions plugin
echo "💡 Installing zsh-autosuggestions..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "   zsh-autosuggestions already installed, skipping..."
fi

# Step 5: Install zsh-syntax-highlighting plugin
echo "🌈 Installing zsh-syntax-highlighting..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "   zsh-syntax-highlighting already installed, skipping..."
fi

# Step 6: Configure .zshrc
echo "⚙️  Configuring .zshrc..."
if [ ! -f "$HOME/.zshrc.backup" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Update theme
sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Update plugins
sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Step 7: Set zsh as default shell
echo "🔧 Setting zsh as default shell..."
sudo chsh -s $(which zsh) $USER > /dev/null 2>&1

echo ""
echo "✅ Zsh setup complete!"
echo ""
echo "📝 Configuration:"
echo "   • Theme: Powerlevel10k"
echo "   • Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting"
echo "   • Default Shell: zsh"
echo ""
echo "🚀 To start using zsh, run: zsh"
echo "📚 For Powerlevel10k configuration, follow the wizard on first zsh launch"
