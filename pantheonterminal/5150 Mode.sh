#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='5150 Mode'
cursor-color='#d5e875'
foreground='#ecf4db'
background='rgba(8,40,32,.95)'
palette='#8ca99f:#d59a71:#70bd83:#d2ca72:#80b3a0:#a8b38a:#62c5ac:#e5eddb:#a8c5b9:#e8ab83:#8ed69a:#e3dc8b:#9bc8b5:#bec7a0:#7ddbc2:#ffffff'
COLORS
