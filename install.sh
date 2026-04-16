#!/usr/bin/env bash
# Installer: symlinks tmux config/scripts from this repo into
# their expected locations, and installs TPM if missing. Safe to re-run.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src=$1 dst=$2
    mkdir -p "$(dirname "$dst")"
    if [[ -L $dst ]] && [[ $(readlink "$dst") == "$src" ]]; then
        echo "  ok    $dst -> $src"
        return
    fi
    if [[ -e $dst || -L $dst ]]; then
        mv "$dst" "$dst.bak.$(date +%s)"
        echo "  backup  $dst -> $dst.bak.*"
    fi
    ln -s "$src" "$dst"
    echo "  link    $dst -> $src"
}

echo "Linking tmux config..."
link "$REPO/tmux/tmux.conf"        "$HOME/.tmux.conf"
link "$REPO/tmux/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
link "$REPO/tmux/tmux-stats"       "$HOME/.local/bin/tmux-stats"

echo
echo "Checking TPM..."
if [[ -d $HOME/.tmux/plugins/tpm ]]; then
    echo "  ok    TPM already installed at ~/.tmux/plugins/tpm"
else
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "  done  TPM cloned"
fi

echo
echo "Checking zoxide (powers the sessionizer's directory picker)..."
if command -v zoxide >/dev/null 2>&1; then
    echo "  ok    zoxide installed"
else
    echo "  warn  zoxide not found — run: sudo apt install zoxide"
    echo "        (sessionizer will fall back to a recursive find of \$HOME)"
fi

echo
echo "Checking bash shell hook for zoxide..."
if [[ -f $HOME/.bashrc ]] && ! grep -q 'zoxide init' "$HOME/.bashrc"; then
    {
        echo ''
        echo '# zoxide: "smarter cd" — learns your frequent dirs; powers tmux-sessionizer'
        echo 'command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"'
    } >> "$HOME/.bashrc"
    echo "  done  added zoxide init to ~/.bashrc"
else
    echo "  ok    ~/.bashrc already initialises zoxide (or is missing)"
fi

echo
echo "Installing tmux plugins..."
if command -v tmux >/dev/null && [[ -x $HOME/.tmux/plugins/tpm/bin/install_plugins ]]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null
    echo "  ok    tmux plugins installed"
else
    echo "  skip  tmux or TPM not available"
fi

echo
echo "Done."
echo
echo "Next steps:"
echo "  1. Make sure ~/.local/bin is on your \$PATH"
echo "  2. Open nvim — LazyVim auto-installs missing plugins."
