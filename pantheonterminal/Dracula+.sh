#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Dracula+'
cursor-color='#eceff4'
foreground='#f8f8f2'
background='rgba(33,33,33,.95)'
palette='#21222c:#ff5555:#50fa7b:#ffcb6b:#82aaff:#c792ea:#8be9fd:#f8f8f2:#545454:#ff6e6e:#69ff94:#ffcb6b:#d6acff:#ff92df:#a4ffff:#f8f8f2'
COLORS
