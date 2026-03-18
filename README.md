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
# Change prefix to Ctrl + a (much easier than Ctrl + b and without a risk ofbreaking a finger 😂)
set -g prefix C-a

# Unbind old prefix
unbind C-b

# Allow sending prefix to nested tmux sessions
bind C-a send-prefix
```
Reload config from terminal:
```
tmux source-file ~/.tmux.conf
```

> All shortcuts below assume prefix is `C-a`

### Sessions

| Command | Action |
|---------|--------|
| `tmux new -s mysession -n mywindow` | New session named `mysession` with window `mywindow` |
| `tmux new -s mysession` | Start a new session |
| `tmux ls` | Show all sessions |
| `C-a d` | Detach from current session |
| `tmux attach -t mysession` | Attach to session by name |
| `tmux kill-session -t mysession` | Kill a specific session |
| `tmux kill-server` | Kill all sessions |

### Windows

| Key | Action |
|-----|--------|
| `C-a c` | Create a new window |
| `C-a ,` | Rename current window |
| `C-a &` | Close current window |
| `C-a w` | List all windows |
| `C-a p` | Previous window |
| `C-a n` | Next window |
| `C-a 0-9` | Switch to window by number |
