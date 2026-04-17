# LazyVim my shortcuts & tips

## Explorer

| Key     | Action                                     |
| ------- | ------------------------------------------ |
| `<C-n>` | Open explorer                              |
| `<C-e>` | Open/close explorer                        |
| `<Tab>` | Select/mark file                           |
| `m`     | Move selected file(s) to current directory |
| `y`     | Yank (copy) file                           |
| `p`     | Paste file                                 |
| `a`     | Create new file                            |
| `d`     | Delete file                                |
| `r`     | Rename file                                |
| `h`     | Close directory                            |
| `<BS>`  | Go up a directory                          |
| `E`     | Expand all directories                     |
| `Z`     | Collapse all directories                   |

### Explorer Symbols

| Symbol | Meaning              |
| ------ | -------------------- |
| ?      | New file (untracked) |
| ⠀⃝     | Changed file         |
| ●      | Staged file          |
| ⚠      | LSP warning in file  |

---

## File Search (Picker)

| Key          | Action                                                    |
| ------------ | --------------------------------------------------------- |
| `<leader>ff` | Find files (root dir)                                     |
| `<leader>fF` | Find files (cwd)                                          |
| `<leader>sg` | Grep (root dir)                                           |
| `<leader>sG` | Grep (cwd)                                                |
| `<leader>fG` | Grep with include/exclude filters (see below)             |
| `<leader>sb` | Search buffer lines (fuzzy finder with preview)           |
| `<C-h>`      | Toggle hidden files (dotfiles)                            |
| `<A-i>`      | Toggle ignored files (.gitignore)                         |
| `<A-c>`      | Toggle case-sensitive search (grep picker only)           |
| `<A-w>`      | Toggle whole word match (grep picker only)                |
| `<A-t>`      | Cycle focus between picker panes (input ↔ list ↔ preview) |
| `<Tab>`      | Select/mark file for multi-open                           |

### `<leader>fG` — Filtered Grep

Prompts for two inputs before opening the grep picker:

1. **Include** — narrow the search scope:
   - Directory names: `src`, `lib`
   - File globs: `*.ts`, `lib/*.py`
   - Dir wildcards: `my-*` (expands matching directories)
   - Leave empty to search everywhere
2. **Exclude** — skip paths (comma-separated): `dist`, `*.test.ts`
   - Leave empty for no exclusions

**Examples:**

- Include `src, *.ts` → only `.ts` files inside `src/`
- Include `api` / Exclude `*.spec.ts` → grep `api/` skipping spec files
- Include empty / Exclude `node_modules, dist` → full project minus build artifacts

---

## Buffers

| Key                | Action                                  |
| ------------------ | --------------------------------------- |
| `<Tab>`            | Next buffer                             |
| `<S-Tab>`          | Previous buffer                         |
| `<leader>bd`       | Close current buffer                    |
| `<C-^>`            | Jump to alternate (last visited) buffer |
| `:ls` / `:buffers` | List all open buffers                   |

### Buffer List Symbols

| Symbol | Meaning                                |
| ------ | -------------------------------------- |
| `%`    | Current buffer                         |
| `#`    | Alternate buffer (last visited)        |
| `a`    | Active/loaded buffer                   |
| `h`    | Hidden buffer (loaded but not visible) |

---

## Windows

| Key                      | Action                              |
| ------------------------ | ----------------------------------- |
| `<leader>z`              | Toggle zoom/maximize current window |
| `<C-w>v`                 | Vertical split                      |
| `<C-w>s`                 | Horizontal split                    |
| `<C-w>w`                 | Cycle to next window                |
| `<C-w>h/j/k/l`           | Move to left/down/up/right window   |
| `<C-Left>` / `<C-Right>` | Resize window width                 |
| `<C-Up>` / `<C-Down>`    | Resize window height                |
| `<leader>fw`             | Pick and focus a window from a list |

### Move window to a different position

| Key      | Action                                 |
| -------- | -------------------------------------- |
| `<C-w>H` | Move window to far left (full height)  |
| `<C-w>J` | Move window to far bottom (full width) |
| `<C-w>K` | Move window to far top (full width)    |
| `<C-w>L` | Move window to far right (full height) |

### Rotate / swap windows

| Key      | Action                                |
| -------- | ------------------------------------- |
| `<C-w>r` | Rotate windows clockwise              |
| `<C-w>R` | Rotate windows counter-clockwise      |
| `<C-w>x` | Swap current window with the next one |

---

## Scrolling

| Key     | Action                          |
| ------- | ------------------------------- |
| `<A-j>` | Scroll page down                |
| `<A-k>` | Scroll page up                  |
| `<C-d>` | Scroll down 5 lines (precision) |
| `<C-u>` | Scroll up 5 lines (precision)   |

> Cursor stays vertically centered at all times to emulate mouse scrolling (`scrolloff=999`)

---

## Context Menu

| Key            | Action                       |
| -------------- | ---------------------------- |
| `<C-t>`        | Open context menu (keyboard) |
| `<RightMouse>` | Open context menu (mouse)    |

---

## Editing

| Key                | Action                                     |
| ------------------ | ------------------------------------------ |
| `jk`               | Exit insert mode                           |
| `<A-J>`            | Move line(s) down (normal, insert, visual) |
| `<A-K>`            | Move line(s) up (normal, insert, visual)   |
| `;`                | Enter command mode (like `:`)              |
| `f{char}` then `f` | Find char forward, then repeat with `f`    |
| `F{char}` then `F` | Find char backward, then repeat with `F`   |
| `t{char}` then `t` | Jump before char forward, repeat with `t`  |
| `T{char}` then `T` | Jump before char backward, repeat with `T` |

**Same word multi-cursor (like VSCode `Ctrl+D`):**

| Key             | Action                                          |
| --------------- | ----------------------------------------------- |
| `<A-d>`         | Add cursor at next match                        |
| `<A-d><A-d>...` | Keep pressing to add more cursors on each match |
| `n` / `N`       | Get next / previous occurrence                  |
| `[` / `]`       | Select next / previous cursor                   |
| `q`             | Skip current and get next occurrence            |
| `Q`             | Remove current cursor / selection               |
| `<Esc>`         | Exit multi-cursor mode                          |

**Straight line multi-cursor (column):**

| Key                              | Action                                          |
| -------------------------------- | ----------------------------------------------- |
| `<A-d>` then `<C-Up>`/`<C-Down>` | Add cursors on lines above/below at same column |

**Visual/column cursors:**

| Key              | Action                                |
| ---------------- | ------------------------------------- |
| `\\c`            | Create a column of cursors            |
| `$` / `0`        | Move all cursors to end/start of line |
| `i` / `d` / etc. | Edit in insert mode or delete etc.    |

**Different locations multi-cursor:**

| Key                               | Action                                         |
| --------------------------------- | ---------------------------------------------- |
| `<A-d>` at position               | Place cursor at current location               |
| Move with arrows to next location | Navigate to where you want the next cursor     |
| `<A-d>` again                     | Add cursor at new location                     |
| Repeat until done, then edit      | All cursors active simultaneously              |
| `gcc`                             | Toggle comment on current line                 |
| `gc`                              | Toggle comment on selection (visual) or motion |
| `>>`                              | Indent line right                              |
| `<<`                              | Indent line left                               |
| `>` / `<`                         | Indent selection (stays in visual mode)        |

---

## Git

### Snacks (pickers / navigation)

| Key          | Action                                              |
| ------------ | --------------------------------------------------- |
| `<leader>gs` | Git status picker (changed files)                   |
| `<leader>gd` | Git diff picker (files + inline diffs)              |
| `<leader>gl` | Git log (all commits)                               |
| `<leader>gL` | Git log (cwd)                                       |
| `<leader>gf` | Current file history                                |
| `<leader>gb` | Blame for current line (who changed it + commit)    |
| `<leader>gB` | Open file on GitHub/GitLab in browser               |
| `<leader>gv` | Open Diffview (Open diff view of all changed files) |

> Inside diff/log pickers: `<C-f>` / `<C-b>` scroll the preview pane.

### Gitsigns (hunk-level operations)

