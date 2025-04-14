#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Box'
cursor-color='#9fef00'
foreground='#9fef00'
background='rgba(20,29,43,.95)'
palette='#000000:#cc0403:#19cb00:#cecb00:#0d73cc:#cb1ed1:#0dcdcd:#dddddd:#767676:#f2201f:#23fd00:#fffd00:#1a8fff:#fd28ff:#14ffff:#ffffff'
COLORS
