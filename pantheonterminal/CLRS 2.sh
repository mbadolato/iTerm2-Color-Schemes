#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='CLRS'
cursor-color='#6fd3fc'
foreground='#262626'
background='rgba(255,255,255,.95)'
palette='#000000:#f8282a:#328a5d:#fa701d:#135cd0:#9f00bd:#33c3c1:#b3b3b3:#555753:#fb0416:#2cc631:#fdd727:#1670ff:#e900b0:#3ad5ce:#eeeeec'
COLORS
