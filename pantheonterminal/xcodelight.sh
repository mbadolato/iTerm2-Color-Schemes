#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='xcodelight'
cursor-color='#262626'
foreground='#262626'
background='rgba(255,255,255,.95)'
palette='#b4d8fd:#d12f1b:#3e8087:#78492a:#0f68a0:#ad3da4:#804fb8:#262626:#8a99a6:#d12f1b:#23575c:#78492a:#0b4f79:#ad3da4:#4b21b0:#262626'
COLORS
