#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Tailwind Light'
cursor-color='#0a0a0a'
foreground='#0a0a0a'
background='rgba(250,250,250,.95)'
palette='#262626:#b91c1c:#15803d:#a16207:#0369a1:#a21caf:#0f766e:#bababa:#737373:#dc2626:#16a34a:#ca8a04:#0284c7:#c026d3:#0d9488:#e5e5e5'
COLORS
