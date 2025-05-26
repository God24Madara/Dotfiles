# ╭────────────────────────────────────────────────────────────────────────────────────────────╮
# │                                                                                            │
# │     ██████╗  █████╗ ███████╗██╗  ██╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗     │
# │     ██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝     │
# │     ██████╔╝███████║███████╗███████║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗    │
# │     ██╔══██╗██╔══██║╚════██║██╔══██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║    │
# │     ██████╔╝██║  ██║███████║██║  ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝    │
# │     ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝     │
# │                                                                                            │
# │			🐚 Enhanced Bash Configuration 🐚                                      │
# │                    ⚡ Fast, Beautiful, and Powerful ⚡                                     │
# │                                                                                            │
# ╰────────────────────────────────────────────────────────────────────────────────────────────╯

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚙️   P R E - L O A D   S E T U P                                          │
# └────────────────────────────────────────────────────────────────────────────┘
# Create necessary directories if they don't exist
mkdir -p "${XDG_DATA_HOME:-${HOME}/.local/share}"/zinit/zinit.git # For Zinit (if you switch back to Zsh)
mkdir -p ~/.bash_plugins                                          # For manually cloned Bash plugins
mkdir -p ~/.config                                                # For Starship, FZF, zsh_codex, Navi, tldr config files

# Function to detect OS and package manager
_get_pkg_manager() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "brew"
  elif command -v apt-get >/dev/null 2>&1; then
    echo "apt"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v yum >/dev/null 2>&1; then
    echo "yum"
  elif command -v pacman >/dev/null 2>&1; then
    echo "pacman"
  else
    echo "unknown"
  fi
}

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🍺  B R E W   S E T U P   ( macOS )                                       │
# └────────────────────────────────────────────────────────────────────────────┘
# For macOS users, load Homebrew environment variables.
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "🍺 Homebrew environment loaded"
fi

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🚀  P R O M P T   S E T U P                                              │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │            🌟 Starship 🌟               │
# ╰─────────────────────────────────────────╯
# Initialize Starship prompt for a beautiful and highly customizable prompt.
# Starship is cross-shell compatible.
# Customize your Starship prompt by editing ~/.config/starship.toml
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
  echo "🚀 Starship prompt loaded"
else
  echo "⚠️  Starship not found. Run 'install_missing_tools' to get installation instructions."
fi

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🔌  E S S E N T I A L   P L U G I N S & T O O L S                        │
# └────────────────────────────────────────────────────────────────────────────┘
# Note: For Bash, plugins are typically sourced directly.
# You might need to manually clone these repositories, e.g., into a ~/.bash_plugins directory.

# ╭─────────────────────────────────────────╮
# │          🎨 Syntax & Completion         │
# ╰─────────────────────────────────────────╯
# Bash Line Editor (ble.sh) - Provides Syntax Highlighting, Autosuggestions, etc.
# Install: git clone --recursive --depth 1 https://github.com/akinomyoga/ble.sh.git ~/.bash_plugins/ble.sh
if [ -f ~/.bash_plugins/ble.sh/out/ble.sh ]; then
  source ~/.bash_plugins/ble.sh/out/ble.sh
  echo "🎨 Bash Line Editor (ble.sh) loaded for syntax highlighting & autosuggestions"
  # Additional ble.sh configuration (optional, refer to ble.sh docs for more)
  # ble-reload
  # This might be needed if you change ble.sh config after sourcing, but usually not on initial load
else
  echo "⚠️  Bash Line Editor (ble.sh) not found. Run 'install_missing_tools' for installation instructions."
  echo "⚠️  (This provides syntax highlighting AND autosuggestions)"
fi

# Bash Completions (often provided by your system's `bash-completion` package)
# Install: On Debian/Ubuntu: sudo apt-get install bash-completion
#          On macOS (with Homebrew): brew install bash-completion
#          On Arch Linux: sudo pacman -S bash-completion
if [ -f /usr/local/etc/bash_completion ]; then # macOS Homebrew path
  . /usr/local/etc/bash_completion
  echo "✅ Bash completions loaded"
elif [ -f /etc/bash_completion ]; then # Linux path
  . /etc/bash_completion
  echo "✅ Bash completions loaded"
else
  echo "⚠️  Bash completions not found. Run 'install_missing_tools' for installation instructions."
fi

# Bash History Substring Search
# This is typically configured via bind commands in Bash.
bind '"\e[A": history-search-backward' # Up arrow for substring search
bind '"\e[B": history-search-forward'  # Down arrow for substring search

# ╭─────────────────────────────────────────╮
# │           🔍 Search & Navigation        │
# ╰─────────────────────────────────────────╯
# FZF (Fuzzy Finder) - Core setup is below in "Shell Integrations"
# Forgit (Git utilities with FZF)
# Install: git clone https://github.com/wfxr/forgit.git ~/.bash_plugins/forgit
if [ -f ~/.bash_plugins/forgit/forgit.plugin.bash ]; then
  source ~/.bash_plugins/forgit/forgit.plugin.bash
  echo "🌳 Forgit loaded"
else
  echo "⚠️  Forgit not found. Run 'install_missing_tools' for installation instructions."
