#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='This One Goes to 11'
cursor-color='#e6b74e'
foreground='#f0e6ce'
background='rgba(16,16,15,.95)'
palette='#292722:#d96a58:#89b67c:#d6aa4a:#82a8c8:#b49ac7:#78b8b0:#d9cfb9:#827b6d:#ff9580:#b8e3a5:#ffd36b:#b4d7f2:#dfc0ef:#a6e7de:#fff5df'
COLORS
