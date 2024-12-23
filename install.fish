#!/bin/fish

if ! test -d $HOME/.dotbackup
    git clone https://github.com/linhtutkyawdev/.dotbackup.git $HOME/.dotbackup
end
if type -q dotbackup
    echo "dotbackup already sourced!"
else 
    echo source $HOME/.dotbackup/dotbackup.fish >> $HOME/.config/fish/config.fish
    source $HOME/.config/fish/config.fish
    echo "Successfully installed dotbackup!"
end