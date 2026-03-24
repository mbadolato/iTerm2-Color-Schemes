#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Clear Light'
cursor-color='#919191'
foreground='#3a4851'
background='rgba(255,255,255,.95)'
palette='#2d3840:#b45648:#6caa71:#c4ac62:#5685a8:#ad64be:#69c6c9:#b4bbbf:#506573:#df6c5a:#79be7e:#d8bb65:#49a2e1:#d389e5:#5ec7cb:#d8e1e7'
COLORS
