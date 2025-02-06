if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cargo
set -x PATH /home/mg/.cargo/bin $PATH

# Alias

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

set -gx MESA_GL_VERSION_OVERRIDE 4.5
set -gx MESA_GLSL_VERSION_OVERRIDE 450

starship init fish | source