fi

# Navi (Interactive cheatsheet tool)
# Install: brew install navi OR check https://github.com/denisidoro/navi#installation
if command -v navi >/dev/null 2>&1; then
  eval "$(navi widget bash)"
  echo "📚 Navi cheatsheet loaded"
else
  echo "⚠️  Navi not found. Run 'install_missing_tools' for installation instructions."
fi

# ╭─────────────────────────────────────────╮
# │            ⚡ Productivity Tools        │
# ╰─────────────────────────────────────────╯
# Zoxide (Smart directory jumping)
# Install: brew install zoxide OR check https://github.com/ajeetdsouza/zoxide#installation
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd bash)"
  echo "🚀 Zoxide smart directory jumping enabled"
else
  echo "⚠️  Zoxide not found. Run 'install_missing_tools' for installation instructions."
fi

# tldr (Simplified man pages)
# Install: brew install tldr OR npm install -g tldr
if command -v tldr >/dev/null 2>&1; then
  echo "📖 tldr quick help loaded"
else
  echo "⚠️  tldr not found. Run 'install_missing_tools' for installation instructions."
fi

# ╭─────────────────────────────────────────╮
# │            🧠 AI-like Tools             │
# ╰─────────────────────────────────────────╯
# Zsh_Codex (AI-powered command completion) - Has Bash support!
# Install: git clone https://github.com/tom-doerr/zsh_codex.git ~/.bash_plugins/zsh_codex
# You will need to set up your API key in ~/.config/zsh_codex.ini after installation.
# Refer to https://github.com/tom-doerr/zsh_codex for detailed setup instructions.
if [ -f ~/.bash_plugins/zsh_codex/zsh_codex.plugin.bash ]; then
  source ~/.bash_plugins/zsh_codex/zsh_codex.plugin.bash
  echo "🧠 AI-powered command completion loaded"
  # Bind Ctrl+X to trigger AI completion
  bind '"\C-x": create_completion'
else
  echo "⚠️  AI-powered command completion (zsh_codex) not found. Run 'install_missing_tools' for installation instructions."
fi

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚙️   S H E L L   C O N F I G U R A T I O N                               │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │            📚 History Settings          │
# ╰─────────────────────────────────────────╯
HISTSIZE=10000           # Increased history size
HISTFILE=~/.bash_history # Bash history file
SAVEHIST=$HISTSIZE
HISTCONTROL=ignoreboth:erasedups # Ignore duplicates and commands starting with space

# History options
shopt -s histappend # Append to history file, don't overwrite

# ╭─────────────────────────────────────────╮
# │          🎯 Completion Styling          │
# ╰─────────────────────────────────────────╯
# Bash uses `dircolors` for file listing colors, and FZF has its own styling.
# `zstyle` is Zsh-specific.

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🎯  A L I A S E S   &   F U N C T I O N S                                │
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
  echo "⚠️  LSD not found. Run 'install_missing_tools' for installation instructions."
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
alias reload='source ~/.bashrc && echo "🔄 Bash configuration reloaded!"'
alias bashconfig='${EDITOR:-nvim} ~/.bashrc'

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
# │  🔌  S H E L L   I N T E G R A T I O N S                                  │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │              🔍 FZF Setup               │
# ╰─────────────────────────────────────────╯
# Function to set up FZF
_setup_fzf() {
  if command -v fzf >/dev/null 2>&1; then
    # Directly evaluate FZF's integration script. This must run before FZF_DEFAULT_OPTS.
    eval "$(fzf --bash)"
    echo "🔍 FZF Bash integration loaded"

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
            --color=marker:#BF616A,spinner:#A3BE8C,header:#4C564A
        "
    if command -v fd >/dev/null 2>&1; then
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    else
      echo "⚠️  'fd' (find-d) not found. FZF's default command will fall back to 'find'. Run 'install_missing_tools' for installation instructions."
    fi
    echo "🔍 FZF configured with custom theme and reduced height"
  else
    echo "⚠️  FZF not found. Run 'install_missing_tools' for installation instructions."
  fi
}

# Call FZF setup function early
_setup_fzf

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

