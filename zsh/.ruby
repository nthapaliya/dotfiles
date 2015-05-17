export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if which ruby >/dev/null && which gem >/dev/null; then
	    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
