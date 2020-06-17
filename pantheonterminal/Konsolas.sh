#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Konsolas'
cursor-color='#c8c1c1'
foreground='#c8c1c1'
background='rgba(6,6,6,.95)'
palette='#000000:#aa1717:#18b218:#ebae1f:#2323a5:#ad1edc:#42b0c8:#c8c1c1:#7b716e:#ff4141:#5fff5f:#ffff55:#4b4bff:#ff54ff:#69ffff:#ffffff'
COLORS
