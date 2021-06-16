#!/bin/sh

XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p "${XDG_CONFIG_HOME}"

sudo dnf -y install \
	@development-tools \
	alacritty \
	bat \
	bluez \
	bspwm \
	chromium \
	curl \
  feh \
  ImageMagick \
	dmenu \
	dnf-plugins-core \
	emacs \
	exa \
	fira-code-fonts \
	firefox \
	fontconfig \
	fzf \
	gimp \
	git \
	inkscape \
	maildir-utils \
	mesa-dri-drivers \
	neovim \
	nnn \
	p7zip \
	playerctl \
  pulseaudio-utils \
	ripgrep \
	sxhkd \
  syncthing \
  syncthing-cli \
	texlive-scheme-medium \
	unzip \
	wget \
	xorg-x11-drv-* \
	xorg-x11-font-utils \
	xorg-x11-server-Xorg \
	xorg-x11-xinit \
	xrandr \
	xz \
	zsh \
  cmake \
  direnv \
  dunst \
  gcc-c++ \
  gmime30 \
  gmime30-devel \
  google-noto-sans-fonts \
  google-roboto-fonts \
  isync \
  pass \
  polybar \
  maim \
  udiskie \
  xapian-bindings \
  xapian-core \
  xapian-core-devel \
  xsecurelock \
  xss-lock \
  xbacklight \
  xset \
  xsetroot \
  xrdb \
  zathura

# Docker
sudo dnf config-manager \
	--add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf -y install \
	containerd.io \
	docker-ce \
	docker-ce-cli

# Guix
sudo dnf config-manager \
	--add-repo https://copr.fedorainfracloud.org/coprs/lantw44/guix/repo/fedora-34/lantw44-guix-fedora-34.repo

sudo dnf -y install guix

# Services
sudo systemctl enable bluetooth
sudo systemctl enable dbus-broker
sudo systemctl enable docker
sudo systemctl enable guix-daemon

sudo systemctl start bluetooth
sudo systemctl start dbus-broker
sudo systemctl start docker
sudo systemctl start guix-daemon

# Groups
sudo gpasswd -a `whoami` guixbuild

# Default zsh shell
sudo usermod -s /bin/zsh `whoami`

# Fonts
git clone --depth=1 https://github.com/edwardtufte/et-book tmp \
    && mkdir -p ~/.fonts \
    && cp -r tmp/et-book-ligatures-enabled/**/*.{otf,woff,woff2} ~/.fonts \
    && rm -rf tmp \
    && fc-cache -f

# Color theme tool
sudo pip install pywal
sudo pip install "git+http://github.com/phillipberndt/autorandr#egg=autorandr"

# Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# nvm
NVM_DIR="${XDG_CONFIG_HOME}/nvm"
if [ ! -d $NVM_DIR ]; then
    git clone --depth=1 https://github.com/nvm-sh/nvm $NVM_DIR
    bash "${NVM_DIR}/nvm.sh"
fi

# wallpaper
mkdir -p ~/.config/scripts
rm ~/.config/scripts/wallpaper_file
ln -s "$(pwd)/wallpapers/japanes-waves.svg" ~/.config/scripts/wallpaper_file
