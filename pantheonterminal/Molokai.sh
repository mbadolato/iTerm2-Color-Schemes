#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Molokai'
cursor-color='#bbbbbb'
foreground='#bbbbbb'
background='rgba(18,18,18,.95)'
palette='#121212:#fa2573:#98e123:#dfd460:#1080d0:#8700ff:#43a8d0:#bbbbbb:#555555:#f6669d:#b1e05f:#fff26d:#00afff:#af87ff:#51ceff:#ffffff'
COLORS
