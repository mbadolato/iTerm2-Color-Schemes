#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Elementary'
cursor-color='#bbbbbb'
foreground='#efefef'
background='rgba(24,24,24,.95)'
palette='#242424:#d71c15:#5aa513:#fdb40c:#063b8c:#e40038:#2595e1:#efefef:#4b4b4b:#fc1c18:#6bc219:#fec80e:#0955ff:#fb0050:#3ea8fc:#8c00ec'
COLORS
