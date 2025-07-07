if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cargo
set -x PATH /home/mg/.cargo/bin $PATH

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

function fh
	find . -name $argv
end

function histg
	history | grep $argv
end

function top
	btm $argv
end

# tmux

function mux
    tmuxinator $argv
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
    set selected (fff)
    if test -n "$selected"
        nvim "$selected"
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
  "/usr/local/anaconda3"

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

# make it work in UTM vm
set -gx MESA_GL_VERSION_OVERRIDE 4.5
set -gx MESA_GLSL_VERSION_OVERRIDE 450

# electron stuff
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

# zoxide
zoxide init fish | source

# starship
starship init fish | source

