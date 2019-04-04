#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Dark Pastel'
cursor-color='#bbbbbb'
foreground='#ffffff'
background='rgba(0,0,0,.95)'
palette='#000000:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#bbbbbb:#555555:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#ffffff'
COLORS
