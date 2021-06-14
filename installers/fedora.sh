#!/bin/sh

sudo dnf -y install \
  xrandr \
	git \
	@development-tools \
	bluez \
	p7zip \
	unzip \
	curl \
	wget \
	xz \
	vim \
	emacs \
	sxhkd \
	bspwm \
	dmenu \
	xorg-x11-server-Xorg \
	xorg-x11-font-utils \
	xorg-x11-xinit \
	xorg-x11-drv-* \
	mesa-dri-drivers \
	alacritty \
	chromium \
	firefox \
	fontconfig \
	maildir-utils \
	fzf \
	zsh \
	texlive-scheme-full \
	fira-code-fonts \
	inkscape \
	gimp \
	playerctl \
	dnf-plugins-core

# Docker
sudo dnf config-manager \
	--add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf -y install \
	docker-ce \
	docker-ce-cli \
	containerd.io

# Guix
sudo dnf config-manager \
	--add-repo https://copr.fedorainfracloud.org/coprs/lantw44/guix/repo/fedora-34/lantw44-guix-fedora-34.repo

sudo dnf -y install guix

# Services
sudo systemctl enable dbus-broker
sudo systemctl enable docker
sudo systemctl enable bluetooth
sudo systemctl enable guix-daemon

sudo systemctl start dbus-broker
sudo systemctl start docker
sudo systemctl start bluetooth
sudo systemctl start guix-daemon

# Groups
sudo gpasswd -a `whoami` guixbuild

# Fonts
git clone https://github.com/edwardtufte/et-book tmp
mkdir -p ~/.fonts
cp -r tmp/et-book-ligatures-enabled/**/*.{otf,woff,woff2} ~/.fonts
rm -rf tmp

pip install pywal
