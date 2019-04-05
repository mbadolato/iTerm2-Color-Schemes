#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Builtin Dark'
cursor-color='#bbbbbb'
foreground='#bbbbbb'
background='rgba(0,0,0,.95)'
palette='#000000:#bb0000:#00bb00:#bbbb00:#0000bb:#bb00bb:#00bbbb:#bbbbbb:#555555:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#ffffff'
COLORS
