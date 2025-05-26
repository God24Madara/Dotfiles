# ╭──────────────────────────────────────────────────────────────────────────────╮
# │                                                                              │
# │    ███████╗███████╗██╗  ██╗    ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ │
# │    ╚══███╔╝██╔════╝██║  ██║   ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ │
# │      ███╔╝ ███████╗███████║   ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗│
# │     ███╔╝  ╚════██║██╔══██║   ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║│
# │    ███████╗███████║██║  ██║   ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝│
# │    ╚══════╝╚══════╝╚═╝  ╚═╝    ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ │
# │                                                                              │
# │                      🐚 Enhanced Zsh Configuration 🐚                        │
# │                    ⚡ Fast, Beautiful, and Powerful ⚡                       │
# │                                                                              │
# ╰──────────────────────────────────────────────────────────────────────────────╯

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🍺  B R E W   S E T U P   ( macOS )                                       │
# └────────────────────────────────────────────────────────────────────────────┘
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "🍺 Homebrew environment loaded"
fi

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚡  Z I N I T   I N I T I A L I Z A T I O N                               │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │          🔧 Zinit Installation          │
# ╰─────────────────────────────────────────╯
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
   echo "📦 Installing Zinit..."
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
   echo "✅ Zinit installed successfully!"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🚀  P R O M P T   S E T U P                                               │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │            🌟 Starship 🌟               │
# ╰─────────────────────────────────────────╯
# Initialize Starship prompt for a beautiful and highly customizable prompt.
# Customize your Starship prompt by editing ~/.config/starship.toml
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
    echo "🚀 Starship prompt loaded"
else
    echo "⚠️  Starship not found. Install with: curl -sS https://starship.rs/install.sh | sh"
fi

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🔌  E S S E N T I A L   P L U G I N S                                     │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │          🎨 Syntax & Completion         │
# ╰─────────────────────────────────────────╯
zinit light zsh-users/zsh-syntax-highlighting # Real-time command highlighting.
zinit light zsh-users/zsh-completions # Comprehensive completion definitions for many commands.
zinit light zsh-users/zsh-autosuggestions # Provides fish-like autosuggestions. Press '→' (right arrow) to accept.
zinit light zsh-users/zsh-history-substring-search # Search history with partial strings.

# ╭─────────────────────────────────────────╮
# │           🔍 Search & Navigation        │
# ╰─────────────────────────────────────────╯
zinit light Aloxaf/fzf-tab # Replaces default completion menu with FZF for a powerful interactive experience.
zinit light joshskidmore/zsh-fzf-history-search # Fuzzy search through your command history with FZF.
zinit light wfxr/forgit # A utility tool for `git` commands with `fzf` integration.
zinit light denisidoro/navi # Interactive cheatsheet tool for quick command lookup.

# ╭─────────────────────────────────────────╮
# │            ⚡ Productivity Tools        │
# ╰─────────────────────────────────────────╯
zinit light z-shell/zsh-zoxide # Smart directory jumping. `z <part_of_dir_name>`
zinit light hlissner/zsh-autopair # Automatically closes, deletes, and skips over matching delimiters (quotes, parentheses).
zinit light MichaelAquilina/zsh-you-should-use # Suggests alternative, more efficient commands.
zinit light zsh-users/zsh-apple-touchbar # Apple Touch Bar support for Zsh.
zinit light tldr-pages/tldr # Simplified and community-driven man pages. Type `tldr <command>`.

# ╭─────────────────────────────────────────╮
# │            🧠 AI-like Tools             │
# ╰─────────────────────────────────────────╯
# This plugin integrates OpenAI Codex (and Google Generative AI/Gemini) for AI-powered command completion.
# You will need to set up your API key in ~/.config/zsh_codex.ini after installation.
# Refer to https://github.com/tom-doerr/zsh_codex for detailed setup instructions.
zinit light tom-doerr/zsh_codex # AI-powered command completion. Press `^X` (Ctrl+X) to trigger.

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  📦  O H - M Y - Z S H   S N I P P E T S                                   │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │             🌐 Core Tools               │
# ╰─────────────────────────────────────────╯
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::spectrum.zsh

# ╭─────────────────────────────────────────╮
# │           🔧 Development Tools          │
# ╰─────────────────────────────────────────╯
zinit snippet OMZP::git
zinit snippet OMZP::github
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::node
zinit snippet OMZP::npm
zinit snippet OMZP::python
zinit snippet OMZP::pip

# ╭─────────────────────────────────────────╮
# │          ☁️  Cloud & DevOps Tools       │
# ╰─────────────────────────────────────────╯
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::terraform
zinit snippet OMZP::helm

# ╭─────────────────────────────────────────╮
# │            🐧 System Tools              │
# ╰─────────────────────────────────────────╯
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::systemd
zinit snippet OMZP::archlinux

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚙️   S H E L L   C O N F I G U R A T I O N                                │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │            📚 History Settings          │
# ╰─────────────────────────────────────────╯
HISTSIZE=10000                               # Increased history size
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History options
setopt appendhistory                         # Append to history file
setopt sharehistory                          # Share history between sessions
setopt hist_ignore_space                     # Ignore commands starting with space
setopt hist_ignore_all_dups                  # Remove all duplicatessetopt hist_save_no_dups                     # Don't save duplicates
setopt hist_ignore_dups                      # Ignore consecutive duplicatessetopt hist_find_no_dups                     # Don't show duplicates in search
setopt hist_verify                           # Verify history substitutions

# ╭─────────────────────────────────────────╮
# │          🎯 Completion Styling          │
# ╰─────────────────────────────────────────╯
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no # This helps fzf-tab take over the completion menu
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true

