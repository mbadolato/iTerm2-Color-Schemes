#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Count Terminal'
cursor-color='#f18d96'
foreground='#f7e6dc'
background='rgba(72,8,20,.95)'
palette='#bca9ad:#ef7e88:#99c58e:#e1c467:#88b5d7:#c58bb9:#7bc6bf:#f7e6dc:#c4b3b7:#f18d96:#a5cc9c:#e5cb79:#96bedc:#cc99c1:#8bcdc7:#f8e9e0'
COLORS
