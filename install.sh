#! /usr/bin/env bash

REPO_DIR="$(dirname "$(readlink -m "${0}")")"
source "${REPO_DIR}/core.sh"

usage() {
cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -d, --dest DIR          Specify destination directory (Default: $HOME/.themes)
  -n, --name NAME         Specify theme name (Default: Nergis)

  -t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|teal|grey|all] (Default: blue)
  -c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)s)
  -s, --size VARIANT      Specify size variant [standard|compact] (Default: All variants)

  --tweaks                Specify versions for tweaks [solid|compact|black|primary|macos|(nord/dracula)] (Options can mix)
                          1. solid              No transparency panel variant
                          2. compact            Smaller icons in panel variant
                          3. black              Full black variant
                          4. primary            Use primary theme color on other elements too (like radio button, toggles and osd's)
                          5. transparent        Make some elements semi-transparent (panels, popup menus, applets etc.)
                          6. [nord|dracula]     Nord/dracula colorscheme themes (nord and dracula can not mix use!)

  --round                 Change theme round corner border-radius [Input the px value you want] (Suggested: 2px < value < 16px)
                          1. 3px
                          2. 4px
                          3. 5px
                          ...
                          13. 15px


  -r, --remove,
  -u, --uninstall         Uninstall/Remove installed themes

  -h, --help              Show help
EOF
}

themes=()
colors=()
sizes=()
othemes=()
ocolors=()
osizes=()
lcolors=()

while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -d|--dest)
      dest="$2"
      mkdir -p "$dest"
      shift 2
      ;;
    -n|--name)
      _name="$2"
      shift 2
      ;;
    -r|--remove|-u|--uninstall)
      remove="true"
      shift
      ;;
    --round)
      round="true"
      corner="$2"
      echo -e "Change round corner ${corner} value ..."
      shift 2
      ;;
    --tweaks)
      shift
      for variant in $@; do
        case "$variant" in
          transparent)
            opacity="transparent"
            echo -e "Install transparent version ..."
            shift
            ;;
          compact)
            panel="compact"
            echo -e "Install compact panel version ..."
            shift
            ;;
          black)
            blackness="true"
            echo -e "Install black version ..."
            shift
            ;;
          primary)
            primary="true"
            echo "Change radio and check assets color ..."
            shift
            ;;
          nord)
            nord="true"
            ctype="-Nord"
            echo -e "Install nord colorscheme ..."
            shift
            ;;
          dracula)
            dracula="true"
            ctype="-Dracula"
            echo -e "Install dracula colorscheme ..."
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized tweaks variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -t|--theme)
      shift
      for variant in "$@"; do
        case "$variant" in
          default)
            themes+=("${THEME_VARIANTS[0]}")
            shift
            ;;
          purple)
            themes+=("${THEME_VARIANTS[1]}")
            shift
            ;;
          pink)
            themes+=("${THEME_VARIANTS[2]}")
            shift
            ;;
          red)
            themes+=("${THEME_VARIANTS[3]}")
            shift
            ;;
          orange)
            themes+=("${THEME_VARIANTS[4]}")
            shift
            ;;
          yellow)
            themes+=("${THEME_VARIANTS[5]}")
            shift
            ;;
          green)
            themes+=("${THEME_VARIANTS[6]}")
            shift
            ;;
          teal)
            themes+=("${THEME_VARIANTS[7]}")
            shift
            ;;
          grey)
            themes+=("${THEME_VARIANTS[8]}")
            shift
            ;;
          all)
            themes+=("${THEME_VARIANTS[@]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized theme variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -c|--color)
      shift
      for variant in "$@"; do
        case "$variant" in
          standard)
            colors+=("${COLOR_VARIANTS[0]}")
            lcolors+=("${COLOR_VARIANTS[0]}")
            shift
            ;;
          light)
            colors+=("${COLOR_VARIANTS[1]}")
            lcolors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[2]}")
            lcolors+=("${COLOR_VARIANTS[2]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--size)
      shift
      for variant in "$@"; do
        case "$variant" in
          standard)
            sizes+=("${SIZE_VARIANTS[0]}")
            shift
            ;;
          compact)
            sizes+=("${SIZE_VARIANTS[1]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

if [[ "${#themes[@]}" -eq 0 ]] ; then
  themes=("${THEME_VARIANTS[0]}")
fi

if [[ "${#colors[@]}" -eq 0 ]] ; then
  colors=("${COLOR_VARIANTS[@]}")
fi

if [[ "${#sizes[@]}" -eq 0 ]] ; then
  sizes=("${SIZE_VARIANTS[@]}")
fi

if [[ ${remove} == 'true' ]]; then
  uninstall_theme
else
  clean_theme
  install_theme
fi

echo
echo "Done."
