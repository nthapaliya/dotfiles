rbenv_root="${RBENV_ROOT:-$HOME/.rbenv}"
plugins_dir="$rbenv_root/plugins"

# install rbenv
git clone https://github.com/sstephenson/rbenv.git "$rbenv_root"

mkdir -p "$plugins_dir"

# install plugins
git clone https://github.com/sstephenson/ruby-build.git "$plugins_dir/ruby-build"
git clone git://github.com/tpope/rbenv-ctags.git "$plugins_dir/rbenv-ctags"
git clone https://github.com/rkh/rbenv-update.git "$plugins_dir/rbenv-update"
git clone https://github.com/ianheggie/rbenv-binstubs.git "$plugins_dir/rbenv-binstubs"
