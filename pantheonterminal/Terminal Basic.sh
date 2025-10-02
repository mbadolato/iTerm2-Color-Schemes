#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Terminal Basic'
cursor-color='#7f7f7f'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#990000:#00a600:#999900:#0000b2:#b200b2:#00a6b2:#bfbfbf:#666666:#e50000:#00d900:#bfbf00:#0000ff:#e500e5:#00d8d8:#e5e5e5'
COLORS
