#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='zenwritten_light'
cursor-color='#353535'
foreground='#353535'
background='rgba(238,238,238,.95)'
palette='#eeeeee:#a8334c:#4f6c31:#944927:#286486:#88507d:#3b8992:#353535:#c6c3c3:#94253e:#3f5a22:#803d1c:#1d5573:#7b3b70:#2b747c:#5c5c5c'
COLORS
