#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='electron-highlighter'
cursor-color='#a5b6d4'
foreground='#a5b6d4'
background='rgba(35,40,61,.95)'
palette='#15161f:#ff6c8d:#00ffc3:#ffd7a9:#77abff:#daa4f4:#00fdff:#778faf:#4a6789:#ff6c8d:#00ffc3:#ffd7a9:#77abff:#daa4f4:#00fdff:#c3cee2'
COLORS
