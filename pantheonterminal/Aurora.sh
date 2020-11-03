#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Aurora'
cursor-color='#ee5d43'
foreground='#ffca28'
background='rgba(35,38,46,.95)'
palette='#23262e:#f0266f:#8fd46d:#ffe66d:#0321d7:#ee5d43:#03d6b8:#c74ded:#292e38:#f92672:#8fd46d:#ffe66d:#03d6b8:#ee5d43:#03d6b8:#c74ded'
COLORS
