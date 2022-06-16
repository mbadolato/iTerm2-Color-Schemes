#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='zenburned'
cursor-color='#f3eadb'
foreground='#f0e4cf'
background='rgba(64,64,64,.95)'
palette='#404040:#e3716e:#819b69:#b77e64:#6099c0:#b279a7:#66a5ad:#f0e4cf:#625a5b:#ec8685:#8bae68:#d68c67:#61abda:#cf86c1:#65b8c1:#c0ab86'
COLORS
