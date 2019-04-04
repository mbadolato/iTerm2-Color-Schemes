#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='lovelace'
cursor-color='#c574dd'
foreground='#fdfdfd'
background='rgba(29,31,40,.95)'
palette='#282a36:#f37f97:#5adecd:#f2a272:#8897f4:#c574dd:#79e6f3:#fdfdfd:#414458:#ff4971:#18e3c8:#ff8037:#556fff:#b043d1:#3fdcee:#bebec1'
COLORS
