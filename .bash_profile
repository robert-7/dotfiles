# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

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
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Golang Vars path
export GOPATH="/root/go"
export GOPRIVATE="*.indexexchange.com"
export GOPROXY="http://nexus3.indexexchange.com/repository/go-mod-group,https://proxy.golang.org,direct"
export GOSUMDB="off"
export GO111MODULE="auto"
export PATH="/usr/local/go/bin:${GOPATH}/bin:$PATH"

# Perl variables
export PERL5LIB="${GOPATH}/src/gitlab.indexexchange.com/platform-dev/APP/lib:$PERL5LIB"
export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/root/perl5"
export PERL_MB_OPT="--install_base /root/perl5"
export PERL_MM_OPT="INSTALL_BASE=/root/perl5"
export PERL5LIB="/root/perl5/lib/perl5:$PERL5LIB"
export PATH="/root/perl5/bin:$PATH"

export HISTTIMEFORMAT="%d/%m/%y %T "

# fuck
# eval $(thefuck --alias fuck)

