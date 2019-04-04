#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Pro'
cursor-color='#4d4d4d'
foreground='#f2f2f2'
background='rgba(0,0,0,.95)'
palette='#000000:#990000:#00a600:#999900:#2009db:#b200b2:#00a6b2:#bfbfbf:#666666:#e50000:#00d900:#e5e500:#0000ff:#e500e5:#00e5e5:#e5e5e5'
COLORS
