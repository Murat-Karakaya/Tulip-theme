# Tulip theme

Tulip is a [Material Design](https://material.io) theme made for Cinnamon desktop environment (often used by Linux Mint).
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
  -n, --name NAME         Specify theme name (Default: Tulip)

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
```

> For more information, run: `./install.sh -h`

## Tweaks for Tulip

![tweaks-view](images/tweaks-view.png?raw=true)

### Fix for libadwaita (Gnome-shell >= 42.0)

![libadwaita](images/libadwaita.png?raw=true)

run: `./install.sh -l` (Default light version will installed)

This fix is just a link from selected Ochis gtk-4.0 theme in `$HOME/.theme` to `$HOME/.config/gtk-4.0/gtk.css`
so it will not support change theme through `Gnome-tweaks`
if you want install other theme version for libadwaita you can run like:

```sh
./install.sh -c dark -l #(Link dark version)
```

```sh
./install.sh -c dark -t purple -l #(Link dark purple version)
```

and so on ... 

### Fix for Flatpak

```sh
sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
```

If you use flatpak apps, you can run this to fix theme issue.

