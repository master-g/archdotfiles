if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set up default user
set -x DEFAULT_USER mg

# Detect OS
set -gx os_type (uname -s)

# Proxy functions
function proxy --description "Enable proxy"
    set -x http_proxy socks5://127.0.0.1:1086
    set -x https_proxy socks5://127.0.0.1:1086
    set -x all_proxy socks5://127.0.0.1:1086
    set -x no_proxy socks5://127.0.0.1:1086
    set -x HTTP_PROXY socks5://127.0.0.1:1086
    set -x HTTPS_PROXY socks5://127.0.0.1:1086
    set -x ALL_PROXY socks5://127.0.0.1:1086
    set -x NO_PROXY socks5://127.0.0.1:1086
end

function unproxy --description "Disable proxy"
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy
    set -e no_proxy
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    set -e ALL_PROXY
    set -e NO_PROXY
end

# Initialize basic PATH
set -x PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin

# Cross-platform package manager setup
switch $os_type
    case Darwin
        # macOS - Homebrew
        set -l homebrew_paths /opt/homebrew /usr/local
        for brew_path in $homebrew_paths
            if test -d "$brew_path/bin"
                set -x PATH $brew_path/bin $PATH
            end
            if test -d "$brew_path/sbin"
                set -x PATH $brew_path/sbin $PATH
            end
        end

        if command -v brew >/dev/null
            brew shellenv | source
        end
    case Linux
        # Linux - check for common package managers
        # Usually system paths are already in PATH
        if test -d /usr/local/bin
            set -x PATH /usr/local/bin $PATH
        end
end

# Cargo (cross-platform)
if test -d "$HOME/.cargo/bin"
    set -x PATH $HOME/.cargo/bin $PATH
end

# Language settings
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x TERM xterm-256color

# Cross-platform development tools setup

# Android development
set -gx android_possible_paths
switch $os_type
    case Darwin
        set android_possible_paths "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"
    case Linux
        set android_possible_paths "$HOME/Android/Sdk" "$HOME/.android/sdk" /opt/android-sdk
end

for android_path in $android_possible_paths
    if test -d "$android_path"
        set -x ANDROID_HOME $android_path
        set -x PATH $android_path $PATH
        if test -d "$android_path/platform-tools"
            set -x PATH $android_path/platform-tools $PATH
        end
        if test -d "$android_path/ndk-bundle"
            set -x PATH $android_path/ndk-bundle $PATH
        end
        break
    end
end

# Java development
set -l java_possible_paths
switch $os_type
    case Darwin
        set java_possible_paths "$HOME/Library/Java/JavaVirtualMachines/corretto-17.0.13/Contents/Home" /usr/libexec/java_home
    case Linux
        set java_possible_paths /usr/lib/jvm/default /usr/lib/jvm/java-17-openjdk /usr/lib/jvm/java-11-openjdk
end

for java_path in $java_possible_paths
    if test -d "$java_path"
        set -x JAVA_HOME $java_path
        break
    end
end

# Flutter development
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn

set -l flutter_possible_paths
switch $os_type
    case Darwin
        set flutter_possible_paths "$HOME/Library/flutter" "$HOME/flutter" /usr/local/flutter
    case Linux
        set flutter_possible_paths "$HOME/flutter" /opt/flutter "$HOME/.local/share/flutter"
end

for flutter_path in $flutter_possible_paths
    if test -d "$flutter_path/bin"
        set -x FLUTTER_ROOT $flutter_path
        set -x PATH $PATH $flutter_path/bin
        break
    end
end

# Python development
set -l python_user_paths
switch $os_type
    case Darwin
        set python_user_paths "$HOME/Library/Python/3.11/bin" "$HOME/Library/Python/3.12/bin"
    case Linux
        set python_user_paths "$HOME/.local/bin"
end

for py_path in $python_user_paths
    if test -d "$py_path"
        set -x PATH $py_path $PATH
    end
end

# Go development
if test -d "$HOME/go/bin"
    set -x PATH $HOME/go/bin $PATH
end

# Rust development
set -x RUSTUP_DIST_SERVER https://rsproxy.cn
set -x RUSTUP_UPDATE_ROOT https://rsproxy.cn/rustup
set -x CARGO_MOMMYS_LITTLE boy

# Node.js/pnpm setup
set -l pnpm_possible_paths
switch $os_type
    case Darwin
        set pnpm_possible_paths "$HOME/Library/pnpm" "$HOME/.local/share/pnpm"
    case Linux
        set pnpm_possible_paths "$HOME/.local/share/pnpm" "$HOME/.pnpm"
end

for pnpm_path in $pnpm_possible_paths
    if test -d "$pnpm_path"
        set -x PNPM_HOME $pnpm_path
        set -x PATH $PNPM_HOME $PATH
        break
    end
end

# JetBrains Toolbox
set -l jetbrains_possible_paths
switch $os_type
    case Darwin
        set jetbrains_possible_paths "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    case Linux
        set jetbrains_possible_paths "$HOME/.local/share/JetBrains/Toolbox/scripts"
end

for jb_path in $jetbrains_possible_paths
    if test -d "$jb_path"
        set -x PATH $PATH "$jb_path"
        break
    end
end

# Graphics settings (for VMs and specific setups)
set -gx MESA_GL_VERSION_OVERRIDE 4.5
set -gx MESA_GLSL_VERSION_OVERRIDE 450
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

# Aliases
function v --description "Alias v to nvim"
    nvim $argv
