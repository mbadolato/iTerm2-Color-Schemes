#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Squintless'
cursor-color='#282828'
foreground='#3c3836'
background='rgba(242,229,188,.95)'
palette='#f2e5bc:#9d0006:#79740e:#b57614:#076678:#8f3f71:#427b58:#7c6f64:#928374:#9d0006:#79740e:#b57614:#076678:#8f3f71:#427b58:#3c3836'
COLORS
