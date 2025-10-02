#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Builtin Light'
cursor-color='#000000'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#bb0000:#00bb00:#bbbb00:#0000bb:#bb00bb:#00bbbb:#bbbbbb:#555555:#ff5555:#2fd92f:#bfbf15:#5555ff:#ff55ff:#22cccc:#ffffff'
COLORS
