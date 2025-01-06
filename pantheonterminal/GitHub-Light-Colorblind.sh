#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='GitHub-Light-Colorblind'
cursor-color='#0969da'
foreground='#24292f'
background='rgba(255,255,255,.95)'
palette='#24292f:#b35900:#0550ae:#4d2d00:#0969da:#8250df:#1b7c83:#6e7781:#57606a:#8a4600:#0969da:#633c01:#218bff:#a475f9:#3192aa:#8c959f'
COLORS
