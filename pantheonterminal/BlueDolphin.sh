#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='BlueDolphin'
cursor-color='#ffcc00'
foreground='#c5f2ff'
background='rgba(0,105,132,.95)'
palette='#292d3e:#ff8288:#b4e88d:#f4d69f:#82aaff:#e9c1ff:#89ebff:#d0d0d0:#434758:#ff8b92:#ddffa7:#ffe585:#9cc4ff:#ddb0f6:#a3f7ff:#ffffff'
COLORS
