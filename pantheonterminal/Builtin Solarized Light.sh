#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Builtin Solarized Light'
cursor-color='#657b83'
foreground='#657b83'
background='rgba(253,246,227,.95)'
palette='#073642:#dc322f:#859900:#b58900:#268bd2:#d33682:#2aa198:#eee8d5:#002b36:#cb4b16:#586e75:#657b83:#839496:#6c71c4:#93a1a1:#fdf6e3'
COLORS
