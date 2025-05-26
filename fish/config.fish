#╭──────────────────────────────────────────────────────────────────────────────────╮
#│                                                                                  │ 
#│  ███████╗██╗███████╗██╗  ██╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗   │
#│  ██╔════╝██║██╔════╝██║  ██║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝   │
#│  █████╗  ██║███████╗███████║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗  │
#│  ██╔══╝  ██║╚════██║██╔══██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║  │
#│  ██║     ██║███████║██║  ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝  │
#│  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝   │
#│                                                                                  │
#│                            🐠 Fish Shell Configuration 🐠                        │
#│                         ⚡ Fast, Beautiful, and Powerful⚡                       │
#│                                                                                  │
#╰──────────────────────────────────────────────────────────────────────────────────╯

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚙️   P R E - L O A D   S E T U P                                          │
# └────────────────────────────────────────────────────────────────────────────┘
# Create necessary directories if they don't exist
# Fish uses `test -d` for directory existence checks
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/fish/plugins # New directory for Fish-specific plugins
mkdir -p ~/.config # For Starship, FZF, zsh_codex, Navi, tldr config files

# Function to detect OS and package manager
function _get_pkg_manager
    if test (uname) = Darwin
        echo brew
    else if type -q apt-get
        echo apt
    else if type -q dnf
        echo dnf
    else if type -q yum
        echo yum
    else if type -q pacman
        echo pacman
    else
        echo unknown
    end
end

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🚀  P R O M P T   S E T U P                                              │
# └────────────────────────────────────────────────────────────────────────────┘
# ╭─────────────────────────────────────────╮
# │            🌟 Starship 🌟               │
# ╰─────────────────────────────────────────╯
# Initialize Starship prompt for a beautiful and highly customizable prompt.
# Starship is cross-shell compatible.
# Customize your Starship prompt by editing ~/.config/starship.toml
if type -q starship
    starship init fish | source
    # echo "🚀 Starship prompt loaded" # Silenced for less verbose startup
else
    echo "⚠️  Starship not found. Run 'install_missing_tools' to get installation instructions."
end

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🔌  E S S E N T I A L   P L U G I N S & T O O L S                        │
# └────────────────────────────────────────────────────────────────────────────┘
# Fish has excellent built-in features for syntax highlighting and autosuggestions.
# No separate plugins are needed for these core functionalities.
# echo "🎨 Fish's built-in syntax highlighting & autosuggestions enabled." # Silenced

# ╭─────────────────────────────────────────╮
# │           🔍 Search & Navigation        │
# ╰─────────────────────────────────────────╯
# FZF (Fuzzy Finder) - Core setup
if type -q fzf
    # Source FZF's core integration first. This sets up key bindings and functions.
    fzf --fish | source
    # echo "🔍 FZF Fish integration loaded" # Silenced

    # Now that FZF is loaded, set its options.
    set -gx FZF_DEFAULT_OPTS "
        --height=25%
        --layout=reverse
        --border=rounded
        --margin=1
        --padding=1
        --color=fg:#D8DEE9,bg:#2E3440,hl:#88C0D0
        --color=fg+:#ECEFF4,bg+:#3B4252,hl+:#88C0D0
        --color=info:#A3BE8C,prompt:#EBCB8B,pointer:#BF616A
        --color=marker:#BF616A,spinner:#A3BE8C,header:#4C564A
    "
    if type -q fd
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    else
        echo "⚠️  'fd' (find-d) not found. FZF's default command will fall back to 'find'. Run 'install_missing_tools' for installation instructions."
    end
    # echo "🔍 FZF configured with custom theme and reduced height" # Silenced
else
    echo "⚠️  FZF not found. Run 'install_missing_tools' for installation instructions."
end

# Forgit (Git utilities with FZF)
# Forgit has a dedicated Fish plugin, now expected in ~/.config/fish/plugins/
if test -f ~/.config/fish/plugins/forgit/forgit.plugin.fish # Check if manually cloned
    source ~/.config/fish/plugins/forgit/forgit.plugin.fish
    # echo "🌳 Forgit loaded from ~/.config/fish/plugins" # Silenced
else if type -q forgit # Check if installed via Fisher or another package
    # If using Fisher (Fish plugin manager), install with: fisher install forgit/forgit
    # echo "🌳 Forgit (via system path or Fisher) loaded" # Silenced
