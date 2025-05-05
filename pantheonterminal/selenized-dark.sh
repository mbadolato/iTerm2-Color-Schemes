#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='selenized-dark'
cursor-color='#adbcbc'
foreground='#adbcbc'
background='rgba(16,60,72,.95)'
palette='#184956:#fa5750:#75b938:#dbb32d:#4695f7:#f275be:#41c7b9:#72898f:#2d5b69:#ff665c:#84c747:#ebc13d:#58a3ff:#ff84cd:#53d6c7:#cad8d9'
COLORS
