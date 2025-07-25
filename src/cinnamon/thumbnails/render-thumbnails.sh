#! /usr/bin/env bash

# Change to the script's directory
cd "$(dirname "$0")" || exit

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

./make-thumbnails.sh

for theme in '' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey'; do
  for type in '' '-Nord' '-Dracula'; do
    # Render the mixed-variant thumbnail
    SRC_FILE="thumbnail${theme}${type}.svg"
    OUT_FILE="thumbnail${theme}${type}.png"
    echo "Rendering thumbnail${theme}${type}.png"
    $INKSCAPE --export-dpi=96 \
              --export-filename="$OUT_FILE" "$SRC_FILE" >/dev/null \
    && $OPTIPNG -o7 --quiet "$OUT_FILE"

    # Render the light-variant thumbnail
    SRC_FILE="thumbnail${theme}${type}-Light.svg"
    OUT_FILE="thumbnail${theme}${type}-Light.png"
    echo "Rendering thumbnail${theme}${type}-Light.png"
    $INKSCAPE --export-dpi=96 \
              --export-filename="$OUT_FILE" "$SRC_FILE" >/dev/null \
    && $OPTIPNG -o7 --quiet "$OUT_FILE"

    # Render the dark-variant thumbnail
    SRC_FILE="thumbnail${theme}${type}-Dark.svg"
    OUT_FILE="thumbnail${theme}${type}-Dark.png"
    echo "Rendering thumbnail${theme}${type}-Dark.png"
    $INKSCAPE --export-dpi=96 \
              --export-filename="$OUT_FILE" "$SRC_FILE" >/dev/null \
    && $OPTIPNG -o7 --quiet "$OUT_FILE"
  done
done

for theme in '' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey'; do
  for type in '' '-Nord' '-Dracula'; do
    if [[ ${theme} == '' && ${type} == '' ]]; then
      echo "keep thumbnail.svg"
    else
      rm -f "thumbnail${theme}${type}.svg"
      rm -f "thumbnail${theme}${type}-Light.svg"
      rm -f "thumbnail${theme}${type}-Dark.svg"
    fi
  done
done

exit 0