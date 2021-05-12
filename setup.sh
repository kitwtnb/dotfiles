# install Homebrew
if !(type brew > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

# install package manager
brew install cask
brew install mas

# install CLI Apps
brew install carthage
brew install ghq
brew install hub
brew install node
brew install peco
brew install swiftformat
brew install swiftlint
brew install yarn
brew install zsh-completions
gem install cocoapods

# install GUI Apps
brew cask install alfred
brew cask install bettertouchtool
brew cask install gitkraken
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install inkdrop
brew cask install iterm2
brew cask install jetbrains-toolbox
brew cask install karabiner-elements
brew cask install visual-studio-code
brew cask install fork
brew cask install charles
brew cask install discord
brew cask install microsoft-teams
mas install 1333542190 # 1Password
mas install 417375580 # BetterSnapTool
mas install 497799835 # Xcode
mas install 1176895641 # Spark
mas install 539883307 # LINE
mas install 1348617240 # FirstSeed Calendar
mas install 803453959 # Slack
mas install 1384080005 # Tweetbot

# install dot files
cp -f ./.gitconfig ~/
ghq get kitwtnb/dotfiles

ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.gitignore_global $HOME/.gitignore_global
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.iterm2 $HOME/.iterm2
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/repository/github.com/kitwtnb/dotfiles/bin $HOME/bin
cp -r ./.config ~/.config
