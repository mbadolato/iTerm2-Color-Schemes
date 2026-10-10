#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Black Cat'
cursor-color='#ff979f'
foreground='#f5edff'
background='rgba(24,10,43,.95)'
palette='#a9a0b6:#ff8992:#9fda65:#edc85e:#8bbdf0:#c78bf0:#76d2d1:#f5edff:#b3abbf:#ff979f:#abde77:#efcf71:#99c5f2:#ce99f2:#86d7d7:#f6efff'
COLORS
