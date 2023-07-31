#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='iTerm2 Default'
cursor-color='#e5e5e5'
foreground='#ffffff'
background='rgba(0,0,0,.95)'
palette='#000000:#c91b00:#00c200:#c7c400:#2225c4:#ca30c7:#00c5c7:#ffffff:#686868:#ff6e67:#5ffa68:#fffc67:#6871ff:#ff77ff:#60fdff:#ffffff'
COLORS
