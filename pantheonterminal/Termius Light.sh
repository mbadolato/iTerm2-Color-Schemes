#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Termius Light'
cursor-color='#32364a'
foreground='#32364a'
background='rgba(213,221,224,.95)'
palette='#141729:#f24e50:#198c51:#ab6918:#004878:#8f3c91:#2091f6:#eeeeee:#3e4257:#ff7375:#21b568:#fdc47d:#1d6da2:#ff7dc5:#44a7ff:#ffffff'
COLORS
