#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='iTerm2 Light Background'
cursor-color='#000000'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#c91b00:#00c200:#c7c400:#0225c7:#ca30c7:#00c5c7:#bababa:#686868:#ff6e67:#39d442:#ccc934:#6871ff:#ff77ff:#3ad7d9:#ffffff'
COLORS
