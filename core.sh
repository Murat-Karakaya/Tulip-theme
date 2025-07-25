REPO_DIR="$(dirname "$(readlink -m "${0}")")"
SRC_DIR="$REPO_DIR/src"

ROOT_UID=0
DEST_DIR=

MY_USERNAME="${SUDO_USER:-$(logname 2> /dev/null || echo "${USER}")}"
MY_HOME=$(getent passwd "${MY_USERNAME}" | cut -d: -f6)

# Destination directory
if [[ "$UID" -eq "$ROOT_UID" ]]; then
  DEST_DIR="/usr/share/themes"
elif [[ -n "$XDG_DATA_HOME" ]]; then
  DEST_DIR="$XDG_DATA_HOME/themes"
elif [[ -d "$HOME/.themes" ]]; then
  DEST_DIR="$HOME/.themes"
elif [[ -d "$HOME/.local/share/themes" ]]; then
  DEST_DIR="$HOME/.local/share/themes"
else
  DEST_DIR="$HOME/.themes"
fi

SASSC_OPT="-M -t expanded"

THEME_NAME=Nergis
THEME_VARIANTS=('' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey')
COLOR_VARIANTS=('' '-Light' '-Dark')
SIZE_VARIANTS=('' '-Compact')

ctype=

# Check command availability
function has_command() {
  command -v $1 > /dev/null
}

install() {
  theme_tweaks && install_theme_color

  local dest="$1"
  local name="$2"
  local theme="$3"
  local color="$4"
  local size="$5"
  local ctype="$6"

  if [[ "$color" == '-Dark' ]]; then
    local ELSE_DARK="$color"
    local icon_color='-dark'
    local else_icon_dark="$icon_color"
    sed -i "/\$variant:/s/light/dark/" $SRC_DIR/_sass/_tweaks-temp.scss
  fi

  if [[ "$color" == '-Light' ]]; then
    local ELSE_LIGHT="$color"
    local icon_color='-light'
    local else_icon_light="$icon_color"
    sed -i "/\$topbar:/s/dark/light/" $SRC_DIR/_sass/_tweaks-temp.scss
  fi

  if [[ "$size" == '-Compact' ]]; then
    sed -i "/\$compact:/s/false/true/" $SRC_DIR/_sass/_tweaks-temp.scss
  fi

  local THEME_DIR="${1}/${2}${3}${4}${5}${6}"

  [[ -d "$THEME_DIR" ]] && rm -rf "$THEME_DIR"



  echo "Installing '$THEME_DIR'..."

  mkdir -p                                                                                   "$THEME_DIR"
  cp -r "$REPO_DIR/COPYING"                                                                  "$THEME_DIR"

  echo "[Desktop Entry]" >>                                                                  "$THEME_DIR/index.theme"
  echo "Type=X-GNOME-Metatheme" >>                                                           "$THEME_DIR/index.theme"
  echo "Name=${2}${3}${4}${5}${6}" >>                                                        "$THEME_DIR/index.theme"
  echo "Comment=A modern Cinnamon theme based on Material Design" >>                         "$THEME_DIR/index.theme"
  echo "Encoding=UTF-8" >>                                                                   "$THEME_DIR/index.theme"

  mkdir -p                                                                                   "$THEME_DIR/cinnamon"
  cp -r "$SRC_DIR/cinnamon/common-assets"                                                    "$THEME_DIR/cinnamon/assets"
  cp -r "$SRC_DIR/cinnamon/assets${ELSE_DARK:-}/"*.svg                                       "$THEME_DIR/cinnamon/assets"
  cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/add-workspace-active${ELSE_DARK:-}.svg"         "$THEME_DIR/cinnamon/assets/add-workspace-active.svg"
  cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/corner-ripple${ELSE_DARK:-}.svg"                "$THEME_DIR/cinnamon/assets/corner-ripple.svg"

  if [[ "$primary" == 'true' ]]; then
    cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/checkbox${ELSE_DARK:-}.svg"                   "$THEME_DIR/cinnamon/assets/checkbox.svg"
    cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/radiobutton${ELSE_DARK:-}.svg"                "$THEME_DIR/cinnamon/assets/radiobutton.svg"
    cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/toggle-off${ELSE_DARK:-}.svg"                "$THEME_DIR/cinnamon/assets/toggle-off.svg"
    cp -r "$SRC_DIR/cinnamon/theme$theme$ctype/toggle-on${ELSE_DARK:-}.svg"                    "$THEME_DIR/cinnamon/assets/toggle-on.svg"
  fi

  sassc $SASSC_OPT "$SRC_DIR/cinnamon/cinnamon.scss"                      "$THEME_DIR/cinnamon/cinnamon.css"


  cp -r "$SRC_DIR/cinnamon/thumbnails/thumbnail$theme$ctype$color.png"               "$THEME_DIR/cinnamon/thumbnail.png"
}

uninstall() {
  local dest="$1"
  local name="$2"
  local theme="$3"
  local color="$4"
  local size="$5"
  local ctype="$6"

  local THEME_DIR="${1}/${2}${3}${4}${5}${6}"

  [[ -d "$THEME_DIR" ]] && rm -rf "$THEME_DIR" && echo -e "Uninstalling "$THEME_DIR" ..."
}

install_package() {
  if [ ! "$(which sassc 2> /dev/null)" ]; then
    echo sassc needs to be installed to generate the css.
    if has_command zypper; then
      sudo zypper in sassc
    elif has_command apt; then
      sudo apt install sassc
    elif has_command apt-get; then
      sudo apt-get install sassc
    fi
  fi
}

tweaks_temp() {
  cp -rf $SRC_DIR/_sass/_tweaks.scss $SRC_DIR/_sass/_tweaks-temp.scss
}

change_radio_color() {
  sed -i "/\$check_radio:/s/default/primary/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_compact_panel() {
  sed -i "/\$panel_style:/s/float/compact/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_transparent() {
  sed -i "/\$opacity:/s/solid/transparent/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_black() {
  sed -i "/\$blackness:/s/false/true/" $SRC_DIR/_sass/_tweaks-temp.scss
}

round_corner() {
  sed -i "/\$default_corner:/s/12px/${corner}/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_nord() {
  sed -i "/\@import/s/color-palette-default/color-palette-nord/" $SRC_DIR/_sass/_tweaks-temp.scss
  sed -i "/\$colorscheme:/s/default/nord/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_dracula() {
  sed -i "/\@import/s/color-palette-default/color-palette-dracula/" $SRC_DIR/_sass/_tweaks-temp.scss
  sed -i "/\$colorscheme:/s/default/dracula/" $SRC_DIR/_sass/_tweaks-temp.scss
}

install_theme_color() {
  if [[ "$theme" != '' ]]; then
    case "$theme" in
      -Purple)
        theme_color='purple'
        ;;
      -Pink)
        theme_color='pink'
        ;;
      -Red)
        theme_color='red'
        ;;
      -Orange)
        theme_color='orange'
        ;;
      -Yellow)
        theme_color='yellow'
        ;;
      -Green)
        theme_color='green'
        ;;
      -Teal)
        theme_color='teal'
        ;;
      -Grey)
        theme_color='grey'
        ;;
    esac
    sed -i "/\$theme:/s/default/${theme_color}/" $SRC_DIR/_sass/_tweaks-temp.scss
  fi
}

