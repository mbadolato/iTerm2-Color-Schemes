#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Termius Dark'
cursor-color='#21b568'
foreground='#21b568'
background='rgba(20,23,41,.95)'
palette='#343851:#f24e50:#008463:#eca855:#08639f:#c13282:#2091f6:#e2e3e8:#8d91a5:#ff7375:#3ed7be:#fdc47d:#6ba0c3:#ff7dc5:#44a7ff:#ffffff'
COLORS