# FZF Tab configuration
# Preview directory's content with lsd when completing cd and zoxide
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color=always $realpath'
# Use tmux popup for fzf-tab for a less intrusive experience
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Load completions - IMPORTANT: Placed here as per your original working config
autoload -Uz compinit && compinit

# Replay completion system to ensure all plugin completions are registered
# This should be done AFTER all completion-related plugins and zstyles are set.
zinit cdreplay -q

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🎯  A L I A S E S   &   F U N C T I O N S                                 │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │             📁 LSD Aliases              │
# ╰─────────────────────────────────────────╯
if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd --color=always'
    alias ll='lsd -l --color=always'
    alias la='lsd -la --color=always'
    alias lt='lsd --tree --color=always'
    alias l='lsd --color=always'
    alias lla='lsd -la --color=always'
    alias llt='lsd -l --tree --color=always'
    alias lsa='lsd -a --color=always'
else
    echo "⚠️  LSD not found. Install with your package manager for better file listing."
    alias ls='ls --color=auto'
    alias ll='ls -alF --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF --color=auto'
fi

# ╭─────────────────────────────────────────╮
# │           ⚡ Quick Navigation           │
# ╰─────────────────────────────────────────╯
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# ╭─────────────────────────────────────────╮
# │            🔧 System Shortcuts          │
# ╰─────────────────────────────────────────╯
alias c='clear'
alias h='history'
alias j='jobs -l'
alias reload='source ~/.zshrc && echo "🔄 Zsh configuration reloaded!"'
alias zshconfig='${EDITOR:-nvim} ~/.zshrc'

# ╭─────────────────────────────────────────╮
# │           📝 Editor Shortcuts           │
# ╰─────────────────────────────────────────╯
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias nano='nvim'

# ╭─────────────────────────────────────────╮
# │            🐳 Docker Shortcuts          │
# ╰─────────────────────────────────────────╯
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dimg='docker images'
alias dlog='docker logs'
alias dexec='docker exec -it'

# ╭─────────────────────────────────────────╮
# │           🔍 Search & Find              │
# ╰─────────────────────────────────────────╯
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rg='rg --color=auto'

# ╭─────────────────────────────────────────╮
# │            📊 System Info               │
# ╰─────────────────────────────────────────╯
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'
alias ps='ps auxf'

# ╭─────────────────────────────────────────╮
# │            🌐 Network Tools             │
# ╰─────────────────────────────────────────╯
alias ping='ping -c 4'
alias myip='curl -s ifconfig.me && echo'
alias localip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🔌  S H E L L   I N T E G R A T I O N S                                   │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │              🔍 FZF Setup               │
# ╰─────────────────────────────────────────╯
if command -v fzf >/dev/null 2>&1; then
    # IMPORTANT: This sources FZF's Zsh integration, defining the fzf-history-widget and fzf-file-widget.
    # It MUST be sourced before any keybindings that use these widgets.
    eval "$(fzf --zsh)"
    # FZF Theme: Nord-inspired for a more attractive look
    # For true transparency, configure your terminal emulator (e.g., iTerm2, Alacritty, Kitty)
    export FZF_DEFAULT_OPTS="
        --height=25% \\
        --layout=reverse \\
        --border=rounded \\
        --margin=1 \\
        --padding=1 \\
        --color=fg:#D8DEE9,bg:#2E3440,hl:#88C0D0 \\
        --color=fg+:#ECEFF4,bg+:#3B4252,hl+:#88C0D0 \\
        --color=info:#A3BE8C,prompt:#EBCB8B,pointer:#BF616A \\
        --color=marker:#BF616A,spinner:#A3BE8C,header:#4C566A
    "
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    fi
    echo "🔍 FZF configured with custom theme and reduced height"
else
     echo "⚠️  FZF not found. Install for better fuzzy finding."
fi

# ╭─────────────────────────────────────────╮
# │            🚀 Zoxide Setup              │
# ╰─────────────────────────────────────────╯
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
    echo "🚀 Zoxide smart directory jumping enabled"
else
    echo "⚠️  Zoxide not found. Install for smart directory navigation."
fi

# ╭─────────────────────────────────────────╮
# │             ⌨️  Key Bindings            │
# ╰─────────────────────────────────────────╯
# Key bindings MUST be defined AFTER the widgets they reference are available.
# This section has been moved to after FZF setup to ensure widgets are loaded.
bindkey -e                                    # Emacs mode
bindkey '^p' history-search-backward          # Ctrl+P - Previous command
bindkey '^n' history-search-forward           # Ctrl+N - Next command
bindkey '^[w' kill-region                     # Alt+W - Kill region
bindkey '^r' fzf-history-widget              # Ctrl+R - FZF history search
bindkey '^f' fzf-file-widget                 # Ctrl+F - FZF file search

# ╭─────────────────────────────────────────╮
# │           ⏱️  Helpful Functions         │
# ╰─────────────────────────────────────────╯
# Create directory and enter it
mcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find file by name
ff() {
    find . -name "*$1*" -type f
}

# Find directory by name
fd() {
    find . -name "*$1*" -type d
}

# ┌────────────────────────────────────────────────────────────────────────────┐
# │                        ✨ Configuration Complete! ✨                       │
# │                   Your shell is now supercharged! 🚀                       │
# │                                                                            │
# │  💡 Pro Tips:                                                              │
# │     • Use 'cd' with zoxide for smart directory jumping                     │
# │     • Press Ctrl+R for fuzzy history search                                │
# │     • Use 'lt' for tree view with lsd                                      │
# │     • Type 'reload' to refresh this config                                 │
# └────────────────────────────────────────────────────────────────────────────┘
echo "🎉 Enhanced Zsh configuration loaded successfully!"

