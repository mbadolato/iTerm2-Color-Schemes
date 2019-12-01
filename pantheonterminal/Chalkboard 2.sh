#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Chalkboard'
cursor-color='#d9e6f2'
foreground='#d9e6f2'
background='rgba(41,38,47,.95)'
palette='#000000:#c37372:#72c373:#c2c372:#7372c3:#c372c2:#72c2c3:#d9d9d9:#323232:#dbaaaa:#aadbaa:#dadbaa:#aaaadb:#dbaada:#aadadb:#ffffff'
COLORS
