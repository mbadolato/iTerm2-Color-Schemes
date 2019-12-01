#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='IR_Black'
cursor-color='#808080'
foreground='#f1f1f1'
background='rgba(0,0,0,.95)'
palette='#4f4f4f:#fa6c60:#a8ff60:#fffeb7:#96cafe:#fa73fd:#c6c5fe:#efedef:#7b7b7b:#fcb6b0:#cfffab:#ffffcc:#b5dcff:#fb9cfe:#e0e0fe:#ffffff'
COLORS
