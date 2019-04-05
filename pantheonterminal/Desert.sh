#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Desert'
cursor-color='#00ff00'
foreground='#ffffff'
background='rgba(51,51,51,.95)'
palette='#4d4d4d:#ff2b2b:#98fb98:#f0e68c:#cd853f:#ffdead:#ffa0a0:#f5deb3:#555555:#ff5555:#55ff55:#ffff55:#87ceff:#ff55ff:#ffd700:#ffffff'
COLORS
