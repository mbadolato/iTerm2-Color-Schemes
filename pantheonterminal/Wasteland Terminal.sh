#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Wasteland Terminal'
cursor-color='#39ff72'
foreground='#18ff62'
background='rgba(5,11,5,.95)'
palette='#050b05:#26b34f:#18ff62:#a1d64b:#3e9b67:#64b879:#60e899:#b5ffc5:#2c6b3f:#3fd068:#5cff8f:#c4ee70:#56bd84:#84d69a:#8cf5b8:#e0ffe6'
COLORS
