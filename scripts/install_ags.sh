#!/bin/bash
# fedora only

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'meson'
  'vala'  # fedora
  'valac' # ubuntu
  'valadoc'
  'gtk3-devel'   # fedora (is this needed?)
  'gtk4-devel'
  'libgtk-3-dev' # ubuntu
  'gtk-layer-shell-devel'  # fedora
  'libgtk-layer-shell-dev' # ubuntu
  'gobject-introspection-devel' # fedora
  'gobject-introspection'       # ubuntu
  'libgirepository1.0-dev' # ubuntu
  'golang'
)
bash "$scripts_dir/install_package" "${dependencies[@]}"

git clone https://github.com/aylur/astal.git /tmp/astal

cd /tmp/astal/lib/astal/io
meson setup --prefix /usr build
meson install -C build

cd /tmp/astal/lib/astal/gtk3
meson setup --prefix /usr build
meson install -C build

cd /tmp/astal/lang/gjs
meson setup --prefix /usr build
meson install -C build

cd /tmp/astal/lib/hyprland
meson setup --prefix /usr build
meson install -C build

git clone https://github.com/aylur/ags.git /tmp/ags
cd /tmp/ags
go install -ldflags "\
    -X 'main.gtk4LayerShell=$(pkg-config --variable=libdir gtk4-layer-shell-0)/libgtk4-layer-shell.so' \
    -X 'main.astalGjs=$(pkg-config --variable=srcdir astal-gjs)'"
sudo ln -s $HOME/go/bin/ags /usr/bin/ags
