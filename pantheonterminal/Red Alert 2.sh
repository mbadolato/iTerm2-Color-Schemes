#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Red Alert'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(118,36,35,.95)'
palette='#000000:#d62e4e:#71be6b:#beb86b:#489bee:#e979d7:#6bbeb8:#d6d6d6:#262626:#e02553:#aff08c:#dfddb7:#65aaf1:#ddb7df:#b7dfdd:#ffffff'
COLORS
