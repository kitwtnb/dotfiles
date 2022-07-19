# install Homebrew
if !(type brew > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update

# install package manager
brew install cask
brew install mas
brew install mint

# install CLI Apps
brew install java11
brew install go
brew install volta
brew install rbenv
brew install ghq
brew install hub
brew install peco
brew install zsh-completions
brew install jq

go install github.com/cuonglm/gogi/cmd/gogi@latest

# install GUI Apps
brew install 1password
brew install alfred
brew install bettertouchtool
brew install google-drive
brew install google-chrome
brew install atok
brew install inkdrop
brew install iterm2
brew install jetbrains-toolbox
brew install karabiner-elements
brew install gitkraken
brew install charles
brew install discord
brew install slack
brew install microsoft-teams
brew install --cask dash
brew tap sakebook/tap && brew install pbssc
mas install 417375580 # BetterSnapTool
mas install 1176895641 # Spark
mas install 539883307 # LINE
mas install 937984704 # Amphetamine
mas install 1384080005 # Tweetbot
mas install 435410196 # Stay
mas install 499768540 # Power JSON Editor

# install dot files
cp -f ./.gitconfig ~/
ghq get kitwtnb/dotfiles

ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.gitignore_global $HOME/.gitignore_global
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.iterm2 $HOME/.iterm2
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/bin $HOME/bin
cp -r ./.config ~/.config
