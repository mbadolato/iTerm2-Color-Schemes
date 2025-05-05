#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='selenized-light'
cursor-color='#53676d'
foreground='#53676d'
background='rgba(251,243,219,.95)'
palette='#ece3cc:#d2212d:#489100:#ad8900:#0072d4:#ca4898:#009c8f:#909995:#d5cdb6:#cc1729:#428b00:#a78300:#006dce:#c44392:#00978a:#3a4d53'
COLORS
