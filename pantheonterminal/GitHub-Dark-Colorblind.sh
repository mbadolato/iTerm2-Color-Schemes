#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='GitHub-Dark-Colorblind'
cursor-color='#58a6ff'
foreground='#c9d1d9'
background='rgba(13,17,23,.95)'
palette='#484f58:#ec8e2c:#58a6ff:#d29922:#58a6ff:#bc8cff:#39c5cf:#b1bac4:#6e7681:#fdac54:#79c0ff:#e3b341:#79c0ff:#d2a8ff:#56d4dd:#ffffff'
COLORS
