#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Prism'
cursor-color='#56d5ff'
foreground='#d7e3f4'
background='rgba(11,19,38,.95)'
palette='#060c18:#ff7192:#71e0b0:#fad77c:#47b3ff:#9da9ff:#31dcf2:#b6c4dc:#5e6f90:#ff96ad:#93ecc7:#fca76d:#77caff:#b8c1ff:#6ceafb:#eaf1fb'
COLORS
