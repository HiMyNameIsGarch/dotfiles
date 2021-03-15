set fish_greeting             # remove fish's message
###############################
#          variables          #
###############################
set editor vim
set TERM xterm-256color

###############################
#           aliases           #
###############################

alias i3lock "i3lock -i ~/Wallpapers/new.jpg"

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
alias create_vimspector_config "~/Scripts/create_vimspector_json_config.sh"

# open configs
alias c-qtile "$editor  ~/.config/qtile/config.py"
alias c-qutebrowser "$editor ~/.config/qutebrowser/config.py"
alias c-rofi "$editor ~/.config/rofi/config.rasi"
alias c-picom "$editor ~/.config/picom/picom.conf"
alias c-bash "$editor ~/.bashrc"
alias c-fish "$editor ~/.config/fish/config.fish"
alias c-vim "$editor ~/.vimrc"
alias c-alacritty "$editor ~/.config/alacritty/alacritty.yml"
alias c-quickmarks "$editor ~/.config/qutebrowser/quickmarks" # qutebrowser quickmarks

#open logs
alias log-qtile "$editor ~/.local/share/qtile/qtile.log"
