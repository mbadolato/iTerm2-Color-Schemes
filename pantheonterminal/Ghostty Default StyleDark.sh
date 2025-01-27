#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Ghostty Default StyleDark'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(41,44,51,.95)'
palette='#1d1f21:#bf6b69:#b7bd73:#e9c880:#88a1bb:#ad95b8:#95bdb7:#c5c8c6:#666666:#c55757:#bcc95f:#e1c65e:#83a5d6:#bc99d4:#83beb1:#eaeaea'
COLORS
