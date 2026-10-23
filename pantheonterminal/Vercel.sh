#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Vercel'
cursor-color='#ededed'
foreground='#ededed'
background='rgba(0,0,0,.95)'
palette='#1a1a1a:#e5484d:#63c174:#f1a10d:#52a9ff:#bf7af0:#0ac5b3:#a0a0a0:#8f8f8f:#fe7573:#83e293:#ffc983:#97c9fe:#d7a4ff:#4be6d3:#ffffff'
COLORS
