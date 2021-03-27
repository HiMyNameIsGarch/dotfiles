# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import socket

from libqtile import hook
from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
alt = "mod1"
terminal = "alacritty"

keys = [
    
    # Starts todo dmenu script
    Key([mod, "shift"], "t", lazy.spawn('zsh ~/Scripts/dmenu/todo',shell=True),
        desc="Opens dmenu todo script"),
    
    # Lock the screen
    Key([mod, alt], "l", lazy.spawn("i3lock -i ~/Media/Wallpapers/doomDlc.jpg", shell=True),
        desc="Locks the screen with a wallpaper"),
    
    # Starts dmenu
    Key([mod, "shift"], "Return", lazy.spawn('zsh ~/Scripts/dmenu/run-recent', shell=True),
        desc="Opens dmenu"),

    # Start passmenu
    Key([mod, "shift"], "p", lazy.spawn('passmenu'), 
        desc="spawns an instance of passmenu"),

    # Starts rofi
    #Key([mod], "d", lazy.spawn("rofi -show run"), desc="Opens rofi"),
    
    # Take screenshot of screen
    Key([mod, "shift"], "s", lazy.spawn("gscreenshot -c"), 
        desc="Takes a screenshot and copies the content in clipboard"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "control"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
]

def init_group_names():
    return [("WEB", {'layout':'columns'}),
            ("DEV",{'layout':'columns'}),
            ("SYS",{'layout':'columns'}),
            ("MUS",{'layout':'columns'}),
            ("CHAT",{'layout':'columns'}),
            ("VBOX",{'layout':'columns'}),
            ("VID",{'layout':'columns'}),
            ("GFX",{'layout':'columns'}),
            ("DOC",{'layout':'columns'})]

group_names = init_group_names()

groups = [Group(name, **kwargs) for name, kwargs in group_names]


for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))


colors = [
        ["a8dadc","a8dadc"], # white-blue
        ["457b9d","457b9d"], # gray-blue
        ["1d3557","1d3557"], # darker-blue
        ["e63946","e63946"], # red
        ["f1faee","f1faee"]] # white


# background and foreground colors for widgets
light_color = {
        "background":colors[0],
        "foreground":colors[2]
        }
dark_color = {
        "background":colors[1],
        "foreground":colors[4]
        }

# default arrows
light_arrow = widget.TextBox(
        text='\uE0B2',
        fontsize=34,
        padding=0,
        background=colors[1],
        foreground=colors[0]
        )

dark_arrow = widget.TextBox(
        text='\uE0B2',
        fontsize=34,
        padding=0,
        background=colors[0],
        foreground=colors[1]
        )

def init_layout_theme():
    return {
            "margin":4,
            "border_width":2,
            "border_focus":"#a8dadc",
            "border_normal":"#1d3557"
            }

layout_theme = init_layout_theme()

layouts = [
    layout.Columns(**layout_theme),
    layout.Matrix(columns=2, **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme)
    ]

widget_defaults = dict(
    font='Ubuntu Mono',
    fontsize=14,
    padding=2
)
extension_defaults = widget_defaults.copy()

dark_sep = widget.Sep(
        foreground=colors[1],
        background=colors[1],
        linewidth=5,
        padding=2)

light_sep = widget.Sep(
        foreground=colors[0],
        background=colors[0],
        linewidth=5,
        padding=2)

screens = [
    Screen(
        top=bar.Bar(
            [
                # Groups
                widget.GroupBox(
                    font = "Ubuntu Bold",
                    fontsize = 13,
                    margin_y = 4,
                    margin_x = 0,
                    padding_y = 5,
                    padding_x = 3,
                    borderwidth = 2,
                    active = colors[0],
                    inactive = colors[1],
                    rounded = False,
                    highlight_color = colors[2],
                    highlight_method = "line",
                    this_current_screen_border = colors[4],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[0],
                    other_screen_border = colors[0],
                    foreground = colors[4],
                    background = colors[2]
                    ),
                widget.CurrentLayout(
                    padding=5, 
                    font='Roboto Bold',
                    foreground=colors[4]
                    ),
                widget.WindowName(
                    fontsize=15,
                    font='Roboto Mono',
                    foreground=colors[4]
                    ),
                # Machine stats
                widget.TextBox(
                    text='\uE0B2',
                    fontsize=34,
                    padding=0,
                    background=colors[2],
                    foreground=colors[0]
                    ),
                # Updates
                widget.CheckUpdates(
                    display_format='Updates: {updates}',
                    update_interval=1800,
                    colour_have_updates=colors[2],
                    colour_no_updates=colors[3],
                    background=colors[0]
                    ),
                # Internet speed
                light_sep,
                dark_arrow,
                widget.Net(
                    interface = "enp3s0",
                    format = '{down} ↓↑ {up}',
                    **dark_color
                    ),
                
                # Memory
                dark_sep,
                light_arrow,
                widget.Memory(
                    format='MEM: {MemUsed: .0f}',
                    measure_mem='G',
                    update_interval=2.5,
                    padding=4,
                    **light_color
                    ),
                
                # Sensor for GPU
                light_sep,
                dark_arrow,
                widget.TextBox(text='GPU: ', **dark_color),
                widget.ThermalSensor(
                    tag_sensor='edge',
                    threshold=80,
                    update_interval=2.5,
                    **dark_color
                    ),
                
                # CPU
                dark_sep,
                light_arrow,
                widget.CPU(
                    format='CPU: {load_percent}% ',
                    update_interval=2.0,
                    **light_color
                    ),
                widget.ThermalSensor(
                    tag_sensor='Core 0',
                    threshold=70,
                    update_interval=2.5,
                    **light_color
                    ),
                light_sep,
                dark_arrow,
                # Clock
                widget.Clock(format='%I:%M %p',
                        update_interval=60,
                        font='Ubuntu Bold',
                        **dark_color),
                dark_sep
                ],
            25, background=colors[2], margin=[0,0,5,0], opacity=1.0)),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False 
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Auto start script

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])
