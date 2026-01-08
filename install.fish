#!/usr/bin/fish

# Install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Install fish plugins
fisher install hauleth/agnoster

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fisher install FabioAntunes/fish-nvm edc/bass

