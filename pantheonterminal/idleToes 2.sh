#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='idleToes'
cursor-color='#d6d6d6'
foreground='#ffffff'
background='rgba(50,50,50,.95)'
palette='#323232:#d25252:#7fe173:#ffc66d:#4099ff:#f680ff:#bed6ff:#eeeeec:#535353:#f07070:#9dff91:#ffe48b:#5eb7f7:#ff9dff:#dcf4ff:#ffffff'
COLORS
