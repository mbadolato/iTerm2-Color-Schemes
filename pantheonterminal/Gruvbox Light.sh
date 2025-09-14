#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Gruvbox Light'
cursor-color='#3c3836'
foreground='#3c3836'
background='rgba(251,241,199,.95)'
palette='#fbf1c7:#cc241d:#98971a:#d79921:#458588:#b16286:#689d6a:#7c6f64:#928374:#9d0006:#79740e:#b57614:#076678:#8f3f71:#427b58:#3c3836'
COLORS
