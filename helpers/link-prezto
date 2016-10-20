#!/bin/zsh

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  target="${ZDOTDIR:-$HOME}/.${rcfile:t}"       # create $target that is a dotted version of $rcfile

  if [[ $target -ef $rcfile ]]; then            # $target is already a symlink to $rcfile
    continue                                    #

  elif [[ -L $target ]]; then                   # $target is a symlink to unknown file
    rm -f $target                               # it is safe enough. the file this symlink points to
                                                # should be floating around somewhere

  elif [[ -f $target ]]; then                   # $target is a regular file
    backup="${target:t:s/./_}-$(date '+%F-%T')" # $backup = $target -> tail -> s/./_ -> append date
    echo "Backing up ${target:t} to $backup"
    mv $target ${target:h}/$backup
  fi

  ln -s $rcfile $target
done
