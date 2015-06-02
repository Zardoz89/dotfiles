# Some enviroment variables
set -x GTEST_ROOT /usr/src/gtest/
# private stuff
set -x CHANGELOG_GITHUB_TOKEN (cat ~/.config/fish/CHANGELOG_GITHUB_TOKEN)

# Alias                                                                                                           
# Open neovim on a Konsole window                                                                                 
alias kvim="konsole --profile nvim -e nvim" 
