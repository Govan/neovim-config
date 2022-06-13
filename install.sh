set -e
mkdir -p ~/.config/
mkdir -p ~/.vimswap/
rm -rf ~/.config/nvim
ln -s $PWD/files/config/nvim ~/.config/nvim

unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
  brew install the_silver_searcher
  brew install cmake
  brew install python3
  pip3 install neovim --upgrade
else # If it's me then I'm on ubuntu
  sudo apt-get update
  sudo apt-get -y install silversearcher-ag
  sudo apt-get -y install cmake
  sudo apt-get -y install python3
  sudo apt install -y python3-pip
  pip3 install neovim --upgrade
fi

touch ~/.vimrc_local

echo "Installing vim-plug: https://github.com/junegunn/vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim "+PlugInstall"
