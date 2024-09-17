#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='gruber-darker'
cursor-color='#ffdd33'
foreground='#e4e4e4'
background='rgba(24,24,24,.95)'
palette='#181818:#f43841:#73d936:#ffdd33:#96a6c8:#9e95c7:#95a99f:#e4e4e4:#52494e:#ff4f58:#73d936:#ffdd33:#96a6c8:#afafd7:#95a99f:#f5f5f5'
COLORS