else
    echo "⚠️  Forgit not found. Run 'install_missing_tools' for installation instructions."
    echo "   (Consider installing via Fisher: fisher install forgit/forgit)"
end

# Navi (Interactive cheatsheet tool)
if type -q navi
    navi widget fish | source
    # echo "📚 Navi cheatsheet loaded" # Silenced
else
    echo "⚠️  Navi not found. Run 'install_missing_tools' to get installation instructions."
end

# ╭─────────────────────────────────────────╮
# │            ⚡ Productivity Tools        │
# ╰─────────────────────────────────────────╯
# Zoxide (Smart directory jumping)
if type -q zoxide
    zoxide init fish | source
    # echo "🚀 Zoxide smart directory jumping enabled" # Silenced
else
    echo "⚠️  Zoxide not found. Run 'install_missing_tools' to get installation instructions."
end

# tldr (Simplified man pages)
if type -q tldr
    # echo "📖 tldr quick help loaded" # Silenced
else
    echo "⚠️  tldr not found. Run 'install_missing_tools' to get installation instructions."
end

# ╭─────────────────────────────────────────╮
# │            🧠 AI-like Tools             │
# ╰─────────────────────────────────────────╯
# Zsh_Codex (AI-powered command completion) - Has Fish support!
# Install: git clone https://github.com/tom-doerr/zsh_codex.git ~/.config/fish/plugins/zsh_codex
# You will need to set up your API key in ~/.config/zsh_codex.ini after installation.
# Refer to https://github.com/tom-doerr/zsh_codex for detailed setup instructions.
# IMPORTANT: zsh_codex for Fish works differently. It's usually called as a function.
if test -f ~/.config/fish/plugins/zsh_codex/zsh_codex.plugin.fish
    source ~/.config/fish/plugins/zsh_codex/zsh_codex.plugin.fish
    # echo "🧠 AI-powered command completion loaded" # Silenced
    # Bind Ctrl+X to trigger AI completion
    # function fish_user_key_bindings
    #     bind \cx 'create_completion'
    # end
else if type -q zsh_codex_complete # Check if a function is sourced (e.g., via Fisher)
    # echo "🧠 AI-powered command completion loaded (zsh_codex via Fisher/source)" # Silenced
else
    echo "⚠️  AI-powered command completion (zsh_codex) not found or not configured for Fish. Run 'install_missing_tools' for installation instructions."
end

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  🎯  A L I A S E S   &   F U N C T I O N S                                │
# └────────────────────────────────────────────────────────────────────────────┘
# Fish uses functions for aliases. These can be defined directly in config.fish
# or in separate files in ~/.config/fish/functions/ for better organization.

# ╭─────────────────────────────────────────╮
# │             📁 LSD Aliases              │
# ╰─────────────────────────────────────────╯
if type -q lsd
    alias ls 'lsd --color=always'
    alias ll 'lsd -l --color=always'
    alias la 'lsd -la --color=always'
    alias lt 'lsd --tree --color=always'
    alias l 'lsd --color=always'
    alias lla 'lsd -la --color=always'
    alias llt 'lsd -l --tree --color=always'
    alias lsa 'lsd -a --color=always'
else
    echo "⚠️  LSD not found. Run 'install_missing_tools' for installation instructions."
    alias ls 'ls --color=auto'
    alias ll 'ls -alF --color=auto'
    alias la 'ls -A --color=auto'
    alias l 'ls -CF --color=auto'
end

# ╭─────────────────────────────────────────╮
# │           ⚡ Quick Navigation           │
# ╰─────────────────────────────────────────╯
# Fish handles 'cd ~' and 'cd -' natively.
function cdup2
    cd ../..
end
function cdup3
    cd ../../..
end
function cdup4
    cd ../../../..
end
function cdup5
    cd ../../../../..
end

# ╭─────────────────────────────────────────╮
# │            🔧 System Shortcuts          │
# ╰─────────────────────────────────────────╯
alias c clear
alias h history
alias j 'jobs -l'
# Reload function for fish
function reload
    source ~/.config/fish/config.fish
    echo "🔄 Fish configuration reloaded!"
end
alias fishconfig 'nvim ~/.config/fish/config.fish' # Assuming nvim is your editor

