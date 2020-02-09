#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Laser'
cursor-color='#00ff9c'
foreground='#f106e3'
background='rgba(3,13,24,.95)'
palette='#626262:#ff8373:#b4fb73:#09b4bd:#fed300:#ff90fe:#d1d1fe:#f1f1f1:#8f8f8f:#ffc4be:#d6fcba:#fffed5:#f92883:#ffb2fe:#e6e7fe:#ffffff'
COLORS
