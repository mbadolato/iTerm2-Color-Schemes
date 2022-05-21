#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Dark+'
cursor-color='#ffffff'
foreground='#cccccc'
background='rgba(30,30,30,.95)'
palette='#000000:#cd3131:#0dbc79:#e5e510:#2472c8:#bc3fbc:#11a8cd:#e5e5e5:#666666:#f14c4c:#23d18b:#f5f543:#3b8eea:#d670d6:#29b8db:#e5e5e5'
COLORS
