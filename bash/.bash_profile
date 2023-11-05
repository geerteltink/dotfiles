# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$HOME/.dotfiles/bin:$PATH";

# Go
[ -d "/usr/local/go/bin" ] && export PATH=$PATH:/usr/local/go/bin

# Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Load nvm
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

# Load the shell dotfiles, and then some:
# * ~/.bash_extra can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/bash/system/{.prompt,.exports,.aliases,.completion,z.sh}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Store local export variables in .bash_env
if [ -d "$HOME/.bash_env" ]; then
  [ -n "$PS1" ] && source "$HOME/.bash_env";
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2>/dev/null;
done;
