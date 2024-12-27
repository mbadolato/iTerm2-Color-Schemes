#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='starlight'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(36,36,36,.95)'
palette='#242424:#e2425d:#66b238:#dec541:#54aad0:#e8b2f8:#5abf9b:#e6e6e6:#616161:#ec5b58:#6bd162:#e9e85c:#78c3f3:#f2afee:#6adcc5:#ffffff'
COLORS