# ╭─────────────────────────────────────────╮
# │           📝 Editor Shortcuts           │
# ╰─────────────────────────────────────────╯
alias vim nvim
alias vi nvim
alias v nvim
alias nano nvim # If you prefer nano, keep it. If you want it to open nvim, keep this.

# ╭─────────────────────────────────────────╮
# │            🐳 Docker Shortcuts          │
# ╰─────────────────────────────────────────╯
alias d docker
alias dc docker-compose # Or 'docker compose' for new CLI
alias dps 'docker ps'
alias dimg 'docker images'
alias dlog 'docker logs'
alias dexec 'docker exec -it'

# ╭─────────────────────────────────────────╮
# │           🔍 Search & Find              │
# ╰─────────────────────────────────────────╯
# Fish syntax for grep and ripgrep colors. Fish's auto-completion handles `--color=auto` well.
alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'
alias rg 'rg --color=auto'

# ╭─────────────────────────────────────────╮
# │            📊 System Info               │
# ╰─────────────────────────────────────────╯
alias df 'df -h'
alias du 'du -h'
alias free 'free -h'
alias top htop
alias ps 'ps auxf'

# ╭─────────────────────────────────────────╮
# │            🌐 Network Tools             │
# ╰─────────────────────────────────────────╯
alias ping 'ping -c 4'
alias myip 'curl -s ifconfig.me ; and echo' # Fish uses 'and' for logical AND
alias localip 'ip route get 1.1.1.1 | grep -oP "src \K\S+"'

# ┌────────────────────────────────────────────────────────────────────────────┐
# │  ⚙️   H I S T O R Y   C O N F I G U R A T I O N                            │
# └────────────────────────────────────────────────────────────────────────────┘
# Fish manages history well out of the box.
# History is saved to ~/.local/share/fish/fish_history
# It automatically ignores duplicates and commands starting with space.
# You can set history size if needed, but typically not required.
# set -g fish_history_max_entries 10000

# ┌────────────────────────────────────────────────────────────────────────────┐
# │           ⏱️  Helpful Functions         │
# └────────────────────────────────────────────────────────────────────────────┘
# Create directory and enter it
function mcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# Extract any archive
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Find file by name
function ff
    find . -name "*$argv[1]*" -type f
end

# Find directory by name
function fd
    find . -name "*$argv[1]*" -type d
end

