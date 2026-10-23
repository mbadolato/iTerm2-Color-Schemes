#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Vercel Light'
cursor-color='#24292f'
foreground='#24292f'
background='rgba(251,251,250,.95)'
palette='#24292f:#cf2f36:#18703a:#8a5300:#1a5fb4:#7e3ab8:#0b7268:#4f5359:#656a70:#a8242b:#0f5a2c:#6b3f00:#124a8c:#622a92:#085a52:#171717'
COLORS
