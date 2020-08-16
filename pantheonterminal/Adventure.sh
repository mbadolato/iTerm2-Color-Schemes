#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Adventure'
cursor-color='#feffff'
foreground='#feffff'
background='rgba(4,4,4,.95)'
palette='#040404:#d84a33:#5da602:#eebb6e:#417ab3:#e5c499:#bdcfe5:#dbded8:#685656:#d76b42:#99b52c:#ffb670:#97d7ef:#aa7900:#bdcfe5:#e4d5c7'
COLORS