# Function to install missing tools (adapted for Fish)
function install_missing_tools
    set -l pkg_manager (_get_pkg_manager)
    set -l missing_tools
    set -l missing_git_repos
    set -l missing_python_deps
    set -l missing_pip_installer ""
    set -l found_any_missing_issue false

    # Check for binaries
    if not type -q starship
        set missing_tools $missing_tools starship
        set found_any_missing_issue true
    end
    if not type -q lsd
        set missing_tools $missing_tools lsd
        set found_any_missing_issue true
    end
    if not type -q fzf
        set missing_tools $missing_tools fzf
        set found_any_missing_issue true
    end # FZF is a binary
    if not type -q fd
        set missing_tools $missing_tools fd
        set found_any_missing_issue true
    end
    if not type -q zoxide
        set missing_tools $missing_tools zoxide
        set found_any_missing_issue true
    end
    if not type -q navi
        set missing_tools $missing_tools navi
        set found_any_missing_issue true
    end
    if not type -q tldr
        set missing_tools $missing_tools tldr
        set found_any_missing_issue true
    end

    # Check for git-cloned plugins in their new Fish-specific location
    if not test -d ~/.config/fish/plugins/forgit
        set missing_git_repos $missing_git_repos "git clone https://github.com/wfxr/forgit.git ~/.config/fish/plugins/forgit"
        set found_any_missing_issue true
    end
    if not test -d ~/.config/fish/plugins/zsh_codex
        set missing_git_repos $missing_git_repos "git clone https://github.com/tom-doerr/zsh_codex.git ~/.config/fish/plugins/zsh_codex"
        set found_any_missing_issue true
    end

    # Check for zsh_codex Python dependencies and pip
    if type -q python3
        if not type -q pip3
            switch $pkg_manager
                case apt
                    set missing_pip_installer "sudo apt-get install python3-pip"
                case dnf
                    set missing_pip_installer "sudo dnf install python3-pip"
                case yum
                    set missing_pip_installer "sudo yum install python3-pip"
                case pacman
                    set missing_pip_installer "sudo pacman -S python-pip" # Note: pacman might use python-pip for python3
                case brew
                    set missing_pip_installer "brew install python" # Homebrew installs pip with python
                case "*"
                    set missing_pip_installer "Please install pip3 manually for python3."
            end
            echo "⚠️  pip3 not found for python3. Please install it first: $missing_pip_installer"
            set found_any_missing_issue true
        else # pip3 is available, check Python libraries
            if not python3 -c "import openai" >/dev/null 2>&1; or not python3 -c "import google.generativeai" >/dev/null 2>&1
                # For Arch (pacman), recommend pip3 install --user or pipx
                if test "$pkg_manager" = pacman
                    set missing_python_deps $missing_python_deps "pip3 install --user openai google-generativeai # Or use 'pipx install zsh_codex' if available"
                    echo "💡 On Arch Linux, consider using 'pipx install zsh_codex' if you want zsh_codex as a standalone app, or 'pip3 install --user openai google-generativeai' to avoid system package conflicts."
                else
                    set missing_python_deps $missing_python_deps "pip3 install openai google-generativeai"
                end
                set found_any_missing_issue true
            end
        end
    else
        echo "⚠️  Python3 not found. Cannot check/install zsh_codex Python dependencies."
        set found_any_missing_issue true
    end

    # Only print "Checking..." message if any issues were found
    if $found_any_missing_issue
        echo "Checking for missing tools and dependencies..."
        echo ----------------------------------------------------------------

        if test (count $missing_tools) -gt 0
            echo "Missing system packages (run these commands):"
            switch "$pkg_manager"
                case brew
                    echo "  brew install "$missing_tools
                case apt
                    echo "  sudo apt-get install "$missing_tools
                case dnf
                    echo "  sudo dnf install "$missing_tools
                case yum
                    echo "  sudo yum install "$missing_tools
                case pacman
                    echo "  sudo pacman -S "$missing_tools
                case "*"
                    echo "  Please install manually: "$missing_tools
            end
        end

        if test -n "$missing_pip_installer"
            echo "Missing pip3 installer:"
            echo "  $missing_pip_installer"
        end

        if test (count $missing_python_deps) -gt 0
            echo "Missing Python dependencies (run these commands):"
            for dep in $missing_python_deps
                echo "  $dep"
            end
        end

        if test (count $missing_git_repos) -gt 0
            echo "Missing Git repositories (run these commands):"
            for repo in $missing_git_repos
                echo "  $repo"
            end
        end

        echo ""
        read -P "Do you want to attempt to install the missing system packages now? (y/N): " confirm
        if test "$confirm" = y -o "$confirm" = Y
            if test (count $missing_tools) -gt 0
                echo "Attempting to install system packages..."
                switch "$pkg_manager"
                    case brew
                        brew install $missing_tools
                    case apt
                        sudo apt-get install -y $missing_tools
                    case dnf
                        sudo dnf install -y $missing_tools
                    case yum
                        sudo yum install -y $missing_tools
                    case pacman
                        sudo pacman -S --noconfirm $missing_tools
                    case "*"
                        echo "Cannot automatically install system packages on this OS. Please install manually."
                end
            end
            echo "Please manually run any suggested pip/pipx or git clone commands."
            echo "After manual installations, open a NEW terminal session to apply changes."
        else
            echo "Skipping automatic system package installation. Please install manually and open a new terminal session."
        end
    else
        echo "🎉 All required tools and dependencies are already installed!"
        return 0
    end
end

# Call the function to check and offer to install missing tools on startup
install_missing_tools

# ┌────────────────────────────────────────────────────────────────────────────┐
# │                        ✨ Configuration Complete! ✨                       │
# │                     Your Fish shell is supercharged! 🚀                    │
# │                                                                            │
# │  💡 Pro Tips:                                                              │
# │     • Fish has built-in autosuggestions and syntax highlighting            │
# │     • Use 'cd' with zoxide for smart directory jumping                     │
# │     • Press Ctrl+R for fuzzy history search                                │
# │     • Use 'lt' for tree view with lsd                                      │
# │     • Type 'reload' to refresh this config                                 │
# └────────────────────────────────────────────────────────────────────────────┘
