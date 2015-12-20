RBENV=$HOME/.rbenv
PLUGINS=$RBENV/plugins

# install rbenv
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv

mkdir -p $PLUGINS

# install plugins
git clone https://github.com/sstephenson/ruby-build.git $PLUGINS/ruby-build
git clone git://github.com/tpope/rbenv-ctags.git $PLUGINS/rbenv-ctags
git clone https://github.com/rkh/rbenv-update.git $PLUGINS/rbenv-update
git clone https://github.com/ianheggie/rbenv-binstubs.git $PLUGINS/rbenv-binstubs
