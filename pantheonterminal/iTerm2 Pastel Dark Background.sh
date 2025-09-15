#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='iTerm2 Pastel Dark Background'
cursor-color='#ffb473'
foreground='#c7c7c7'
background='rgba(0,0,0,.95)'
palette='#626262:#ff8373:#b4fb73:#fffdc3:#a5d5fe:#ff90fe:#d1d1fe:#f1f1f1:#8f8f8f:#ffc4be:#d6fcba:#fffed5:#c2e3ff:#ffb2fe:#e6e6fe:#ffffff'
COLORS
