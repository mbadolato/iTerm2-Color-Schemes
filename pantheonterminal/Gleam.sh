#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Gleam'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(41,45,62,.95)'
palette='#000000:#f44747:#aadd8b:#ffd596:#6796e6:#fe7ab2:#b181ec:#f7f7f7:#808080:#ff4a4a:#c8ffa7:#fdffab:#9ce7ff:#ffaff3:#d9baff:#ffffff'
COLORS
