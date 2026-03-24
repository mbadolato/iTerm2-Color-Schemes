#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Clear Dark'
cursor-color='#9d9d9d'
foreground='#e6e6e6'
background='rgba(33,39,52,.95)'
palette='#35424c:#b45648:#6caa71:#c4ac62:#6d96b4:#bd7bcd:#7ccbcd:#dee5eb:#465c6d:#df6c5a:#79be7e:#e5c872:#67b5ed:#d389e5:#84dde0:#e5eff5'
COLORS
