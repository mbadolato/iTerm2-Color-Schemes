#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='IBM 5153 CGA'
cursor-color='#cecece'
foreground='#cecece'
background='rgba(20,20,20,.95)'
palette='#141414:#d03333:#1bd01b:#d08c1b:#1b1bd0:#d01bd0:#1bd0d0:#cecece:#4e4e4e:#dc4e4e:#4edc4e:#f3f34e:#4e4edc:#f34ef3:#4ef3f3:#ffffff'
COLORS
