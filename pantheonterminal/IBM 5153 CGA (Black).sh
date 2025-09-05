#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='IBM 5153 CGA (Black)'
cursor-color='#c4c4c4'
foreground='#c4c4c4'
background='rgba(0,0,0,.95)'
palette='#000000:#c40000:#00c400:#c47e00:#0000c4:#c400c4:#00c4c4:#c4c4c4:#4e4e4e:#dc4e4e:#4edc4e:#f3f34e:#4e4edc:#f34ef3:#4ef3f3:#ffffff'
COLORS
