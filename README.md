# Garch's dotfiles
These are my personal dotfiles for my linux system.

 - Useful scripts found in `~/.local/bin/`
 - Settings for: 
    - vim / nvim (text editor)
    - zsh / bash (shell)
    - alacritty (terminal)
    - dunst (notification daemon)
    - qutebrowser (browser)
    - picom (compositor)
 - In order to keep `~` cleaner I moved all posible configs under `~/.config`
 - Functions can be found in `~/.config/functions`
 - Enviroment variables are set in `~/.config/profile`
 - Aliases are set in `~/.config/aliasrc`

## Usage
 - Window manager: 
    - Dwm
 - Application launcher:
    - Dmenu
 - Terminal:
    - Alacritty
 - Browser:
    - QuteBrowser / LibreWolf
 - Media player:
    - VLC / MPV

## Instalation
> Disclaimer: Use this script in a VM first and if you find any issues, please 
open one!

Even if this is a dotfiles directory, the installation script contains functions
to install my programs, configs and themes from an base Arch installation. \
But you can make it just to install my dotfiles, by removing the rest of the
functions from the bottom of the `install` script.

<details>
  <summary>What the script is doing ?</summary>

 - Install all my programs that I use day to day.
 - Install all my configs from this repository.
 - Compile programs like dwm, dwmblocks, dmenu and paru.
 - Modify some system configuration:
    - Change default shell to `zsh`.
    - Source enviroment variables from `.profile` file.
    - Add dwm to Lightdm sessions.
 - Add system themes:
    - Lightdm Webkit Theme Osmos
    - Vimix Grub Theme

</details>
