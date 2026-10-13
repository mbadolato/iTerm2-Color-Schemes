#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Smoke on the Terminal'
cursor-color='#e7c692'
foreground='#f5e8f4'
background='rgba(48,36,58,.95)'
palette='#a8b2b8:#df8d80:#a7c996:#e4be83:#a4b5e2:#cf9be2:#8fcbd2:#f5e8f4:#b9c1c6:#e39b8f:#b2cfa3:#e7c692:#afbee5:#d5a7e5:#9cd1d7:#f7edf6'
COLORS
