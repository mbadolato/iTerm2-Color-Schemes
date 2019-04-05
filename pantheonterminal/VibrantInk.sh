#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='VibrantInk'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(0,0,0,.95)'
palette='#878787:#ff6600:#ccff04:#ffcc00:#44b4cc:#9933cc:#44b4cc:#f5f5f5:#555555:#ff0000:#00ff00:#ffff00:#0000ff:#ff00ff:#00ffff:#e5e5e5'
COLORS
