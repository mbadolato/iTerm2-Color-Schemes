#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Claude'
cursor-color='#d97757'
foreground='#141413'
background='rgba(250,249,245,.95)'
palette='#c15f3c:#788c5d:#b16803:#6a9bcc:#8b6cb0:#2e8b8b:#b5b3a9:#3d3d3c:#d97757:#8fa86b:#d4952b:#7bafd4:#a080c8:#4eaaaa:#bab9b5:#141413'
COLORS
