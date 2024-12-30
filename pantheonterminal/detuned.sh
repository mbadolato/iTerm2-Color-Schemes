#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='detuned'
cursor-color='#c7c7c7'
foreground='#c7c7c7'
background='rgba(0,0,0,.95)'
palette='#171717:#ea5386:#b3e153:#e4da81:#4192d3:#8f3ef6:#6cb4d5:#c7c7c7:#686868:#ea86ac:#c5e280:#fdf38f:#55bbf9:#b9a0f9:#7fd4fb:#ffffff'
COLORS
