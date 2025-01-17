# ==========================
# Zinit Setup
# ==========================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Check if Zinit is installed, if not, install it.
if ! command -v zinit &> /dev/null; then
  [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
  [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Initialize Zinit
source "$ZINIT_HOME/zinit.zsh"

# ==========================
# Plugin Management
# ==========================

# Core plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Oh My Zsh Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::kitty
#zinit snippet OMZP::tmux
zinit snippet OMZP::zoxide

# ==========================
# Completion System
# ==========================
autoload -U compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf—tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ==========================
# Shell Integrations
# ==========================
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# ==========================
# Handy Aliases
# ==========================
# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Directory listing with eza
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree

# Other handy aliases
alias mkdir='mkdir -p'
alias c='clear' # clear terminal
alias vc='code' # GUI code editor
alias nvim='nvim'
alias kth='kitty-theme'
alias doom-zig='cd terminal-doom/ && zig-out/bin/terminal-doom'
alias fast='fastfetch'

# Clean temp stuff
alias cl_system='sudo pacman -Scc --noconfirm && yay -Sc --noconfirm && sudo rm -rf /tmp/*'
alias cl_packages='sudo pacman -Rns $(pacman -Qtdq) --noconfirm'
alias cl_clipboard='rm -rf ~/.cache/cliphist/*'


# ==========================
# Package Management
# ==========================
# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null ; then
            arch+=("${pkg}")
        else 
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages

# ==========================
# History Management
# ==========================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# ==========================
# Handle Command Not Found
# ==========================
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}


zle -N zellij-sessionizer
bindkey -M viins '^F' zellij-sessionizer


# Functions
detect_virtualenv() {
  if [[ -z "$VIRTUAL_ENV" ]] ; then
    # If env folder is found, activate the virtualenv
    if [[ -d ./venv ]] ; then
      source ./venv/bin/activate
    elif [[ -d ./.venv ]] ; then
      source ./.venv/bin/activate
    fi
  else
    # Check if the current folder belongs to the earlier VIRTUAL_ENV folder
    # If not, deactivate the virtual environment
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
    fi
  fi
}


# Run Python virtualenv detection script
autoload -U add-zsh-hook
add-zsh-hook chpwd detect_virtualenv

# ==========================
# Final Touches
# ==========================
fastfetch --colors-block-range-start 9 --colors-block-width 3

export PATH=$HOME/.local/bin:$PATH

export BUN_INSTALL="/home/nivaz/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

