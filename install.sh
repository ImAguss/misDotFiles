#!/bin/bash

# Salir si un comando falla
set -e

echo "🚀 Iniciando instalación de Hyprland (Base Edition)..."

# 1. Sistema base y dependencias
echo "📦 Actualizando el sistema..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git

# 2. Instalación de YAY
if ! command -v yay &>/dev/null; then
  echo "🛠️ Instalando yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  rm -rf /tmp/yay
else
  echo "✅ yay ya está instalado."
fi

# 3. Paquetes Core (Hyprland, SDDM, Terminal, Audio, etc.)
CORE_PKGS=(
  hyprland
  fastfetch
  brightnessctl
  gvfs
  network-manager-applet
  pavucontrol
  7zip
  tar
  git
  qt5-wayland
  qt6-wayland
  uwsm
  xdg-desktop-portal-hyprland
  sddm
  python-pip
  kitty
  zsh
  waybar
  rofi-wayland
  thunar
  nwg-look
  qt6-virtualkeyboard
  qt6-declarative
  qt6-multimedia
  qt6-multimedia-ffmpeg
  qt6-svg
  pipewire pipewire-pulse pipewire-alsa wireplumber
  polkit-kde-agent
  jq
  hyprpaper
  hyprlock
  linux-headers
  dkms
  bluez
  bluez-utils
)

echo "📥 Instalando paquetes principales..."
sudo pacman -S --needed --noconfirm "${CORE_PKGS[@]}"

# 4. Instalación de las Nerd Fonts completas
echo "🔤 Instalando paquete completo de Nerd Fonts..."
sudo pacman -S --needed --noconfirm nerd-fonts

# 5. Configuración de SDDM (Reemplazo bruto como pediste)
echo "🖥️ Configurando SDDM..."
sudo rm -rf /usr/share/sddm
sudo cp -r ./sddm-config/sddm /usr/share/
sudo cp ./sddm-config/sddm.conf /etc/

# Habilitamos SDDM para que arranque con el sistema
sudo systemctl enable sddm

# 6. Restaurar tus Dotfiles de usuario
echo "📁 Copiando dotfiles a ~/.config..."
mkdir -p ~/.config
cp -r ./config/* ~/.config/

# 7 Copiamos la sintaxis del shell
cp ./.zshrc ~/

# 8 Copiamos iconos y temas GTK
cp -r ./gtk-theme/* ~/

# 9. Cambiar shell a Zsh
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  echo "🐚 Cambiando tu shell a Zsh..."
  chsh -s $(which zsh)
fi

# 10. Configuracion de Xpadneo para joystick xbox
git clone https://github.com/atar-axis/xpadneo.git /tmp/xpadneo
cd /tmp/xpadneo
sudo ./install.sh

# 11. Habilitar servicios
sudo systemctl enable sddm
sudo systemctl enable bluetooth
sudo systemctl enable NetworkManager

echo "INSTALACION COMPLETA"
