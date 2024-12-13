#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='gruvbox-material'
cursor-color='#ffffff'
foreground='#d4be98'
background='rgba(29,32,33,.95)'
palette='#141617:#ea6926:#c1d041:#eecf75:#6da3ec:#fd9bc1:#fe9d6e:#ffffff:#000000:#d3573b:#c1d041:#eecf75:#2c86ff:#fd9bc1:#92a5df:#ffffff'
COLORS
