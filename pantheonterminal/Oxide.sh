#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Oxide'
cursor-color='#cecece'
foreground='#cecece'
background='rgba(22,22,22,.95)'
palette='#262626:#ed756e:#5bb661:#c39900:#3ba6f5:#968ff7:#00baaa:#cecece:#8f8f8f:#ff9890:#7bd77f:#e3b831:#6fc6ff:#b5b2ff:#00dcca:#dedede'
COLORS
