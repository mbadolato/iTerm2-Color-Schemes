#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Pro Light'
cursor-color='#4d4d4d'
foreground='#191919'
background='rgba(255,255,255,.95)'
palette='#000000:#e5492b:#50d148:#c6c440:#3b75ff:#ed66e8:#4ed2de:#dcdcdc:#9f9f9f:#ff6640:#61ef57:#f2f156:#0082ff:#ff7eff:#61f7f8:#f2f2f2'
COLORS
