#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='zenwritten_dark'
cursor-color='#c9c9c9'
foreground='#bbbbbb'
background='rgba(25,25,25,.95)'
palette='#191919:#de6e7c:#819b69:#b77e64:#6099c0:#b279a7:#66a5ad:#bbbbbb:#3d3839:#e8838f:#8bae68:#d68c67:#61abda:#cf86c1:#65b8c1:#8e8e8e'
COLORS
