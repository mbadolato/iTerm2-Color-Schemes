#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='darkermatrix'
cursor-color='#373a26'
foreground='#28380d'
background='rgba(7,12,14,.95)'
palette='#091013:#002e18:#6fa64c:#595900:#00cb6b:#412a4d:#125459:#002e19:#333333:#00381d:#90d762:#e2e500:#00ff87:#412a4d:#176c73:#00381e'
COLORS
