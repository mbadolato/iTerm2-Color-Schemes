#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Twilight'
cursor-color='#ffffff'
foreground='#ffffd4'
background='rgba(20,20,20,.95)'
palette='#141414:#c06d44:#afb97a:#c2a86c:#44474a:#b4be7c:#778385:#ffffd4:#262626:#de7c4c:#ccd88c:#e2c47e:#5a5e62:#d0dc8e:#8a989b:#ffffd4'
COLORS
