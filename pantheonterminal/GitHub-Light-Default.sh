#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='GitHub-Light-Default'
cursor-color='#0969da'
foreground='#1f2328'
background='rgba(255,255,255,.95)'
palette='#24292f:#cf222e:#116329:#4d2d00:#0969da:#8250df:#1b7c83:#6e7781:#57606a:#a40e26:#1a7f37:#633c01:#218bff:#a475f9:#3192aa:#8c959f'
COLORS
