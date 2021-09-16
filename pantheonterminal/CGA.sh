#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='CGA'
cursor-color='#b8b8b8'
foreground='#aaaaaa'
background='rgba(0,0,0,.95)'
palette='#000000:#aa0000:#00aa00:#aa5500:#0000aa:#aa00aa:#00aaaa:#aaaaaa:#555555:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#ffffff'
COLORS
