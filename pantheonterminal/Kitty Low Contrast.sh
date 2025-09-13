#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Kitty Low Contrast'
cursor-color='#cccccc'
foreground='#ffffff'
background='rgba(51,51,51,.95)'
palette='#000000:#cc0403:#19cb00:#cecb00:#0d73cc:#cb1ed1:#0dcdcd:#dddddd:#767676:#f2201f:#23fd00:#fffd00:#1a8fff:#fd28ff:#14ffff:#ffffff'
COLORS
