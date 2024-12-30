#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Dracula'
cursor-color='#bbbbbb'
foreground='#e6e6e6'
background='rgba(30,31,41,.95)'
palette='#000000:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#bbbbbb:#555555:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#ffffff'
COLORS
