#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='electron-highlighter'
cursor-color='#a8b5d1'
foreground='#a8b5d1'
background='rgba(36,40,59,.95)'
palette='#15161e:#f7768e:#34febb:#ffd9af:#82aaff:#c792ea:#4ff2f8:#7c8eac:#506686:#f7768e:#34febb:#ffd9af:#82aaff:#c792ea:#4ff2f8:#c5cee0'
COLORS
