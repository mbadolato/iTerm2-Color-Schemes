#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='deep'
cursor-color='#d0d0d0'
foreground='#cdcdcd'
background='rgba(9,9,9,.95)'
palette='#000000:#d70005:#1cd915:#d9bd26:#5665ff:#b052da:#50d2da:#e0e0e0:#535353:#fb0007:#22ff18:#fedc2b:#9fa9ff:#e09aff:#8df9ff:#ffffff'
COLORS
