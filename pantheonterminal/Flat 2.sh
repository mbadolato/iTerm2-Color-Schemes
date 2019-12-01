#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Flat'
cursor-color='#e5be0c'
foreground='#2cc55d'
background='rgba(0,34,64,.95)'
palette='#222d3f:#a82320:#32a548:#e58d11:#3167ac:#781aa0:#2c9370:#b0b6ba:#212c3c:#d4312e:#2d9440:#e5be0c:#3c7dd2:#8230a7:#35b387:#e7eced'
COLORS
