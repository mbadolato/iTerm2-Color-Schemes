#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Espresso'
cursor-color='#d6d6d6'
foreground='#ffffff'
background='rgba(50,50,50,.95)'
palette='#353535:#d25252:#a5c261:#ffc66d:#6c99bb:#d197d9:#bed6ff:#eeeeec:#535353:#f00c0c:#c2e075:#e1e48b:#8ab7d9:#efb5f7:#dcf4ff:#ffffff'
COLORS
