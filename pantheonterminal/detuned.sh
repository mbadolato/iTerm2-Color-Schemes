#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='detuned'
cursor-color='#c7c7c7'
foreground='#c7c7c7'
background='rgba(0,0,0,.95)'
palette='#171717:#fe4386:#a6e32d:#e6da73:#0094d9:#9b37ff:#50b7d9:#c7c7c7:#686868:#fa80ac:#bde371:#fff27f:#00beff:#be9eff:#5ed7ff:#ffffff'
COLORS
