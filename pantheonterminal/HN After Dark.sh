#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='HN After Dark'
cursor-color='#ff6600'
foreground='#f6f6ef'
background='rgba(24,24,24,.95)'
palette='#858585:#ff765c:#65c878:#e5b94d:#5599ff:#c27acb:#53c5e8:#dddddd:#929292:#ff916f:#85dc94:#f2d17b:#83b7ff:#d89ce0:#78dbee:#ffffff'
COLORS
