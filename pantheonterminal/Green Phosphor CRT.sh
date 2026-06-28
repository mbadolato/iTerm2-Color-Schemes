#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Green Phosphor CRT'
cursor-color='#33ff33'
foreground='#33ff33'
background='rgba(11,15,11,.95)'
palette='#002200:#00aa00:#33ff33:#66ff66:#00cc44:#00ff88:#66ffaa:#b6ffb6:#0a5a0a:#19cc19:#66ff66:#99ff99:#33ff77:#66ffaa:#99ffcc:#e6ffe6'
COLORS
