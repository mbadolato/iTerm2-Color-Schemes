#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='CRT Afterglow'
cursor-color='#f4d35e'
foreground='#d0d8c8'
background='rgba(11,15,11,.95)'
palette='#203020:#ff5f56:#50fa7b:#f1fa8c:#8be9fd:#bd93f9:#5af78e:#95a99b:#4a5d4a:#ff8a80:#8aff9d:#fff59d:#b3f1ff:#dda0ff:#8affd8:#f5f7ef'
COLORS
