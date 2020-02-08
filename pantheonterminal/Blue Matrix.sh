#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Blue Matrix'
cursor-color='#76ff9f'
foreground='#00a2ff'
background='rgba(16,17,22,.95)'
palette='#101116:#ff5680:#00ff9c:#fffc58:#00b0ff:#d57bff:#76c1ff:#c7c7c7:#686868:#ff6e67:#5ffa68:#fffc67:#6871ff:#d682ec:#60fdff:#ffffff'
COLORS