theme_tweaks() {
  install_package; tweaks_temp

  if [[ "$panel" == "compact" ]] ; then
    install_compact_panel
  fi

  if [[ "$opacity" == "transparent" ]] ; then
    install_transparent
  fi

  if [[ "$blackness" == "true" ]] ; then
    install_black
  fi

  if [[ "$primary" == "true" ]] ; then
    change_radio_color
  fi

  if [[ "$round" == "true" ]] ; then
    round_corner
  fi

  if [[ "$nord" == "true" ]] ; then
    install_nord
  fi

  if [[ "$dracula" == "true" ]] ; then
    install_dracula
  fi
}

backup_file() {
  if [[ -f "${1}.bak" || -d "${1}.bak" ]]; then
    case "${2}" in
      sudo)
        sudo rm -rf "${1}" ;;
      *)
        rm -rf "${1}" ;;
    esac
  fi

  if [[ -f "${1}" || -d "${1}" ]]; then
    case "${2}" in
      sudo)
        sudo mv -n "${1}"{"",".bak"} ;;
      *)
        mv -n "${1}"{"",".bak"} ;;
    esac
  fi
}

install_theme() {
  for theme in "${themes[@]}"; do
    for color in "${colors[@]}"; do
      for size in "${sizes[@]}"; do
        install "${dest:-$DEST_DIR}" "${_name:-$THEME_NAME}" "$theme" "$color" "$size" "$ctype"
      done
    done
  done
}

uninstall_theme() {
  for theme in "${THEME_VARIANTS[@]}"; do
    for color in "${COLOR_VARIANTS[@]}"; do
      for size in "${SIZE_VARIANTS[@]}"; do
        for scheme in '' '-Nord' '-Dracula'; do
          uninstall "${dest:-$DEST_DIR}" "${_name:-$THEME_NAME}" "$theme" "$color" "$size" "$scheme"
        done
      done
    done
  done
}

clean_theme() {
  if [[ "$DEST_DIR" == "$HOME/.themes" ]]; then
    local dest="$HOME/.local/share/themes"

    for theme in "${themes[@]}"; do
      for color in "${colors[@]}"; do
        for size in "${sizes[@]}"; do
          uninstall "${dest}" "${_name:-$THEME_NAME}" "$theme" "$color" "$size" "$scheme"
        done
      done
    done
  fi
}
