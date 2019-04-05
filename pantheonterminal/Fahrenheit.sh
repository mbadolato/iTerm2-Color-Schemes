#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Fahrenheit'
cursor-color='#bbbbbb'
foreground='#ffffce'
background='rgba(0,0,0,.95)'
palette='#1d1d1d:#cda074:#9e744d:#fecf75:#720102:#734c4d:#979797:#ffffce:#000000:#fecea0:#cc734d:#fd9f4d:#cb4a05:#4e739f:#fed04d:#ffffff'
COLORS
