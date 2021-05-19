#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='UltraDark'
cursor-color='#fefefe'
foreground='#ffffff'
background='rgba(0,0,0,.95)'
palette='#000000:#f07178:#c3e88d:#ffcb6b:#82aaff:#c792ea:#89ddff:#cccccc:#333333:#f6a9ae:#dbf1ba:#ffdfa6:#b4ccff:#ddbdf2:#b8eaff:#ffffff'
COLORS
