#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Kibble'
cursor-color='#9fda9c'
foreground='#f7f7f7'
background='rgba(14,16,10,.95)'
palette='#4d4d4d:#c70031:#29cf13:#d8e30e:#3449d1:#8400ff:#0798ab:#e2d1e3:#5a5a5a:#f01578:#6ce05c:#f3f79e:#97a4f7:#c495f0:#68f2e0:#ffffff'
COLORS