end

function vi --description "Alias vi to nvim"
    nvim $argv
end

function vv --description "Alias vv to neovide"
    neovide $argv
end

function vim --description "Alias vim to nvim"
    nvim $argv
end

function cat --description "Alias cat to bat"
    bat $argv
end

function ls --description "Alias ls to eza"
    eza $argv
end

function ll --description "list all files, metadata as table, human-readable"
    eza -alh --icons $argv
end

function lt --description="list all files, in tree"
    eza --tree $argv
end

function .. --description="cd .."
    cd .. $argv
end

function cd.. --description="cd .."
    cd .. $argv
end

function fh --description="find in current directory with name"
    find . -name $argv
end

function histg --description="grep history"
    history | grep $argv
end

function dush --description="disk usage"
    du -sh * $argv
end

function top --description="Alias top to btm"
    btm $argv
end

function png2webp --description="convert png in current directory to webp"
    find . -maxdepth 1 -type f -iname "*.png" -exec sh -c 'convert "$1" "${1%.png}.webp"' _ {} \; $argv
end

# Cross-platform network interface detection
function myip --description="print my ip address"
    switch $os_type
        case Darwin
            ifconfig en0 | grep 'inet ' | cut -d ' ' -f2
        case Linux
            # Try common interface names
            for iface in eth0 enp0s3 wlan0 wlp2s0
                if ifconfig $iface 2>/dev/null | grep -q 'inet '
                    ifconfig $iface | grep 'inet ' | awk '{print $2}' | head -1
                    return
                end
            end
            # Fallback to ip command
            if command -v ip >/dev/null
                ip route get 1.1.1.1 | grep -oP 'src \K\S+'
            end
    end
end

function myip6 --description="print my ip v6 address"
    switch $os_type
        case Darwin
            ifconfig en0 | grep 'inet6 ' | cut -d ' ' -f2
        case Linux
            for iface in eth0 enp0s3 wlan0 wlp2s0
                if ifconfig $iface 2>/dev/null | grep -q 'inet6 '
                    ifconfig $iface | grep 'inet6 ' | awk '{print $2}' | head -1
                    return
                end
            end
    end
end

# tmux functions
function mux --description="tmuxinator {profile}"
    tmuxinator $argv
end

function tk
    tmux kill-session -t 0 $argv
end

function ta
    tmux attach-session $argv
end

function tka
    tmux kill-session -t 0
    tmux attach-session $argv
end

set -x EDITOR vim
if test -s "~/.bin/tmuxinator.fish"
    source ~/.bin/tmuxinator.fish
end

# Open functions
function open
    command open . $argv
end

function o
    command open $argv
end

# Cross-platform package manager update
function bbb --description="Update packages"
    switch $os_type
        case Darwin
            if command -v brew >/dev/null
                brew update
                brew upgrade
                brew cleanup
            end
        case Linux
            # Try different package managers
            if command -v pacman >/dev/null
                sudo pacman -Syu
            else if command -v apt >/dev/null
                sudo apt update && sudo apt upgrade
            else if command -v dnf >/dev/null
                sudo dnf upgrade
            else if command -v zypper >/dev/null
                sudo zypper refresh && sudo zypper update
            end
    end
end

# Git functions
function gd
    git diff $argv
end

function gst
    git status $argv
end

function gcam
    git commit -a -m $argv
end

function gfp
    git -c diff.mnemonicprefix=false -c core.quotepath=false fetch --prune origin $argv
end

function gce
    gh copilot explain $argv
end

function gcs
    gh copilot suggest $argv
end

# fzf functions
function fff
    fzf --preview 'bat --style=numbers --color=always {}' $argv
end

function ffe
    set selected (fff $argv)
    if test -n "$selected"
        nvim $selected
    end
end

function fpk
    set process (ps aux | fzf --height=40% --border --preview 'echo {}')
    if test -n "$process"
        set pid (echo $process | awk '{print $2}')
        echo "killing process $pid ..."
        kill -9 $pid
    end
end

# Network utilities
function btc
    curl https://rate.sx/btc@24h
end

function weather
    curl v2.wttr.in/Shenzhen
end

# Cross-platform conda initialization
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set -l conda_paths
switch $os_type
    case Darwin
        set conda_paths \
            "$HOME/miniconda3" \
            "$HOME/anaconda3" \
            /opt/miniconda3 \
            /opt/anaconda3 \
            /usr/local/miniconda3 \
            /usr/local/anaconda3 \
            /opt/homebrew
    case Linux
        set conda_paths \
            "$HOME/miniconda3" \
            "$HOME/anaconda3" \
            /opt/miniconda3 \
            /opt/anaconda3 \
            /usr/local/miniconda3 \
            /usr/local/anaconda3
end

set -l found_conda_path ""
for path in $conda_paths
    if test -f "$path/bin/conda"
        set found_conda_path "$path"
        break
    end
end

if test -n "$found_conda_path"
    eval "$found_conda_path/bin/conda" "shell.fish" hook $argv | source

    if not functions -q conda
        if test -f "$found_conda_path/etc/fish/conf.d/conda.fish"
            source "$found_conda_path/etc/fish/conf.d/conda.fish"
        else
            set -gx PATH "$found_conda_path/bin" $PATH
        end
    end
end

set -gx TERMINFO /usr/share/terminfo

# Initialize external tools if available
if command -v zoxide >/dev/null
    zoxide init fish | source
end

if command -v starship >/dev/null
    starship init fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
