#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='electron-highlighter'
cursor-color='#a8b5d1'
foreground='#a8b5d1'
background='rgba(36,40,59,.95)'
palette='#15161e:#f7768e:#58ffc7:#ffd9af:#82aaff:#d2a6ef:#57f9ff:#7c8eac:#506686:#f7768e:#58ffc7:#ffd9af:#82aaff:#d2a6ef:#57f9ff:#c5cee0'
COLORS
