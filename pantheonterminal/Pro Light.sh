#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Pro Light'
cursor-color='#4d4d4d'
foreground='#191919'
background='rgba(255,255,255,.95)'
palette='#000000:#e5492b:#50d148:#c6c440:#3b75ff:#ed66e8:#4ed2de:#c2c2c2:#9f9f9f:#ff6640:#48d53e:#bfbe23:#0082ff:#ff7eff:#3bd1d2:#f2f2f2'
COLORS
