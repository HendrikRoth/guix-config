#!/bin/sh

sudo dnf -y install \
	@development-tools \
	alacritty \
	bat \
	bluez \
	bspwm \
	chromium \
	curl \
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
  isync \
	maildir-utils \
	mesa-dri-drivers \
	neovim \
	nnn \
	p7zip \
	playerctl \
	ripgrep \
	sxhkd \
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
  direnv \
  dunst \
  google-noto-sans-fonts \
  google-roboto-fonts \
  pass \
  polybar \
  scrot \
  udiskie

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
git clone https://github.com/edwardtufte/et-book tmp
mkdir -p ~/.fonts
cp -r tmp/et-book-ligatures-enabled/**/*.{otf,woff,woff2} ~/.fonts
rm -rf tmp
fc-cache -f

sudo pip install pywal
