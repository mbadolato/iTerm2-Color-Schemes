#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Cursor Dark'
cursor-color='#d4d4d4'
foreground='#d4d4d4'
background='rgba(20,20,20,.95)'
palette='#242424:#fc6b83:#3fa266:#d2943e:#81a1c1:#b48ead:#88c0d0:#e4e4e4:#4a4a4a:#fc6b83:#70b489:#f1b467:#87a6c4:#b48ead:#88c0d0:#e4e4e4'
COLORS