# Function to install missing tools
install_missing_tools() {
  local pkg_manager=$(_get_pkg_manager)
  local missing_tools=()
  local missing_git_repos=()
  local missing_python_deps=()
  local missing_pip_installer=""

  echo "Checking for missing tools and dependencies..."

  # Check for binaries
  if ! command -v starship >/dev/null 2>&1; then missing_tools+=("starship"); fi
  if ! command -v lsd >/dev/null 2>&1; then missing_tools+=("lsd"); fi
  # FZF is handled by _setup_fzf, no need to add to missing_tools here
  if ! command -v fd >/dev/null 2>&1; then missing_tools+=("fd"); fi
  if ! command -v zoxide >/dev/null 2>&1; then missing_tools+=("zoxide"); fi
  if ! command -v navi >/dev/null 2>&1; then missing_tools+=("navi"); fi
  if ! command -v tldr >/dev/null 2>&1; then missing_tools+=("tldr"); fi
  if ! command -v bash-completion >/dev/null 2>&1 &&
    ! [ -f /usr/local/etc/bash_completion ] &&
    ! [ -f /etc/bash_completion ]; then
    missing_tools+=("bash-completion")
  fi

  # Check for git-cloned plugins
  if [ ! -d ~/.bash_plugins/ble.sh ]; then missing_git_repos+=("git clone --recursive --depth 1 https://github.com/akinomyoga/ble.sh.git ~/.bash_plugins/ble.sh"); fi
  if [ ! -d ~/.bash_plugins/forgit ]; then missing_git_repos+=("git clone https://github.com/wfxr/forgit.git ~/.bash_plugins/forgit"); fi
  if [ ! -d ~/.bash_plugins/zsh_codex ]; then missing_git_repos+=("git clone https://github.com/tom-doerr/zsh_codex.git ~/.bash_plugins/zsh_codex"); fi

  # Check for zsh_codex Python dependencies and pip
  if command -v python3 >/dev/null 2>&1; then
    if ! command -v pip3 >/dev/null 2>&1; then
      case "$pkg_manager" in
      "apt") missing_pip_installer="sudo apt-get install python3-pip" ;;
      "dnf") missing_pip_installer="sudo dnf install python3-pip" ;;
      "yum") missing_pip_installer="sudo yum install python3-pip" ;;
      "pacman") missing_pip_installer="sudo pacman -S python-pip" ;; # Note: pacman might use python-pip for python3
      "brew") missing_pip_installer="brew install python" ;;         # Homebrew installs pip with python
      *) missing_pip_installer="Please install pip3 manually for python3." ;;
      esac
      echo "⚠️  pip3 not found for python3. Please install it first: $missing_pip_installer"
    else # pip3 is available, check Python libraries
      if ! python3 -c "import openai" &>/dev/null || ! python3 -c "import google.generativeai" &>/dev/null; then
        # For Arch (pacman), recommend pip3 install --user or pipx
        if [[ "$pkg_manager" == "pacman" ]]; then
          missing_python_deps+=("pip3 install --user openai google-generativeai # Or use 'pipx install zsh_codex' if available")
          echo "💡 On Arch Linux, consider using 'pipx install zsh_codex' if you want zsh_codex as a standalone app, or 'pip3 install --user openai google-generativeai' to avoid system package conflicts."
        else
          missing_python_deps+=("pip3 install openai google-generativeai")
        fi
      fi
    fi
  else
    echo "⚠️  Python3 not found. Cannot check/install zsh_codex Python dependencies."
  fi

  if [ ${#missing_tools[@]} -eq 0 ] && [ ${#missing_git_repos[@]} -eq 0 ] && [ ${#missing_python_deps[@]} -eq 0 ] && [ -z "$missing_pip_installer" ]; then
    echo "🎉 All required tools and dependencies are already installed!"
    return 0
  fi

  echo ""
  echo "The following tools/dependencies are missing or not fully set up:"
  echo "----------------------------------------------------------------"

  if [ ${#missing_tools[@]} -gt 0 ]; then
    echo "Missing system packages (run these commands):"
    case "$pkg_manager" in
    "brew") echo "  brew install ${missing_tools[*]}" ;;
    "apt") echo "  sudo apt-get install ${missing_tools[*]}" ;;
    "dnf") echo "  sudo dnf install ${missing_tools[*]}" ;;
    "yum") echo "  sudo yum install ${missing_tools[*]}" ;;
    "pacman") echo "  sudo pacman -S ${missing_tools[*]}" ;;
    *) echo "  Please install manually: ${missing_tools[*]}" ;;
    esac
  fi

  if [ -n "$missing_pip_installer" ]; then
    echo "Missing pip3 installer:"
    echo "  $missing_pip_installer"
  fi

  if [ ${#missing_python_deps[@]} -gt 0 ]; then
    echo "Missing Python dependencies (run these commands):"
    for dep in "${missing_python_deps[@]}"; do
      echo "  $dep"
    done
  fi

  if [ ${#missing_git_repos[@]} -gt 0 ]; then
    echo "Missing Git repositories (run these commands):"
    for repo in "${missing_git_repos[@]}"; do
      echo "  $repo"
    done
  fi

  echo ""
  read -p "Do you want to attempt to install the missing system packages now? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    if [ ${#missing_tools[@]} -gt 0 ]; then
      echo "Attempting to install system packages..."
      case "$pkg_manager" in
      "brew") brew install "${missing_tools[@]}" ;;
      "apt") sudo apt-get install -y "${missing_tools[@]}" ;;
      "dnf") sudo dnf install -y "${missing_tools[@]}" ;;
      "yum") sudo yum install -y "${missing_tools[@]}" ;;
      "pacman") sudo pacman -S --noconfirm "${missing_tools[@]}" ;;
      *) echo "Cannot automatically install system packages on this OS. Please install manually." ;;
      esac
    fi
    echo "Please manually run any suggested pip/pipx or git clone commands."
    echo "After manual installations, open a NEW terminal session to apply changes."
  else
    echo "Skipping automatic system package installation. Please install manually and open a new terminal session."
  fi
}

# Call the function to check and offer to install missing tools on startup
install_missing_tools

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
