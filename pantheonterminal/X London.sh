#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='X London'
cursor-color='#333333'
foreground='#333333'
background='rgba(255,255,255,.95)'
palette='#ffffff:#333333:#444444:#555555:#666666:#777777:#888888:#333333:#333333:#444444:#555555:#666666:#777777:#888888:#999999:#aaaaaa'
COLORS
