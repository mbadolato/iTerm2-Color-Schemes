#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='FishTank'
cursor-color='#fecd5e'
foreground='#ecf0fe'
background='rgba(35,37,55,.95)'
palette='#03073c:#c6004a:#acf157:#fecd5e:#525fb8:#986f82:#968763:#ecf0fc:#6c5b30:#da4b8a:#dbffa9:#fee6a9:#b2befa:#fda5cd:#a5bd86:#f6ffec'
COLORS
