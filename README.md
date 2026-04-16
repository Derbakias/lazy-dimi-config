# Neovim Setup (check SHORTCUTS.md)

Built on [LazyVim](https://lazyvim.github.io).

---

## Tmux

### Workflow Tips

- Use tmux sessions per project — one session = one project context
- Use windows like tabs (one per task: editor, terminal, logs)
- Split panes inside a window for editor + terminal side by side
- Detach and reattach freely — everything stays running in the background

### Setup on a New Machine

Everything tmux-related lives inside this repo under `tmux/`, and a single
installer symlinks it into place. To reproduce the setup:

```bash
sudo apt install tmux fzf git zoxide
git clone <this-repo> ~/.config/nvim
~/.config/nvim/install.sh
nvim                          # first open auto-installs nvim plugins
```

That's it.

> **zoxide** powers the project picker (`prefix + f`). Every time you `cd` into a directory in your shell, zoxide records it and ranks it by frequency. The picker then shows your most-used directories — no hardcoded path, and the list naturally adapts per-machine to wherever you actually work.

**What `install.sh` does:**

- Symlinks `~/.tmux.conf` → `~/.config/nvim/tmux/tmux.conf`
- Symlinks `~/.local/bin/tmux-sessionizer` → `~/.config/nvim/tmux/tmux-sessionizer`
- Symlinks `~/.local/bin/tmux-stats` → `~/.config/nvim/tmux/tmux-stats`
- Clones TPM (Tmux Plugin Manager) to `~/.tmux/plugins/tpm` if missing
- Installs tmux plugins (resurrect, continuum) via TPM headlessly
- Appends `eval "$(zoxide init bash)"` to `~/.bashrc` if not already present

It's safe to re-run. If a real file already exists at a target
path, it's backed up as `<path>.bak.<timestamp>` before the symlink replaces
it.

Because the config is symlinked, any local edit to `~/.tmux.conf` is a
repo edit — no separate sync step.

### Configuration and Scripts

All three files live in the repo under [`tmux/`](tmux/):

| File                                              | Symlinked to                     | Purpose                                  |
| ------------------------------------------------- | -------------------------------- | ---------------------------------------- |
| [`tmux/tmux.conf`](tmux/tmux.conf)                | `~/.tmux.conf`                   | Main tmux config                         |
| [`tmux/tmux-sessionizer`](tmux/tmux-sessionizer)  | `~/.local/bin/tmux-sessionizer`  | Fuzzy project picker (bound to prefix+f) |
| [`tmux/tmux-stats`](tmux/tmux-stats)              | `~/.local/bin/tmux-stats`        | CPU/RAM/SWAP/LOAD for the status bar     |

Edit the files in [`tmux/`](tmux/) directly (or via the symlink — same thing). Reload tmux after config changes:

```bash
tmux source-file ~/.tmux.conf
```

> All shortcuts below assume prefix is `C-Space`

### Sessions

| Command                             | Action                                               |
| ----------------------------------- | ---------------------------------------------------- |
| `tmux new -s mysession -n mywindow` | New session named `mysession` with window `mywindow` |
| `tmux new -s mysession`             | Start a new session                                  |
| `tmux ls`                           | Show all sessions                                    |
| `tmux attach -t mysession`          | Attach to session by name                            |
| `tmux a`                            | Attach to last session                               |
| `tmux kill-session -t mysession`    | Kill a specific session                              |
| `tmux kill-server`                  | Kill all sessions                                    |
| `C-Space d`                         | Detach from current session                          |
| `C-Space f`                         | **Project picker** (sessionizer). Inside the picker: `Enter` = open as a new session (or attach if it exists). `Ctrl-O` = stay in the current pane and `cd` into the project. |
| `C-Space w`                         | Tree view of all sessions / windows / panes          |
| `C-Space $`                         | Rename current session                               |
| `C-Space (`                         | Previous session                                     |
| `C-Space )`                         | Next session                                         |

### Windows

| Key           | Action                     |
| ------------- | -------------------------- |
| `C-Space c`   | Create a new window        |
| `C-Space ,`   | Rename current window      |
| `C-Space &`   | Close current window (and all its panes) |
| `C-Space p`   | Previous window            |
| `C-Space n`   | Next window                |
| `C-Space 0-9` | Switch to window by number |

### Panes

| Key                       | Action                                                       |
| ------------------------- | ------------------------------------------------------------ |
| `C-Space s`               | Split horizontal (new pane below)                            |
| `C-Space v`               | Split vertical (new pane right)                              |
| `C-h / C-j / C-k / C-l`   | Move between panes — **works across nvim splits + tmux panes** |
| `C-Space x`               | Close current pane (or just type `exit` in a shell pane)     |
| `C-Space z`               | Zoom / unzoom current pane (fullscreen toggle)               |
| `C-Space Space`           | Cycle preset pane layouts (tiled, even-horizontal, etc.)     |
| `C-Space {` / `C-Space }` | Swap current pane with previous / next                       |
| `C-Space C-↑/↓/←/→`       | Resize current pane by 1 (repeatable — keep tapping arrow)   |
| `C-Space M-↑/↓/←/→`       | Resize current pane by 5                                     |
| `C-Space q`               | Show pane numbers (tap number to jump)                       |
| `C-Space !`               | Break current pane into its own window                       |

> Inside nvim, the standard `<C-w>` splits still work unchanged. `C-h/j/k/l` is unified across nvim and tmux via `vim-tmux-navigator`.

### Copy Mode (scroll / select / copy)

| Key           | Action                                    |
| ------------- | ----------------------------------------- |
| `C-Space [`   | Enter copy mode                           |
| `q` or `Esc`  | Leave copy mode                           |
| `h/j/k/l`, `w`, `b`, `/`, `?`, `gg`, `G` | Move around like vim |
| `v`           | Start selection                           |
| `V`           | Line selection                            |
| `y`           | Copy selection (pastes back into tmux)    |
| `C-Space ]`   | Paste last copied buffer                  |

### Persistence (tmux-resurrect + tmux-continuum)

Auto-save every 15min in the background. **Auto-restore is OFF** — tmux can't tell "crashed with work running" apart from "you intentionally closed it", so restore is a one-key conscious choice. Nvim buffers come back via `persistence.nvim` when you do restore.

| Key            | Action                                                                      |
| -------------- | --------------------------------------------------------------------------- |
| `C-Space C-s`  | Save snapshot now (rarely needed — auto-save runs every 15min)              |
| `C-Space C-r`  | **Restore last snapshot** — press this after a crash/reboot to resume work  |

Snapshots live in `~/.local/share/tmux/resurrect/`.

### TPM (Tmux Plugin Manager)

| Key            | Action                        |
| -------------- | ----------------------------- |
| `C-Space I`    | Install plugins (capital i)   |
| `C-Space U`    | Update plugins                |
| `C-Space M-u`  | Uninstall plugins not in list |
