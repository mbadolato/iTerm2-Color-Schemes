#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='MaterialDesignColors'
cursor-color='#eaeaea'
foreground='#e7ebed'
background='rgba(29,38,42,.95)'
palette='#435b67:#fc3841:#5cf19e:#fed032:#37b6ff:#fc226e:#59ffd1:#ffffff:#a1b0b8:#fc746d:#adf7be:#fee16c:#70cfff:#fc669b:#9affe6:#ffffff'
COLORS
