# SageMaker JupyterLab Instance Restart Guide

When you restart your SageMaker JupyterLab instance, the environment resets partially. This guide helps you get back to your working state quickly.

## 💾 What Persists vs. What Resets

*   **✅ Persists:** Everything in `/home/sagemaker-user`. This includes:
    *   Your code and repositories.
    *   Configuration files (`.zshrc`, `.gitconfig`, etc.).
    *   Tools installed in user space (NVM, Node.js, Python virtual environments managed by `uv`, Gemini CLI).
*   **❌ Resets:** System directories (e.g., `/usr/bin`, `/etc`).
    *   System packages installed via `apt-get` (like `zsh` itself, `fonts-powerline`, `git-lfs`) may be wiped.
    *   System-wide configuration changes.

---

## 🚀 Post-Restart Checklist

### 1. Check Your Shell
Open a new terminal.
*   **Ideal:** You see your **Zsh** prompt with the Powerlevel10k theme.
*   **If you see a plain Bash prompt:**
    1.  Type `zsh` to switch manually.
    2.  If `zsh` is missing, you need to reinstall system packages (see step 2).

### 2. Reinstall System Dependencies (If Missing)
Since `apt` packages reset, you might need to run the system setup portion of your scripts again.

**Run the Zsh setup script again:**
```bash
./env_setup/setup_zsh.sh
```
*This is safe to re-run. It checks if things are already installed before proceeding.*

### 3. Verify Environment & Tools
Your user-installed tools should still work immediately if your shell is correct.

*   **Check NVM & Node:**
    ```bash
    node --version
    ```
*   **Check Gemini CLI:**
    ```bash
    gemini --help
    ```
*   **Troubleshooting:**
    If commands are not found, your shell configuration might not be loaded. Run:
    ```bash
    source ~/.zshrc
    ```

### 4. API Keys & Secrets
Environment variables set in a terminal session are lost on restart.

*   **Check if your key is set:**
    ```bash
    echo $GEMINI_API_KEY
    ```
*   **Permanent Fix:**
    If the key is missing, add it to your `.zshrc` so it loads automatically every time:
    ```bash
    echo 'export GEMINI_API_KEY="your_actual_key_here"' >> ~/.zshrc
    source ~/.zshrc
    ```

---

## ⚡ Quick Recovery Command
If things look broken, just run your setup scripts again. They are idempotent (safe to run multiple times):

```bash
chmod +x env_setup/*.sh
./env_setup/setup_zsh.sh
```
