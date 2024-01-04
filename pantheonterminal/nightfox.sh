#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='nightfox'
cursor-color='#cdcecf'
foreground='#cdcecf'
background='rgba(25,35,48,.95)'
palette='#393b44:#c94f6d:#81b29a:#dbc074:#719cd6:#9d79d6:#63cdcf:#dfdfe0:#575860:#d16983:#8ebaa4:#e0c989:#86abdc:#baa1e2:#7ad5d6:#e4e4e5'
COLORS
