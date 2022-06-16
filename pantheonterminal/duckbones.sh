#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='duckbones'
cursor-color='#edf2c2'
foreground='#ebefc0'
background='rgba(14,16,26,.95)'
palette='#0e101a:#e03600:#5dcd97:#e39500:#00a3cb:#795ccc:#00a3cb:#ebefc0:#2b2f46:#ff4821:#58db9e:#f6a100:#00b4e0:#b3a1e6:#00b4e0:#b3b692'
COLORS
