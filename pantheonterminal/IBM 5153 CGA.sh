#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='IBM 5153 CGA'
cursor-color='#d6d6d6'
foreground='#d6d6d6'
background='rgba(38,38,38,.95)'
palette='#262626:#db3333:#33db33:#db9833:#3333db:#db33db:#33dbdb:#d6d6d6:#4e4e4e:#dc4e4e:#4edc4e:#f3f34e:#4e4edc:#f34ef3:#4ef3f3:#ffffff'
COLORS
