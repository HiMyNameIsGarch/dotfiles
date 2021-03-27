set fish_greeting             # remove fish's message
###############################
#          variables          #
###############################
set EDITOR vim
set TERM xterm-256color

###############################
#           aliases           #
###############################

# ls commands with 'exa'
alias ls "exa -al --color=always --group-directories-first"
alias la "exa -a --color=always --group-directories-first"
alias ll "exa -l --color=always --group-directories-first"
alias lt "exa -aT --color=always --group-directories-first"

# navigation on directories with 'cd'
alias .. "cd .."
alias ... "cd ../.."
alias .3 "cd ../../.."
alias .4 "cd ../../../.."

# update the system
alias pacsyyu "sudo pacman -Syyu"
alias pacsy "sudo pacman -Syu"
alias pacs "sudo pacman -S"
alias pacr "sudo pacman -R"
alias yays "yay -S"
alias yaysua "sudo yay -Sua"
alias yaysyu "sudo yay -Syu"
alias yayr "sudo yay -R"

# get fastest mirrors using reflector
alias mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"


# execute scripts
alias lock "~/Scripts/lock_screen.sh"
alias open_camera "~/Scripts/open_camera.sh"
alias change_rez_dc "~/Scripts/change_rez_droidcam.sh" 
alias create_csharp_vs_config "~/Scripts/create_csharp_vs_config.sh"

# open configs
alias c-qtile "$EDITOR  ~/.config/qtile/config.py"
alias c-qutebrowser "$EDITOR ~/.config/qutebrowser/config.py"
alias c-rofi "$EDITOR ~/.config/rofi/config.rasi"
alias c-picom "$EDITOR ~/.config/picom/picom.conf"
alias c-bash "$EDITOR ~/.bashrc"
alias c-fish "$EDITOR ~/.config/fish/config.fish"
alias c-vim "$EDITOR ~/.vimrc"
alias c-alacritty "$EDITOR ~/.config/alacritty/alacritty.yml"
alias c-quickmarks "$EDITOR ~/.config/qutebrowser/quickmarks" # qutebrowser quickmarks

#open logs
alias log-qtile "$EDITOR ~/.local/share/qtile/qtile.log"
