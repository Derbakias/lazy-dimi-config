# Neovim Setup

Built on [LazyVim](https://lazyvim.github.io).

---

## Tmux

### Workflow Tips
- Use tmux sessions per project — one session = one project context
- Use windows like tabs (one per task: editor, terminal, logs)
- Split panes inside a window for editor + terminal side by side
- Detach and reattach freely — everything stays running in the background

### Change the Prefix Key
Edit `~/.tmux.conf` and add:
```
# Change prefix to Ctrl + Space (much easier than Ctrl + b and without a risk of breaking a finger 😂)
set -g prefix C-Space

# Unbind old prefix
unbind C-b

# Allow sending prefix to nested tmux sessions
bind C-Space send-prefix

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

```
Reload config from terminal:
```
tmux source-file ~/.tmux.conf
```

> All shortcuts below assume prefix is `C-Space`

### Sessions

| Command | Action |
|---------|--------|
| `tmux new -s mysession -n mywindow` | New session named `mysession` with window `mywindow` |
| `tmux new -s mysession` | Start a new session |
| `tmux ls` | Show all sessions |
| `C-Space d` | Detach from current session |
| `tmux attach -t mysession` | Attach to session by name |
| `tmux kill-session -t mysession` | Kill a specific session |
| `tmux kill-server` | Kill all sessions |

### Windows

| Key | Action |
|-----|--------|
| `C-Space c` | Create a new window |
| `C-Space ,` | Rename current window |
| `C-Space &` | Close current window |
| `C-Space w` | List all windows |
| `C-Space p` | Previous window |
| `C-Space n` | Next window |
| `C-Space 0-9` | Switch to window by number |
