#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='moonfly'
cursor-color='#9e9e9e'
foreground='#bdbdbd'
background='rgba(8,8,8,.95)'
palette='#323437:#ff5454:#8cc85f:#e3c78a:#80a0ff:#cf87e8:#79dac8:#c6c6c6:#949494:#ff5189:#36c692:#c6c684:#74b2ff:#ae81ff:#85dc85:#e4e4e4'
COLORS