A **hunk** is a contiguous block of changes within a file. Gitsigns lets you stage, reset, or preview individual hunks without touching the rest of the file.

| Key           | Action                                      |
| ------------- | ------------------------------------------- |
| `]h` / `[h`   | Jump to next / previous hunk                |
| `]H` / `[H`   | Jump to last / first hunk                   |
| `<leader>ghs` | Stage hunk under cursor                     |
| `<leader>ghS` | Stage entire file                           |
| `<leader>ghr` | Reset (discard) hunk under cursor           |
| `<leader>ghR` | Reset entire file                           |
| `<leader>ghu` | Undo last staged hunk                       |
| `<leader>ghp` | Preview hunk inline                         |
| `<leader>ghb` | Blame current line (full message)           |
| `<leader>ghB` | Blame entire buffer (per-line)              |
| `<leader>ghd` | Diff current file against index             |
| `<leader>ghD` | Diff current file against last commit (`~`) |

> To unstage a whole file: `git restore --staged <file>` in terminal.

### Diffview (Open diff view of all changed files)

| Key / Command                    | Action                             |
| -------------------------------- | ---------------------------------- |
| `<leader>gv`                     | Open Diffview (unstaged changes)   |
| `:DiffviewOpen HEAD~2`           | Compare against 2 commits ago      |
| `:DiffviewOpen main...HEAD`      | Compare branch vs HEAD             |
| `:DiffviewOpen d4a7b0d..519b30e` | Compare between two commits        |
| `:DiffviewFileHistory %`         | Commit history for current file    |
| `:DiffviewFileHistory`           | Commit history for whole repo      |
| `]h` / `[h`                      | Next / previous hunk               |
| `<Tab>` / `<S-Tab>`              | Next / previous file               |
| `gf`                             | Open current file in previous tab  |
| `<leader>e`                      | Toggle the file panel (open/close) |
| `q`                              | Close Diffview                     |

---

## LSP Hover Docs

| Key                   | Action                                      |
| --------------------- | ------------------------------------------- |
| `K`                   | Open LSP docs popup for symbol under cursor |
| `K` (again) or <C-ww> | Enter the popup window (to scroll)          |
| `<C-d>` / `<C-u>`     | Scroll down / up inside the popup           |
| `<C-w>q`              | Exit the popup                              |

---

## Rename (LSP)

| Key          | Action                                                  |
| ------------ | ------------------------------------------------------- |
| `<leader>cr` | Rename symbol (live preview of all changes as you type) |
| `<leader>cR` | Rename file                                             |

---

## Diagnostics (LSP)

Diagnostics appear on a dedicated line below the affected code.

| Key          | Action                        |
| ------------ | ----------------------------- |
| `<leader>cd` | Show full diagnostic in float             |
| `]d`         | Jump to next diagnostic                   |
| `[d`         | Jump to previous diagnostic               |
| `<leader>ca` | Code actions (quickfix, refactor, suggest) |
| `<leader>cA` | Source actions (organize imports, etc.)    |

### Inlay Hints

Inlay hints are read-only virtual text shown by the LSP — e.g. parameter names like `message:` inside `console.log(message: "")`. They are not part of the buffer and cannot be accepted or edited. They are purely informational.

| Key          | Action             |
| ------------ | ------------------ |
| `<leader>uh` | Toggle inlay hints |

### Autocomplete

The autocomplete popup appears in **insert mode** only (press `i` first).

| Key               | Action                         |
| ----------------- | ------------------------------ |
| `<C-n>` / `<C-p>` | Navigate suggestions down / up |
| `<C-y>`           | Accept selected suggestion     |
| `<C-space>`       | Manually trigger completion    |
| `<C-e>`           | Dismiss completion menu        |

---

## Terminal

| Key                 | Action                                              |
| ------------------- | --------------------------------------------------- |
| `<leader>ft`        | New floating terminal (fresh shell each press)      |
| `<C-/>`             | Toggle terminal `[count]` — hides/restores, process stays alive |
| `1<C-/>`, `2<C-/>`… | Toggle terminal 1, 2, … (each is an independent persistent shell) |
| `<C-x>`             | Exit terminal mode (back to normal mode)            |
| `<C-h/j/k/l>`       | Navigate windows directly from terminal mode        |
| `<C-w>` (in term)   | Cycle to next window                                |

> `<C-/>` uses Snacks' count-indexed terminals: `N<C-/>` gives you terminal N.
> Press the same count again to hide it; press again to bring it back with its history intact.
> `<leader>ft` always spawns a brand-new floating shell (no count, not persistent-by-index).

---

## Colorscheme

| Key          | Action                                                    |
| ------------ | --------------------------------------------------------- |
| `<leader>uC` | Pick colorscheme (selection is persisted across sessions) |

Available catppuccin flavours: `catppuccin-latte`, `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha`

---

## Spell Check (markdown files)

| Key  | Action                                    |
| ---- | ----------------------------------------- |
| `]s` | Jump to next misspelling                  |
| `[s` | Jump to previous misspelling              |
| `z=` | Suggest corrections for word under cursor |
| `zg` | Mark word as correct (add to dictionary)  |

---

## Search and Replace

**Current file (built-in):**

| Command          | Action                                   |
| ---------------- | ---------------------------------------- |
| `:%s/old/new/g`  | Replace all occurrences in file          |
| `:%s/old/new/gc` | Replace all with confirmation (y/n each) |

**Project-wide (grug-far):**

| Key                          | Action                                       |
| ---------------------------- | -------------------------------------------- |
| `<leader>sr`                 | Open search and replace panel                |
| Visual select + `<leader>sr` | Open with search pre-filled from selection   |
| `<Tab>`                      | Move to next field                           |
| `<S-Tab>`                    | Move to previous field                       |
| `\r`                         | Apply replacements (after reviewing matches) |
| `<Esc>` / `q`                | Close the panel                              |

### Panel fields

| Field            | Purpose                                             | Example          |
| ---------------- | --------------------------------------------------- | ---------------- |
| **Search**       | Text or regex to find                               | `subscribe`      |
| **Replace**      | Replacement text (leave empty to just search)       | `unsubscribe`    |
| **Files Filter** | Glob pattern for file matching (supports `**`)      | `**/hero/*.tsx`  |
| **Paths**        | Literal directory path from project root (no globs) | `src/components` |
| **Flags**        | Ripgrep flags (see below)                           | `-i -w`          |

### Ripgrep flags

| Flag          | Action                                      |
| ------------- | ------------------------------------------- |
| `-i`          | Case-insensitive search                     |
| `-w`          | Match whole words only                      |
| `-U`          | Multiline matching (pattern can span lines) |
| `--hidden`    | Include hidden files (dotfiles)             |
| `--no-ignore` | Include gitignored files                    |

### Examples

| Search                 | Files Filter | Paths            | Flags | What it does                     |
| ---------------------- | ------------ | ---------------- | ----- | -------------------------------- |
| `subscribe`            | `*.tsx`      |                  |       | Find in all tsx files            |
| `subscribe`            | `**/hero/**` |                  |       | Find in any `hero/` directory    |
| `subscribe`            |              | `src/components` |       | Find in a specific directory     |
| `const.*\n.*subscribe` |              |                  | `-U`  | Multiline match across two lines |

---

## Code Folding

| Key  | Action                                     |
| ---- | ------------------------------------------ |
| `za` | Toggle fold under cursor                   |
| `zo` | Open fold under cursor                     |
| `zc` | Close fold under cursor                    |
| `zO` | Open all folds under cursor (recursively)  |
| `zC` | Close all folds under cursor (recursively) |
| `zR` | Open all folds in the file                 |
| `zM` | Close all folds in the file                |
| `zj` | Jump to next fold                          |
| `zk` | Jump to previous fold                      |

---

## Debugging (DAP)

### Core commands

