# Nergis theme

Nergis is a [Material Design](https://material.io) theme made for Cinnamon desktop environment (often used by Linux Mint).
It is ased on [Orchis-theme](https://github.com/vinceliuice/Orchis-theme)

![screenshot](images/screenshot.png?raw=true)


## Installation

### Manual Installation

Run the following commands in the terminal:

```sh
./install.sh
```

> [!TIP]
> `./install.sh` allows the following options:

```
OPTIONS:
  -d, --dest DIR          Specify destination directory (Default: $HOME/.themes)
  -n, --name NAME         Specify theme name (Default: Nergis)

  -t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|teal|grey|all] (Default: blue)

  -c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)s)
                          Standard variant will have a dark panel and light popup elements.
                          Light and dark variants will only have light and dark elements respectively. 

  -s, --size VARIANT      Specify size variant [standard|compact] (standard)
                          Compact mode will have smaller popup elements.

  --tweaks                Specify versions for tweaks [solid|compact|black|primary|macos|(nord/dracula)] (Options can mix)
                          1. transparent        Make some elements semi-transparent (panels, popup menus, applets etc.)
                          2. black              Dark elements will be pitch black. Recommended for people who need/want a color contrast.
                                                Won't work on light elements.
                          3. primary            Use primary theme color on other elements too (like radio button, toggles and osd's)
                          4. [nord|dracula]     Nord/dracula colorscheme themes (nord and dracula can not mix use!)

  --round                 Change theme round corner border-radius [Input the px value you want] (Suggested: 2px < value < 16px)
                          1. 3px
                          2. 4px
                          3. 5px
                          ...
                          13. 15px


  -r, --remove, -u, --uninstall         Uninstall/Remove installed themes

  -h, --help              Show help
```

## Tweaks for Nergis

![tweaks-view](images/tweaks-view.png?raw=true)
