#!/usr/bin/fish

# Install fisher
if ! type -q fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end
# Install fish plugins
fisher install hauleth/agnoster

# Install nvm for fish
fisher install FabioAntunes/fish-nvm edc/bass

