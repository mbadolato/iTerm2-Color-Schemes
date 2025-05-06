#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='12-bit Rainbow'
cursor-color='#e0d000'
foreground='#feffff'
background='rgba(4,4,4,.95)'
palette='#000000:#a03050:#40d080:#e09040:#3060b0:#603090:#0090c0:#dbded8:#685656:#c06060:#90d050:#e0d000:#00b0c0:#801070:#20b0c0:#ffffff'
COLORS
