#! /usr/bin/env bash

cd "$(dirname "$0")" || exit

for theme in '' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey'; do
  for type in '' '-Nord' '-Dracula'; do
    case "$theme" in
      '')
        theme_color_dark='#006eff'
        theme_color_light='#1A73E8'
        ;;
      -Purple)
        theme_color_dark='#8f47bc'
        theme_color_light='#a600ff'
        ;;
      -Pink)
        theme_color_dark='#EC407A'
        theme_color_light='#ff0055'
        ;;
      -Red)
        theme_color_dark='#e73330'
        theme_color_light='#ff1f1f'
        ;;
      -Orange)
        theme_color_dark='#f3562f'
        theme_color_light='#ff7139'
        ;;
      -Yellow)
        theme_color_dark='#FFD600'
        theme_color_light='#ffb700'
        ;;
      -Green)
        theme_color_dark='#4CAF50'
        theme_color_light='#66BB6A'
        ;;
      -Teal)
        theme_color_dark='#45ABB7'
        theme_color_light='#3d9ba6'
        ;;
      -Grey)
        theme_color_dark='#464646'
        theme_color_light='#DDDDDD'
        ;;
    esac

    if [[ "$type" == '-Nord' ]]; then
      case "$theme" in
        '')
          theme_color_dark='#5e81ac'
          theme_color_light='#89a3c2'
          ;;
        -Purple)
          theme_color_dark='#b57daa'
          theme_color_light='#c89dbf'
          ;;
        -Pink)
          theme_color_dark='#cd7092'
          theme_color_light='#dc98b1'
          ;;
        -Red)
          theme_color_dark='#c35b65'
          theme_color_light='#d4878f'
          ;;
        -Orange)
          theme_color_dark='#d0846c'
          theme_color_light='#dca493'
          ;;
        -Yellow)
          theme_color_dark='#e4b558'
          theme_color_light='#eac985'
          ;;
        -Green)
          theme_color_dark='#82ac5d'
          theme_color_light='#a0c082'
          ;;
        -Teal)
          theme_color_dark='#63a6a5'
          theme_color_light='#83b9b8'
          ;;
        -Grey)
          theme_color_dark='#3a4150'
          theme_color_light='#d9dce3'
          ;;
      esac
    fi

    if [[ "$type" == '-Dracula' ]]; then
      case "$theme" in
        '')
          theme_color_dark='#5d70ac'
          theme_color_light='#6272a4'
          ;;
        -Purple)
          theme_color_dark='#a679ec'
          theme_color_light='#bd93f9'
          ;;
        -Pink)
          theme_color_dark='#f04cab'
          theme_color_light='#ff79c6'
          ;;
        -Red)
          theme_color_dark='#f44d4d'
          theme_color_light='#ff5555'
          ;;
        -Orange)
          theme_color_dark='#f8a854'
          theme_color_light='#ffb86c'
          ;;
        -Yellow)
          theme_color_dark='#e8f467'
          theme_color_light='#f1fa8c'
          ;;
        -Green)
          theme_color_dark='#4be772'
          theme_color_light='#50fa7b'
          ;;
        -Teal)
          theme_color_dark='#20eed9'
          theme_color_light='#50fae9'
          ;;
        -Grey)
          theme_color_dark='#3c3f51'
          theme_color_light='#d9dae3'
          ;;
      esac
    fi

    if [[ "$type" != '' ]]; then
      rm -rf "theme${theme}${type}"
      cp -rf "theme" "theme${theme}${type}"
      sed -i "s/#1a73e8/${theme_color_dark}/g" "theme${theme}${type}"/*.svg
      sed -i "s/#3281ea/${theme_color_light}/g" "theme${theme}${type}"/*.svg
    elif [[ "$theme" != '' ]]; then
      rm -rf "theme${theme}"
      cp -rf "theme" "theme${theme}"
      sed -i "s/#1a73e8/${theme_color_dark}/g" "theme${theme}"/*.svg
      sed -i "s/#3281ea/${theme_color_light}/g" "theme${theme}"/*.svg
    fi
  done
done

echo -e "DONE!"
