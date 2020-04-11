user=$1
HOME="/home/$user"

apt update
apt upgrade

apt install -y curl \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    htop

# set up zsh and ohmyzsh
apt install -y zsh 
chsh -s $(which zsh) $user
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp configs/zshrc "$HOME/.zshrc"
mkdir -p $HOME/code $HOME/bin

# set up java
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
sdk install gradle
sdk install kotlin
sdk current java

# set up docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update 
apt install -y docker-ce docker-ce-cli containerd.io
docker run hello-world

echo "Install successful"
apt list --installed
