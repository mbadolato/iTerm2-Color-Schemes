#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='niji'
cursor-color='#ffc663'
foreground='#ffffff'
background='rgba(20,21,21,.95)'
palette='#333333:#d23e08:#54ca74:#fff700:#2ab9ff:#ff50da:#1ef9f5:#ddd0c4:#515151:#ffb7b7:#c1ffae:#fcffb8:#8efff3:#ffa2ed:#bcffc7:#ffffff'
COLORS
