if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set up default user
set -x DEFAULT_USER mg

# Proxy
function proxy
	set -x http_proxy socks5://127.0.0.1:1086
	set -x https_proxy socks5://127.0.0.1:1086
	set -x all_proxy socks5://127.0.0.1:1086
	set -x no_proxy socks5://127.0.0.1:1086
	set -x HTTP_PROXY socks5://127.0.0.1:1086
	set -x HTTPS_PROXY socks5://127.0.0.1:1086
	set -x ALL_PROXY socks5://127.0.0.1:1086
	set -x NO_PROXY socks5://127.0.0.1:1086
end

# Unproxy
function unproxy
	set -e http_proxy
	set -e https_proxy
	set -e all_proxy
	set -e no_proxy
	set -e HTTP_PROXY
	set -e HTTPS_PROXY
	set -e ALL_PROXY
	set -e NO_PROXY
end

# init path
set -x PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /opt/homebrew/sbin $PATH
# set -x LIBRARY_PATH $LIBRARY_PATH (brew --prefix)/lib

# Cargo
set -x PATH $HOME/.cargo/bin $PATH

# Lang
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# Term
set -x TERM xterm-256color

# Android dev
set -x PATH $HOME/Library/Android/sdk $PATH
set -x PATH $HOME/Library/Android/sdk/ndk-bundle $PATH
set -x PATH $HOME/Library/Android/sdk/platform-tools $PATH
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x JAVA_HOME $HOME/Library/Java/JavaVirtualMachines/corretto-17.0.13/Contents/Home

# Flutter dev
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn

# Flutter root
set -x FLUTTER_ROOT $HOME/Library/flutter
set -x PATH $PATH $FLUTTER_ROOT/bin

# Python dev
# set -x VIRTUALENVWRAPPER_PYTHON /usr/local/anaconda3/bin/python3
set -x PATH $Home/Library/Python/3.11/bin $PATH
set -x PATH $HOME/.local/bin $PATH

# Go dev
set -x PATH $HOME/go/bin $PATH

# Rust dev
set -x RUSTUP_DIST_SERVER https://rsproxy.cn
set -x RUSTUP_UPDATE_ROOT https://rsproxy.cn/rustup
set -x CARGO_MOMMYS_LITTLE boy


# Alias

function vi
	nvim $argv
end

function vim
	nvim $argv
end

function cat
	bat $argv
end

function ls
	lsd $argv
end

function ll
	lsd -alh $argv
end

function lt
	ls --tree $argv
end

function ..
  cd .. $argv
end

function cd..
  cd .. $argv
end

function fh
	find . -name $argv
end

function histg
	history | grep $argv
end

function dush
  du -sh * $argv
end

function top
	btm $argv
end

function png2webp
  find . -maxdepth 1 -type f -iname "*.png" -exec sh -c 'convert "$1" "${1%.png}.webp"' _ {} \; $argv
end

function myip
  ifconfig en0 | grep 'inet ' | cut -d ' ' -f2
end

function myip6
  ifconfig en0 | grep 'inet6 ' | cut -d ' ' -f2
end

# tmux

function mux
    tmuxinator $argv
end

function tk
  tmux kill-session -t 0 $argv
end

function ta
  tmux attach-session $argv
end

function tka
  tmux kill-session -t 0; tmux attach-session $argv
end

set -x EDITOR vim
if test -s "~/.bin/tmuxinator.fish"
	source ~/.bin/tmuxinator.fish
end

# Open

function open
  command open . $argv
end

function o
  command open $argv
end

# Brew

function bbb
  brew update
  brew upgrade
  brew cleanup
end

if command -v brew > /dev/null
  brew shellenv | source
end

# git

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

# fzf
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set -l conda_paths \
  "$HOME/miniconda3" \
  "$HOME/anaconda3" \
  "/opt/miniconda3" \
  "/opt/anaconda3" \
  "/usr/local/miniconda3" \
  "/usr/local/anaconda3" \
  "/opt/homebrew"

set -l found_conda_path
for path in $conda_paths
  if test -f "$path/bin/conda"
    set found_conda_path "$path"
    break
  end
end

if set -q found_conda_path
    eval "$found_conda_path/bin/conda" "shell.fish" "hook" $argv | source

    if not functions -q conda
      if test -f "$found_conda_path/etc/fish/conf.d/conda.fish"
        source "$found_conda_path/etc/fish/conf.d/conda.fish"
      else
        set -gx PATH "$found_conda_path/bin" $PATH
      end
    end
else
  echo "Conda not found in common locations. If installed elsewhere, add to PATH manually."
end
set -gx TERMINFO /usr/share/terminfo
# <<< conda initialize <<<

# pnpm
set -x PNPM_HOME $HOME/Library/pnpm
set -x PATH $PNPM_HOME $PATH

# Toolbox App
set -x PATH $PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# make it work in UTM vm
set -gx MESA_GL_VERSION_OVERRIDE 4.5
set -gx MESA_GLSL_VERSION_OVERRIDE 450

# electron stuff
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

# zoxide
zoxide init fish | source

# starship
starship init fish | source

