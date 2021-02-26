#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='iceberg-dark'
cursor-color='#c6c8d1'
foreground='#c6c8d1'
background='rgba(22,24,33,.95)'
palette='#1e2132:#e27878:#b4be82:#e2a478:#84a0c6:#a093c7:#89b8c2:#c6c8d1:#6b7089:#e98989:#c0ca8e:#e9b189:#91acd1:#ada0d3:#95c4ce:#d2d4de'
COLORS
