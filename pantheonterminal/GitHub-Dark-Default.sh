#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='GitHub-Dark-Default'
cursor-color='#2f81f7'
foreground='#e6edf3'
background='rgba(13,17,23,.95)'
palette='#484f58:#ff7b72:#3fb950:#d29922:#58a6ff:#bc8cff:#39c5cf:#b1bac4:#6e7681:#ffa198:#56d364:#e3b341:#79c0ff:#d2a8ff:#56d4dd:#ffffff'
COLORS