| Key                         | VSCode equivalent | Action                          |
| --------------------------- | ----------------- | ------------------------------- |
| `<leader>db`                | F9                | Toggle breakpoint               |
| `<leader>dB`                | —                 | Breakpoint with condition       |
| `<leader>dc`                | F5                | Run / Continue                  |
| `<leader>da`                | —                 | Run with args                   |
| `<leader>dC`                | —                 | Run to cursor                   |
| `<leader>di`                | F11               | Step into                       |
| `<leader>do`                | Shift+F11         | Step out                        |
| `<leader>dO`                | F10               | Step over                       |
| `<leader>dP`                | —                 | Pause                           |
| `<leader>dt`                | Shift+F5          | Terminate                       |
| `<leader>dl`                | —                 | Run last                        |
| `<leader>dr`                | —                 | Toggle REPL                     |
| `<leader>du`                | —                 | Toggle DAP UI (sidebar)         |
| `<leader>de`                | —                 | Eval expression (normal/visual) |
| `<leader>dj` / `<leader>dk` | —                 | Navigate stack down / up        |
| `<leader>d?`                | —                 | Show F-key cheat-sheet          |

### VSCode-style F-keys

| Key             | Action            |
| --------------- | ----------------- |
| `F5`            | Continue / Start  |
| `F9`            | Toggle breakpoint |
| `F10`           | Step over         |
| `F11`           | Step into         |
| `Shift+F11`     | Step out          |
| `Shift+F5`      | Terminate         |
| `Ctrl+Shift+F5` | Restart           |

> **Note**: Shift+F-keys depend on your terminal sending them. Test with
> `<C-v>` then the key — if nothing prints, configure your terminal

### JS / TS setup

Wired up in `lua/plugins/dap-js.lua`. Requires `js-debug-adapter` installed
via `:Mason`. Opens the `pwa-node` adapter directly — no `nvim-dap-vscode-js`
plugin (unmaintained, broken on current nvim-dap).

Two default configurations are registered for `.js` / `.ts` files:

- **Launch current file** — runs `${file}` with node
- **Attach to process** — pick a running node process to attach to

If your project has a `.vscode/launch.json`, load it with:

```
:lua require("dap.ext.vscode").load_launchjs()
```

### Inspecting values (while stopped at a breakpoint)

- **Hover**: `<leader>de` to evaluate the word/selection under cursor
- **Scopes panel** (dap-ui, left): expand locals/closures with `<CR>`
- **REPL**: type any expression in the current frame's scope
- **Stacks panel**: `<CR>` on a frame to jump to it

### Watches (like VSCode's Watch panel)

From inside the **Watches** window in dap-ui:

| Key    | Action           |
| ------ | ---------------- |
| `a`    | Add expression   |
| `e`    | Edit expression  |
| `d`    | Delete watch     |
| `<CR>` | Expand / collapse |

Programmatic API (bind your own key if desired):

```lua
require("dapui").elements.watches.add("myVar")
require("dapui").elements.watches.add(vim.fn.expand("<cword>"))  -- word under cursor
```

---

## Testing (Neotest)

| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>tr` | Run nearest test           |
| `<leader>tt` | Run all tests in file      |
| `<leader>tT` | Run all tests in project   |
| `<leader>tl` | Run last test              |
| `<leader>td` | Debug nearest test         |
| `<leader>ts` | Toggle test summary        |
| `<leader>to` | Show test output           |
| `<leader>tO` | Toggle output panel        |
| `<leader>tS` | Stop running test          |
| `<leader>tw` | Toggle watch mode for file |
| `<leader>ta` | Attach to running test     |

---

## Code Outline (Aerial)

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `<leader>cs` | Toggle on/off code outline sidebar |
| `<leader>ss` | Search symbols (via picker)        |

---

## TODO Comments

Highlights `TODO`, `FIXME`, `BUG`, `HACK`, `NOTE` etc. in code.

| Key          | Action                               |
| ------------ | ------------------------------------ |
| `]t` / `[t`  | Jump to next / previous TODO comment |
| `<leader>st` | Search all TODOs (picker)            |
| `<leader>sT` | Search TODO/FIX/FIXME only           |
| `<leader>xt` | Show TODOs in Trouble panel          |

---

## Session Management

Sessions automatically save open buffers and layout per project.

| Key          | Action                                |
| ------------ | ------------------------------------- |
| `<leader>qs` | Restore session for current directory |
| `<leader>qS` | Select a session to restore           |
| `<leader>ql` | Restore last session                  |
| `<leader>qd` | Stop saving current session           |

---

## Vim Built-ins Worth Knowing

| Key                  | Action                                               |
| -------------------- | ---------------------------------------------------- |
| `:Tutor`             | Built-in interactive Neovim tutorial                 |
| `:enew`              | Open a new empty buffer                              |
| `<leader>fn`         | New file                                             |
| `zz`                 | Center cursor (same as `scrolloff=999` already does) |
| `<C-f>` / `<C-b>`    | Page down / page up                                  |
| `:verbose map <key>` | Show what a key is mapped to and where it was set    |

## Word Under Cursor Search

| Key | Description                           |
| --- | ------------------------------------- |
| `*` | Search forward for word under cursor  |
| `#` | Search backward for word under cursor |
| `n` | Jump to next match                    |
| `N` | Jump to previous match                |

## Search in File (`/`)

Press `/` to open the search bar, then type your pattern and press `Enter`.

| Pattern / Key     | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| `derbakias`       | Find all occurrences (case-insensitive if `smartcase` is on) |
| `\<derbakias\>`   | Whole word only (won't match "derbakiasXYZ")                 |
| `\Cderbakias`     | Case-sensitive match                                         |
| `\C\<derbakias\>` | Case-sensitive + whole word                                  |
| `\cderbakias`     | Force case-insensitive                                       |
| `n` / `N`         | Jump to next / previous match                                |
| `<A-c>`           | Toggle `\C` (case-sensitive) on/off while typing             |
| `<A-w>`           | Toggle `\<...\>` (whole word) on/off while typing            |

> Note: `/` opens the search bar — do **not** type `/` again as part of the pattern.

## All the shortcuts from the docs

# ⌨️ Keymaps | LazyVim

**LazyVim** uses [which-key.nvim](https://github.com/folke/which-key.nvim) to help you remember your keymaps. Just press any key like `<space>` and you'll see a popup with all possible keymaps starting with `<space>`.

![image](https://user-images.githubusercontent.com/292349/211862473-1ff5ee7a-3bb9-4782-a9f6-014f0e5d4474.png)

- default `<leader>` is `<space>`
- default `<localleader>` is `\`

## General[​](#general "Direct link to General")

| Key                | Description                           | Mode               |
| ------------------ | ------------------------------------- | ------------------ |
| j                  | Down                                  | n, x               |
| <Down>             | Down                                  | n, x               |
| k                  | Up                                    | n, x               |
| <Up>               | Up                                    | n, x               |
| <C-h>              | Go to Left Window                     | n                  |
| <C-j>              | Go to Lower Window                    | n                  |
| <C-k>              | Go to Upper Window                    | n                  |
| <C-l>              | Go to Right Window                    | n                  |
| <C-Up>             | Increase Window Height                | n                  |
| <C-Down>           | Decrease Window Height                | n                  |
| <C-Left>           | Decrease Window Width                 | n                  |
| <C-Right>          | Increase Window Width                 | n                  |
| <A-J>              | Move line Down                        | n, i, v            |
| <A-K>              | Move line Up                          | n, i, v            |
| <S-h>              | Prev Buffer                           | n                  |
| <S-l>              | Next Buffer                           | n                  |
| [b                 | Prev Buffer                           | n                  |
| ]b                 | Next Buffer                           | n                  |
| <leader>bb         | Switch to Other Buffer                | n                  |
| <leader>`          | Switch to Other Buffer                | n                  |
| <leader>bd         | Delete Buffer                         | n                  |
| <leader>bo         | Delete Other Buffers                  | n                  |
| <leader>bD         | Delete Buffer and Window              | n                  |
| <esc>              | Escape and Clear hlsearch             | i, n, s            |
| <leader>ur         | Redraw / Clear hlsearch / Diff Update | n                  |
| n                  | Next Search Result                    | n, x, o            |
| N                  | Prev Search Result                    | n, x, o            |
| <C-s>              | Save File                             | i, x, n, s         |
| <leader>K          | Keywordprg                            | n                  |
| gco                | Add Comment Below                     | n                  |
| gcO                | Add Comment Above                     | n                  |
| <leader>l          | Lazy                                  | n                  |
| <leader>fn         | New File                              | n                  |
| <leader>xl         | Location List                         | n                  |
| <leader>xq         | Quickfix List                         | n                  |
| [q                 | Previous Quickfix                     | n                  |
| ]q                 | Next Quickfix                         | n                  |
| <leader>cf         | Format                                | n, x               |
| <leader>cd         | Line Diagnostics                      | n                  |
| ]d                 | Next Diagnostic                       | n                  |
| [d                 | Prev Diagnostic                       | n                  |
| ]e                 | Next Error                            | n                  |
| [e                 | Prev Error                            | n                  |
| ]w                 | Next Warning                          | n                  |
| [w                 | Prev Warning                          | n                  |
| <leader>uf         | Toggle Auto Format (Global)           | n                  |
| <leader>uF         | Toggle Auto Format (Buffer)           | n                  |
| <leader>us         | Toggle Spelling                       | n                  |
| <leader>uw         | Toggle Wrap                           | n                  |
| <leader>uL         | Toggle Relative Number                | n                  |
| <leader>ud         | Toggle Diagnostics                    | n                  |
| <leader>ul         | Toggle Line Numbers                   | n                  |
| <leader>uc         | Toggle Conceal Level                  | n                  |
| <leader>uA         | Toggle Tabline                        | n                  |
| <leader>uT         | Toggle Treesitter Highlight           | n                  |
| <leader>ub         | Toggle Dark Background                | n                  |
| <leader>uD         | Toggle Dimming                        | n                  |
| <leader>ua         | Toggle Animations                     | n                  |
| <leader>ug         | Toggle Indent Guides                  | n                  |
| <leader>uS         | Toggle Smooth Scroll                  | n                  |
| <leader>dpp        | Toggle Profiler                       | n                  |
| <leader>dph        | Toggle Profiler Highlights            | n                  |
| <leader>uh         | Toggle Inlay Hints                    | n                  |
| <leader>gL         | Git Log (cwd)                         | n                  |
| <leader>gb         | Git Blame Line                        | n                  |
| <leader>gf         | Git Current File History              | n                  |
| <leader>gl         | Git Log                               | n                  |
| <leader>gB         | Git Browse (open)                     | n, x               |
| <leader>gY         | Git Browse (copy)                     | n, x               |
| <leader>qq         | Quit All                              | n                  |
| <leader>ui         | Inspect Pos                           | n                  |
| <leader>uI         | Inspect Tree                          | n                  |
| <leader>L          | LazyVim Changelog                     | n                  |
| <leader>fT         | Terminal (cwd)                        | n                  |
| <leader>ft         | Terminal (Root Dir)                   | n                  |
| <c-/>              | Terminal (Root Dir)                   | n, t               |
| <c-\_>             | which_key_ignore                      | n, t               |
| <leader>-          | Split Window Below                    | n                  |
| <leader>|          | Split Window Right                    | n                  |
| <leader>wd         | Delete Window                         | n                  |
| <leader>wm         | Toggle Zoom Mode                      | n                  |
| <leader>uZ         | Toggle Zoom Mode                      | n                  |
| <leader>uz         | Toggle Zen Mode                       | n                  |
| <leader><tab>l     | Last Tab                              | n                  |
| <leader><tab>o     | Close Other Tabs                      | n                  |
| <leader><tab>f     | First Tab                             | n                  |
| <leader><tab><tab> | New Tab                               | n                  |
| <leader><tab>]     | Next Tab                              | n                  |
| <leader><tab>d     | Close Tab                             | n                  |
| <leader><tab>[     | Previous Tab                          | n                  |

## LSP[​](#lsp "Direct link to LSP")

| Key        | Description                | Mode |
| ---------- | -------------------------- | ---- |
| <leader>cl | Lsp Info                   | n    |
| gd         | Goto Definition            | n, n |
| gr         | References                 | n, n |
| gI         | Goto Implementation        | n, n |
| gy         | Goto T[y]pe Definition     | n, n |
| gD         | Goto Declaration           | n    |
| K          | Hover                      | n    |
| gK         | Signature Help             | n    |
| <c-k>      | Signature Help             | i    |
| <leader>ca | Code Action                | n, x |
| <leader>cc | Run Codelens               | n, x |
| <leader>cC | Refresh & Display Codelens | n    |
| <leader>cR | Rename File                | n    |
| <leader>cr | Rename                     | n    |
| <leader>cA | Source Action              | n    |
| ]]         | Next Reference             | n    |
| [[         | Prev Reference             | n    |
| <a-n>      | Next Reference             | n    |
| <a-p>      | Prev Reference             | n    |
| <leader>ss | LSP Symbols                | n    |
| <leader>sS | LSP Workspace Symbols      | n    |
| gai        | C[a]lls Incoming           | n    |
| gao        | C[a]lls Outgoing           | n    |

[bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)
[​](#bufferlinenvim "Direct link to bufferlinenvim")

---

| Key        | Description                 | Mode |
| ---------- | --------------------------- | ---- |
| <leader>bj | Pick Buffer                 | n    |
| <leader>bl | Delete Buffers to the Left  | n    |
| <leader>bp | Toggle Pin                  | n    |
| <leader>bP | Delete Non-Pinned Buffers   | n    |
| <leader>br | Delete Buffers to the Right | n    |
| [b         | Prev Buffer                 | n    |
| [B         | Move buffer prev            | n    |
| ]b         | Next Buffer                 | n    |
| ]B         | Move buffer next            | n    |
| <S-h>      | Prev Buffer                 | n    |
| <S-l>      | Next Buffer                 | n    |

[conform.nvim](https://github.com/stevearc/conform.nvim.git)
[​](#conformnvim "Direct link to conformnvim")

---

| Key        | Description           | Mode |
| ---------- | --------------------- | ---- |
| <leader>cF | Format Injected Langs | n, x |

[flash.nvim](https://github.com/folke/flash.nvim.git)
[​](#flashnvim "Direct link to flashnvim")

---

| Key       | Description                      | Mode    |
| --------- | -------------------------------- | ------- |
| <c-s>     | Toggle Flash Search              | c       |
| r         | Remote Flash                     | o       |
| R         | Treesitter Search                | o, x    |
| s         | Flash                            | n, o, x |
| S         | Flash Treesitter                 | n, o, x |
| <c-space> | Treesitter Incremental Selection | n, o, x |

[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim.git)
[​](#grug-farnvim "Direct link to grug-farnvim")

---

| Key        | Description        | Mode |
| ---------- | ------------------ | ---- |
| <leader>sr | Search and Replace | n, x |

[mason.nvim](https://github.com/mason-org/mason.nvim.git)
[​](#masonnvim "Direct link to masonnvim")

---

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>cm | Mason       | n    |

[noice.nvim](https://github.com/folke/noice.nvim.git)
[​](#noicenvim "Direct link to noicenvim")

---

| Key         | Description                     | Mode    |
| ----------- | ------------------------------- | ------- |
| <c-b>       | Scroll Backward                 | n, i, s |
| <c-f>       | Scroll Forward                  | n, i, s |
| <leader>sn  | +noice                          | n       |
| <leader>sna | Noice All                       | n       |
| <leader>snd | Dismiss All                     | n       |
| <leader>snh | Noice History                   | n       |
| <leader>snl | Noice Last Message              | n       |
| <leader>snt | Noice Picker (Telescope/FzfLua) | n       |
| <S-Enter>   | Redirect Cmdline                | c       |

[persistence.nvim](https://github.com/folke/persistence.nvim.git)
[​](#persistencenvim "Direct link to persistencenvim")

---

| Key        | Description                | Mode |
| ---------- | -------------------------- | ---- |
| <leader>qd | Don't Save Current Session | n    |
| <leader>ql | Restore Last Session       | n    |
| <leader>qs | Restore Session            | n    |
| <leader>qS | Select Session             | n    |

[snacks.nvim](https://github.com/folke/snacks.nvim.git)
[​](#snacksnvim "Direct link to snacksnvim")

---

| Key             | Description                         | Mode |
| --------------- | ----------------------------------- | ---- |
| <leader><space> | Find Files (Root Dir)               | n    |
| <leader>,       | Buffers                             | n    |
| <leader>.       | Toggle Scratch Buffer               | n    |
| <leader>/       | Grep (Root Dir)                     | n    |
| <leader>:       | Command History                     | n    |
| <leader>dps     | Profiler Scratch Buffer             | n    |
| <leader>e       | Explorer Snacks (root dir)          | n    |
| <leader>E       | Explorer Snacks (cwd)               | n    |
| <leader>fb      | Buffers                             | n    |
| <leader>fB      | Buffers (all)                       | n    |
| <leader>fc      | Find Config File                    | n    |
| <leader>fe      | Explorer Snacks (root dir)          | n    |
| <leader>fE      | Explorer Snacks (cwd)               | n    |
| <leader>ff      | Find Files (Root Dir)               | n    |
| <leader>fF      | Find Files (cwd)                    | n    |
| <leader>fg      | Find Files (git-files)              | n    |
| <leader>fp      | Projects                            | n    |
| <leader>fr      | Recent                              | n    |
| <leader>fR      | Recent (cwd)                        | n    |
| <leader>gd      | Git Diff (hunks)                    | n    |
| <leader>gD      | Git Diff (origin)                   | n    |
| <leader>gi      | GitHub Issues (open)                | n    |
| <leader>gI      | GitHub Issues (all)                 | n    |
| <leader>gp      | GitHub Pull Requests (open)         | n    |
| <leader>gP      | GitHub Pull Requests (all)          | n    |
| <leader>gs      | Git Status                          | n    |
| <leader>gS      | Git Stash                           | n    |
| <leader>n       | Notification History                | n    |
| <leader>S       | Select Scratch Buffer               | n    |
| <leader>s"      | Registers                           | n    |
| <leader>s/      | Search History                      | n    |
| <leader>sa      | Autocmds                            | n    |
| <leader>sb      | Buffer Lines                        | n    |
| <leader>sB      | Grep Open Buffers                   | n    |
| <leader>sc      | Command History                     | n    |
| <leader>sC      | Commands                            | n    |
| <leader>sd      | Diagnostics                         | n    |
| <leader>sD      | Buffer Diagnostics                  | n    |
| <leader>sg      | Grep (Root Dir)                     | n    |
| <leader>sG      | Grep (cwd)                          | n    |
| <leader>sh      | Help Pages                          | n    |
| <leader>sH      | Highlights                          | n    |
| <leader>si      | Icons                               | n    |
| <leader>sj      | Jumps                               | n    |
| <leader>sk      | Keymaps                             | n    |
| <leader>sl      | Location List                       | n    |
| <leader>sm      | Marks                               | n    |
| <leader>sM      | Man Pages                           | n    |
| <leader>sp      | Search for Plugin Spec              | n    |
| <leader>sq      | Quickfix List                       | n    |
| <leader>sR      | Resume                              | n    |
| <leader>su      | Undotree                            | n    |
| <leader>sw      | Visual selection or word (Root Dir) | n, x |
| <leader>sW      | Visual selection or word (cwd)      | n, x |
| <leader>uC      | Colorschemes                        | n    |
| <leader>un      | Dismiss All Notifications           | n    |

| Key        | Description              | Mode |
| ---------- | ------------------------ | ---- |
| <leader>st | Todo                     | n    |
| <leader>sT | Todo/Fix/Fixme           | n    |
| <leader>xt | Todo (Trouble)           | n    |
| <leader>xT | Todo/Fix/Fixme (Trouble) | n    |
| [t         | Previous Todo Comment    | n    |
| ]t         | Next Todo Comment        | n    |

[trouble.nvim](https://github.com/folke/trouble.nvim.git)
[​](#troublenvim "Direct link to troublenvim")

---

| Key        | Description                              | Mode |
| ---------- | ---------------------------------------- | ---- |
| <leader>cs | Symbols (Trouble)                        | n    |
| <leader>cS | LSP references/definitions/... (Trouble) | n    |
| <leader>xL | Location List (Trouble)                  | n    |
| <leader>xQ | Quickfix List (Trouble)                  | n    |
| <leader>xx | Diagnostics (Trouble)                    | n    |
| <leader>xX | Buffer Diagnostics (Trouble)             | n    |
| [q         | Previous Trouble/Quickfix Item           | n    |
| ]q         | Next Trouble/Quickfix Item               | n    |

[which-key.nvim](https://github.com/folke/which-key.nvim.git)
[​](#which-keynvim "Direct link to which-keynvim")

---

| Key          | Description                   | Mode |
| ------------ | ----------------------------- | ---- |
| <c-w><space> | Window Hydra Mode (which-key) | n    |
| <leader>?    | Buffer Keymaps (which-key)    | n    |

[avante.nvim](https://github.com/yetone/avante.nvim.git)
[​](#avantenvim "Direct link to avantenvim")

---

Part of [lazyvim.plugins.extras.ai.avante](https://www.lazyvim.org/extras/ai/avante)

| Key        | Description            | Mode |
| ---------- | ---------------------- | ---- |
| <leader>aa | Ask Avante             | n    |
| <leader>ac | Chat with Avante       | n    |
| <leader>ae | Edit Avante            | n    |
| <leader>af | Focus Avante           | n    |
| <leader>ah | Avante History         | n    |
| <leader>am | Select Avante Model    | n    |
| <leader>an | New Avante Chat        | n    |
| <leader>ap | Switch Avante Provider | n    |
| <leader>ar | Refresh Avante         | n    |
| <leader>as | Stop Avante            | n    |
| <leader>at | Toggle Avante          | n    |

[claudecode.nvim](https://github.com/coder/claudecode.nvim.git)
[​](#claudecodenvim "Direct link to claudecodenvim")

---

Part of [lazyvim.plugins.extras.ai.claudecode](https://www.lazyvim.org/extras/ai/claudecode)

| Key        | Description        | Mode |
| ---------- | ------------------ | ---- |
| <leader>a  | +ai                | n, v |
| <leader>aa | Accept diff        | n    |
| <leader>ab | Add current buffer | n    |
| <leader>ac | Toggle Claude      | n    |
| <leader>aC | Continue Claude    | n    |
| <leader>ad | Deny diff          | n    |
| <leader>af | Focus Claude       | n    |
| <leader>ar | Resume Claude      | n    |
| <leader>as | Add file           | n    |
| <leader>as | Send to Claude     | v    |

[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim.git)
[​](#copilotchatnvim "Direct link to copilotchatnvim")

---

Part of [lazyvim.plugins.extras.ai.copilot-chat](https://www.lazyvim.org/extras/ai/copilot-chat)

| Key        | Description                  | Mode |
| ---------- | ---------------------------- | ---- |
| <c-s>      | Submit Prompt                | n    |
| <leader>a  | +ai                          | n, x |
| <leader>aa | Toggle (CopilotChat)         | n, x |
| <leader>ap | Prompt Actions (CopilotChat) | n, x |
| <leader>aq | Quick Chat (CopilotChat)     | n, x |
| <leader>ax | Clear (CopilotChat)          | n, x |

[sidekick.nvim](https://github.com/folke/sidekick.nvim.git)
[​](#sidekicknvim "Direct link to sidekicknvim")

---

Part of [lazyvim.plugins.extras.ai.sidekick](https://www.lazyvim.org/extras/ai/sidekick)

| Key        | Description            | Mode       |
| ---------- | ---------------------- | ---------- |
| <leader>a  | +ai                    | n, v       |
| <leader>aa | Sidekick Toggle CLI    | n          |
| <leader>ad | Detach a CLI Session   | n          |
| <leader>af | Send File              | n          |
| <leader>ap | Sidekick Select Prompt | n, x       |
| <leader>as | Select CLI             | n          |
| <leader>at | Send This              | n, x       |
| <leader>av | Send Visual Selection  | x          |
| <c-.>      | Sidekick Toggle        | n, i, t, x |

[mini.surround](https://github.com/nvim-mini/mini.surround.git)
[​](#minisurround "Direct link to minisurround")

---

Part of [lazyvim.plugins.extras.coding.mini-surround](https://www.lazyvim.org/extras/coding/mini-surround)

| Key | Description                        | Mode |
| --- | ---------------------------------- | ---- |
| gsa | Add Surrounding                    | n, x |
| gsd | Delete Surrounding                 | n    |
| gsf | Find Right Surrounding             | n    |
| gsF | Find Left Surrounding              | n    |
| gsh | Highlight Surrounding              | n    |
| gsn | Update MiniSurround.config.n_lines | n    |
| gsr | Replace Surrounding                | n    |

[neogen](https://github.com/danymat/neogen.git)
[​](#neogen "Direct link to neogen")

---

Part of [lazyvim.plugins.extras.coding.neogen](https://www.lazyvim.org/extras/coding/neogen)

| Key        | Description                   | Mode |
| ---------- | ----------------------------- | ---- |
| <leader>cn | Generate Annotations (Neogen) | n    |

[yanky.nvim](https://github.com/gbprod/yanky.nvim.git)
[​](#yankynvim "Direct link to yankynvim")

---

Part of [lazyvim.plugins.extras.coding.yanky](https://www.lazyvim.org/extras/coding/yanky)

| Key       | Description                           | Mode |
| --------- | ------------------------------------- | ---- |
| <leader>p | Open Yank History                     | n, x |
| <p        | Put and Indent Left                   | n    |
| <P        | Put Before and Indent Left            | n    |
| =p        | Put After Applying a Filter           | n    |
| =P        | Put Before Applying a Filter          | n    |
| >p        | Put and Indent Right                  | n    |
| >P        | Put Before and Indent Right           | n    |
| [p        | Put Indented Before Cursor (Linewise) | n    |
| [P        | Put Indented Before Cursor (Linewise) | n    |
| [y        | Cycle Forward Through Yank History    | n    |
| ]p        | Put Indented After Cursor (Linewise)  | n    |
| ]P        | Put Indented After Cursor (Linewise)  | n    |
| ]y        | Cycle Backward Through Yank History   | n    |
| gp        | Put Text After Selection              | n, x |
| gP        | Put Text Before Selection             | n, x |
| p         | Put Text After Cursor                 | n, x |
| P         | Put Text Before Cursor                | n, x |
| y         | Yank Text                             | n, x |

[nvim-dap](https://github.com/mfussenegger/nvim-dap.git)
[​](#nvim-dap "Direct link to nvim-dap")

---

Part of [lazyvim.plugins.extras.dap.core](https://www.lazyvim.org/extras/dap/core)

| Key        | Description             | Mode |
| ---------- | ----------------------- | ---- |
| <leader>da | Run with Args           | n    |
| <leader>db | Toggle Breakpoint       | n    |
| <leader>dB | Breakpoint Condition    | n    |
| <leader>dc | Run/Continue            | n    |
| <leader>dC | Run to Cursor           | n    |
| <leader>dg | Go to Line (No Execute) | n    |
| <leader>di | Step Into               | n    |
| <leader>dj | Down                    | n    |
| <leader>dk | Up                      | n    |
| <leader>dl | Run Last                | n    |
| <leader>do | Step Out                | n    |
| <leader>dO | Step Over               | n    |
| <leader>dP | Pause                   | n    |
| <leader>dr | Toggle REPL             | n    |
| <leader>ds | Session                 | n    |
| <leader>dt | Terminate               | n    |
| <leader>dw | Widgets                 | n    |

[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui.git)
[​](#nvim-dap-ui "Direct link to nvim-dap-ui")

---

Part of [lazyvim.plugins.extras.dap.core](https://www.lazyvim.org/extras/dap/core)

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>de | Eval        | n, x |
| <leader>du | Dap UI      | n    |

[aerial.nvim](https://github.com/stevearc/aerial.nvim.git)
[​](#aerialnvim "Direct link to aerialnvim")

---

Part of [lazyvim.plugins.extras.editor.aerial](https://www.lazyvim.org/extras/editor/aerial)

| Key        | Description      | Mode |
| ---------- | ---------------- | ---- |
| <leader>cs | Aerial (Symbols) | n    |

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
[​](#telescopenvim "Direct link to telescopenvim")

---

Part of [lazyvim.plugins.extras.editor.aerial](https://www.lazyvim.org/extras/editor/aerial)

| Key        | Description          | Mode |
| ---------- | -------------------- | ---- |
| <leader>ss | Goto Symbol (Aerial) | n    |

[dial.nvim](https://github.com/monaqa/dial.nvim.git)
[​](#dialnvim "Direct link to dialnvim")

---

Part of [lazyvim.plugins.extras.editor.dial](https://www.lazyvim.org/extras/editor/dial)

| Key    | Description | Mode |
| ------ | ----------- | ---- |
| <C-a>  | Increment   | n, v |
| <C-x>  | Decrement   | n, v |
| g<C-a> | Increment   | n, x |
| g<C-x> | Decrement   | n, x |

[harpoon](https://github.com/ThePrimeagen/harpoon.git)
[​](#harpoon "Direct link to harpoon")

---

Part of [lazyvim.plugins.extras.editor.harpoon2](https://www.lazyvim.org/extras/editor/harpoon2)

| Key       | Description        | Mode |
| --------- | ------------------ | ---- |
| <leader>1 | Harpoon to File 1  | n    |
| <leader>2 | Harpoon to File 2  | n    |
| <leader>3 | Harpoon to File 3  | n    |
| <leader>4 | Harpoon to File 4  | n    |
| <leader>5 | Harpoon to File 5  | n    |
| <leader>6 | Harpoon to File 6  | n    |
| <leader>7 | Harpoon to File 7  | n    |
| <leader>8 | Harpoon to File 8  | n    |
| <leader>9 | Harpoon to File 9  | n    |
| <leader>h | Harpoon Quick Menu | n    |
| <leader>H | Harpoon File       | n    |

[vim-illuminate](https://github.com/RRethy/vim-illuminate.git)
[​](#vim-illuminate "Direct link to vim-illuminate")

---

Part of [lazyvim.plugins.extras.editor.illuminate](https://www.lazyvim.org/extras/editor/illuminate)

| Key | Description    | Mode |
| --- | -------------- | ---- |
| [[  | Prev Reference | n    |
| ]]  | Next Reference | n    |

[leap.nvim](https://codeberg.org/andyg/leap.nvim.git)
[​](#leapnvim "Direct link to leapnvim")

---

Part of [lazyvim.plugins.extras.editor.leap](https://www.lazyvim.org/extras/editor/leap)

| Key | Description       | Mode    |
| --- | ----------------- | ------- |
| gs  | Leap from Windows | n, o, x |
| s   | Leap Forward to   | n, o, x |
| S   | Leap Backward to  | n, o, x |

[mini.surround](https://github.com/nvim-mini/mini.surround.git)
[​](#minisurround-1 "Direct link to minisurround-1")

---

Part of [lazyvim.plugins.extras.editor.leap](https://www.lazyvim.org/extras/editor/leap)

| Key | Description | Mode |
| --- | ----------- | ---- |
| gz  | +surround   | n    |

[mini.diff](https://github.com/nvim-mini/mini.diff.git)
[​](#minidiff "Direct link to minidiff")

---

Part of [lazyvim.plugins.extras.editor.mini-diff](https://www.lazyvim.org/extras/editor/mini-diff)

| Key        | Description              | Mode |
| ---------- | ------------------------ | ---- |
| <leader>go | Toggle mini.diff overlay | n    |

[mini.files](https://github.com/nvim-mini/mini.files.git)
[​](#minifiles "Direct link to minifiles")

---

Part of [lazyvim.plugins.extras.editor.mini-files](https://www.lazyvim.org/extras/editor/mini-files)

| Key        | Description                                 | Mode |
| ---------- | ------------------------------------------- | ---- |
| <leader>fm | Open mini.files (Directory of Current File) | n    |
| <leader>fM | Open mini.files (cwd)                       | n    |

[outline.nvim](https://github.com/hedyhli/outline.nvim.git)
[​](#outlinenvim "Direct link to outlinenvim")

---

Part of [lazyvim.plugins.extras.editor.outline](https://www.lazyvim.org/extras/editor/outline)

| Key        | Description    | Mode |
| ---------- | -------------- | ---- |
| <leader>cs | Toggle Outline | n    |

[overseer.nvim](https://github.com/stevearc/overseer.nvim.git)
[​](#overseernvim "Direct link to overseernvim")

---

Part of [lazyvim.plugins.extras.editor.overseer](https://www.lazyvim.org/extras/editor/overseer)

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>oo | Run task    | n    |
| <leader>ot | Task action | n    |
| <leader>ow | Task list   | n    |

[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim.git)
[​](#refactoringnvim "Direct link to refactoringnvim")

---

Part of [lazyvim.plugins.extras.editor.refactoring](https://www.lazyvim.org/extras/editor/refactoring)

| Key        | Description              | Mode |
| ---------- | ------------------------ | ---- |
| <leader>r  | +refactor                | n, x |
| <leader>rb | Extract Block            | n, x |
| <leader>rc | Debug Cleanup            | n    |
| <leader>rf | Extract Function         | n, x |
| <leader>rF | Extract Function To File | n, x |
| <leader>ri | Inline Variable          | n, x |
| <leader>rp | Debug Print Variable     | n, x |
| <leader>rP | Debug Print              | n    |
| <leader>rs | Refactor                 | n, x |
| <leader>rx | Extract Variable         | n, x |

[snacks.nvim](https://github.com/folke/snacks.nvim.git)
[​](#snacksnvim-1 "Direct link to snacksnvim-1")

---

Part of [lazyvim.plugins.extras.editor.snacks_explorer](https://www.lazyvim.org/extras/editor/snacks_explorer)

| Key        | Description                | Mode |
| ---------- | -------------------------- | ---- |
| <leader>e  | Explorer Snacks (root dir) | n    |
| <leader>E  | Explorer Snacks (cwd)      | n    |
| <leader>fe | Explorer Snacks (root dir) | n    |
| <leader>fE | Explorer Snacks (cwd)      | n    |

[snacks.nvim](https://github.com/folke/snacks.nvim.git)
[​](#snacksnvim-2 "Direct link to snacksnvim-2")

---

Part of [lazyvim.plugins.extras.editor.snacks_picker](https://www.lazyvim.org/extras/editor/snacks_picker)

| Key             | Description                         | Mode |
| --------------- | ----------------------------------- | ---- |
| <leader><space> | Find Files (Root Dir)               | n    |
| <leader>,       | Buffers                             | n    |
| <leader>/       | Grep (Root Dir)                     | n    |
| <leader>:       | Command History                     | n    |
| <leader>fb      | Buffers                             | n    |
| <leader>fB      | Buffers (all)                       | n    |
| <leader>fc      | Find Config File                    | n    |
| <leader>ff      | Find Files (Root Dir)               | n    |
| <leader>fF      | Find Files (cwd)                    | n    |
| <leader>fg      | Find Files (git-files)              | n    |
| <leader>fp      | Projects                            | n    |
| <leader>fr      | Recent                              | n    |
| <leader>fR      | Recent (cwd)                        | n    |
| <leader>gd      | Git Diff (hunks)                    | n    |
| <leader>gD      | Git Diff (origin)                   | n    |
| <leader>gi      | GitHub Issues (open)                | n    |
| <leader>gI      | GitHub Issues (all)                 | n    |
| <leader>gp      | GitHub Pull Requests (open)         | n    |
| <leader>gP      | GitHub Pull Requests (all)          | n    |
| <leader>gs      | Git Status                          | n    |
| <leader>gS      | Git Stash                           | n    |
| <leader>n       | Notification History                | n    |
| <leader>s"      | Registers                           | n    |
| <leader>s/      | Search History                      | n    |
| <leader>sa      | Autocmds                            | n    |
| <leader>sb      | Buffer Lines                        | n    |
| <leader>sB      | Grep Open Buffers                   | n    |
| <leader>sc      | Command History                     | n    |
| <leader>sC      | Commands                            | n    |
| <leader>sd      | Diagnostics                         | n    |
| <leader>sD      | Buffer Diagnostics                  | n    |
| <leader>sg      | Grep (Root Dir)                     | n    |
| <leader>sG      | Grep (cwd)                          | n    |
| <leader>sh      | Help Pages                          | n    |
| <leader>sH      | Highlights                          | n    |
| <leader>si      | Icons                               | n    |
| <leader>sj      | Jumps                               | n    |
| <leader>sk      | Keymaps                             | n    |
| <leader>sl      | Location List                       | n    |
| <leader>sm      | Marks                               | n    |
| <leader>sM      | Man Pages                           | n    |
| <leader>sp      | Search for Plugin Spec              | n    |
| <leader>sq      | Quickfix List                       | n    |
| <leader>sR      | Resume                              | n    |
| <leader>su      | Undotree                            | n    |
| <leader>sw      | Visual selection or word (Root Dir) | n, x |
| <leader>sW      | Visual selection or word (cwd)      | n, x |
| <leader>uC      | Colorschemes                        | n    |

Part of [lazyvim.plugins.extras.editor.snacks_picker](https://www.lazyvim.org/extras/editor/snacks_picker)

| Key        | Description    | Mode |
| ---------- | -------------- | ---- |
| <leader>st | Todo           | n    |
| <leader>sT | Todo/Fix/Fixme | n    |

[nvim-ansible](https://github.com/mfussenegger/nvim-ansible.git)
[​](#nvim-ansible "Direct link to nvim-ansible")

---

Part of [lazyvim.plugins.extras.lang.ansible](https://www.lazyvim.org/extras/lang/ansible)

| Key        | Description               | Mode |
| ---------- | ------------------------- | ---- |
| <leader>ta | Ansible Run Playbook/Role | n    |

Part of [lazyvim.plugins.extras.lang.haskell](https://www.lazyvim.org/extras/lang/haskell)

| Key            | Description      | Mode |
| -------------- | ---------------- | ---- |
| <localleader>e | Evaluate All     | n    |
| <localleader>h | Hoogle Signature | n    |
| <localleader>r | REPL (Package)   | n    |
| <localleader>R | REPL (Buffer)    | n    |

[telescope_hoogle](https://github.com/luc-tielen/telescope_hoogle.git)
[​](#telescope_hoogle "Direct link to telescope_hoogle")

---

Part of [lazyvim.plugins.extras.lang.haskell](https://www.lazyvim.org/extras/lang/haskell)

| Key            | Description | Mode |
| -------------- | ----------- | ---- |
| <localleader>H | Hoogle      | n    |

[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim.git)
[​](#markdown-previewnvim "Direct link to markdown-previewnvim")

---

Part of [lazyvim.plugins.extras.lang.markdown](https://www.lazyvim.org/extras/lang/markdown)

| Key        | Description      | Mode |
| ---------- | ---------------- | ---- |
| <leader>cp | Markdown Preview | n    |

[nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python.git)
[​](#nvim-dap-python "Direct link to nvim-dap-python")

---

Part of [lazyvim.plugins.extras.lang.python](https://www.lazyvim.org/extras/lang/python)

| Key         | Description  | Mode |
| ----------- | ------------ | ---- |
| <leader>dPc | Debug Class  | n    |
| <leader>dPt | Debug Method | n    |

[venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim.git)
[​](#venv-selectornvim "Direct link to venv-selectornvim")

---

Part of [lazyvim.plugins.extras.lang.python](https://www.lazyvim.org/extras/lang/python)

| Key        | Description       | Mode |
| ---------- | ----------------- | ---- |
| <leader>cv | Select VirtualEnv | n    |

Part of [lazyvim.plugins.extras.lang.scala](https://www.lazyvim.org/extras/lang/scala)

| Key        | Description            | Mode |
| ---------- | ---------------------- | ---- |
| <leader>mc | Metals compile cascade | n    |
| <leader>me | Metals commands        | n    |
| <leader>mh | Metals hover worksheet | n    |

[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui.git)
[​](#vim-dadbod-ui "Direct link to vim-dadbod-ui")

---

Part of [lazyvim.plugins.extras.lang.sql](https://www.lazyvim.org/extras/lang/sql)

| Key       | Description | Mode |
| --------- | ----------- | ---- |
| <leader>D | Toggle DBUI | n    |

[vimtex](https://github.com/lervag/vimtex.git)
[​](#vimtex "Direct link to vimtex")

---

Part of [lazyvim.plugins.extras.lang.tex](https://www.lazyvim.org/extras/lang/tex)

| Key            | Description | Mode |
| -------------- | ----------- | ---- |
| <localLeader>l | +vimtex     | n    |

[typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim.git)
[​](#typst-previewnvim "Direct link to typst-previewnvim")

---

Part of [lazyvim.plugins.extras.lang.typst](https://www.lazyvim.org/extras/lang/typst)

| Key        | Description          | Mode |
| ---------- | -------------------- | ---- |
| <leader>cp | Toggle Typst Preview | n    |

[neotest](https://github.com/nvim-neotest/neotest.git)
[​](#neotest "Direct link to neotest")

---

Part of [lazyvim.plugins.extras.test.core](https://www.lazyvim.org/extras/test/core)

| Key        | Description                   | Mode |
| ---------- | ----------------------------- | ---- |
| <leader>t  | +test                         | n    |
| <leader>ta | Attach to Test (Neotest)      | n    |
| <leader>tl | Run Last (Neotest)            | n    |
| <leader>to | Show Output (Neotest)         | n    |
| <leader>tO | Toggle Output Panel (Neotest) | n    |
| <leader>tr | Run Nearest (Neotest)         | n    |
| <leader>ts | Toggle Summary (Neotest)      | n    |
| <leader>tS | Stop (Neotest)                | n    |
| <leader>tt | Run File (Neotest)            | n    |
| <leader>tT | Run All Test Files (Neotest)  | n    |
| <leader>tw | Toggle Watch (Neotest)        | n    |

[nvim-dap](https://github.com/mfussenegger/nvim-dap.git)
[​](#nvim-dap-1 "Direct link to nvim-dap-1")

---

Part of [lazyvim.plugins.extras.test.core](https://www.lazyvim.org/extras/test/core)

| Key        | Description   | Mode |
| ---------- | ------------- | ---- |
| <leader>td | Debug Nearest | n    |

[edgy.nvim](https://github.com/folke/edgy.nvim.git)
[​](#edgynvim "Direct link to edgynvim")

---

Part of [lazyvim.plugins.extras.ui.edgy](https://www.lazyvim.org/extras/ui/edgy)

| Key        | Description        | Mode |
| ---------- | ------------------ | ---- |
| <leader>ue | Edgy Toggle        | n    |
| <leader>uE | Edgy Select Window | n    |

[chezmoi.nvim](https://github.com/xvzc/chezmoi.nvim.git)
[​](#chezmoinvim "Direct link to chezmoinvim")

---

Part of [lazyvim.plugins.extras.util.chezmoi](https://www.lazyvim.org/extras/util/chezmoi)

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>sz | Chezmoi     | n    |

[gh.nvim](https://github.com/ldelossa/gh.nvim.git)
[​](#ghnvim "Direct link to ghnvim")

---

Part of [lazyvim.plugins.extras.util.gh](https://www.lazyvim.org/extras/util/gh)

| Key         | Description   | Mode |
| ----------- | ------------- | ---- |
| <leader>G   | +Github       | n    |
| <leader>Gc  | +Commits      | n    |
| <leader>Gcc | Close         | n    |
| <leader>Gce | Expand        | n    |
| <leader>Gco | Open To       | n    |
| <leader>Gcp | Pop Out       | n    |
| <leader>Gcz | Collapse      | n    |
| <leader>Gi  | +Issues       | n    |
| <leader>Gio | Open          | n    |
| <leader>Gip | Preview       | n    |
| <leader>Gl  | +Litee        | n    |
| <leader>Glt | Toggle Panel  | n    |
| <leader>Gp  | +Pull Request | n    |
| <leader>Gpc | Close         | n    |
| <leader>Gpd | Details       | n    |
| <leader>Gpe | Expand        | n    |
| <leader>Gpo | Open          | n    |
| <leader>Gpp | PopOut        | n    |
| <leader>Gpr | Refresh       | n    |
| <leader>Gpt | Open To       | n    |
| <leader>Gpz | Collapse      | n    |
| <leader>Gr  | +Review       | n    |
| <leader>Grb | Begin         | n    |
| <leader>Grc | Close         | n    |
| <leader>Grd | Delete        | n    |
| <leader>Gre | Expand        | n    |
| <leader>Grs | Submit        | n    |
| <leader>Grz | Collapse      | n    |
| <leader>Gt  | +Threads      | n    |
| <leader>Gtc | Create        | n    |
| <leader>Gtn | Next          | n    |
| <leader>Gtt | Toggle        | n    |

[mason.nvim](https://github.com/mason-org/mason.nvim.git)
[​](#masonnvim-1 "Direct link to masonnvim-1")

---

Part of [lazyvim.plugins.extras.util.gitui](https://www.lazyvim.org/extras/util/gitui)

| Key        | Description      | Mode |
| ---------- | ---------------- | ---- |
| <leader>gg | GitUi (Root Dir) | n    |
| <leader>gG | GitUi (cwd)      | n    |

[octo.nvim](https://github.com/pwntester/octo.nvim.git)
[​](#octonvim "Direct link to octonvim")

---

Part of [lazyvim.plugins.extras.util.octo](https://www.lazyvim.org/extras/util/octo)

| Key             | Description          | Mode |
| --------------- | -------------------- | ---- |
| <leader>gi      | List Issues (Octo)   | n    |
| <leader>gI      | Search Issues (Octo) | n    |
| <leader>gp      | List PRs (Octo)      | n    |
| <leader>gP      | Search PRs (Octo)    | n    |
| <leader>gr      | List Repos (Octo)    | n    |
| <leader>gS      | Search (Octo)        | n    |
| <localleader>a  | +assignee (Octo)     | n    |
| <localleader>c  | +comment/code (Octo) | n    |
| <localleader>g  | +goto_issue (Octo)   | n    |
| <localleader>i  | +issue (Octo)        | n    |
| <localleader>l  | +label (Octo)        | n    |
| <localleader>p  | +pr (Octo)           | n    |
| <localleader>pr | +rebase (Octo)       | n    |
| <localleader>ps | +squash (Octo)       | n    |
| <localleader>r  | +react (Octo)        | n    |
| <localleader>v  | +review (Octo)       | n    |

[fzf-lua](https://github.com/ibhagwan/fzf-lua.git)
[​](#fzf-lua "Direct link to fzf-lua")

---

Part of [lazyvim.plugins.extras.util.project](https://www.lazyvim.org/extras/util/project)

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>fp | Projects    | n    |

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
[​](#telescopenvim-1 "Direct link to telescopenvim-1")

---

Part of [lazyvim.plugins.extras.util.project](https://www.lazyvim.org/extras/util/project)

| Key        | Description | Mode |
| ---------- | ----------- | ---- |
| <leader>fp | Projects    | n    |

[kulala.nvim](https://github.com/mistweaverco/kulala.nvim.git)
[​](#kulalanvim "Direct link to kulalanvim")

---

Part of [lazyvim.plugins.extras.util.rest](https://www.lazyvim.org/extras/util/rest)

| Key        | Description              | Mode |
| ---------- | ------------------------ | ---- |
| <leader>R  | +Rest                    | n    |
| <leader>Rb | Open scratchpad          | n    |
| <leader>Rc | Copy as cURL             | n    |
| <leader>RC | Paste from curl          | n    |
| <leader>Re | Set environment          | n    |
| <leader>Rg | Download GraphQL schema  | n    |
| <leader>Ri | Inspect current request  | n    |
| <leader>Rn | Jump to next request     | n    |
| <leader>Rp | Jump to previous request | n    |
| <leader>Rq | Close window             | n    |
| <leader>Rr | Replay the last request  | n    |
| <leader>Rs | Send the request         | n    |
| <leader>RS | Show stats               | n    |
| <leader>Rt | Toggle headers/body      | n    |
