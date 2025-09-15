#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Starlight'
cursor-color='#ffffff'
foreground='#ffffff'
background='rgba(36,36,36,.95)'
palette='#242424:#f62b5a:#47b413:#e3c401:#24acd4:#f2affd:#13c299:#e6e6e6:#616161:#ff4d51:#35d450:#e9e836:#5dc5f8:#feabf2:#24dfc4:#ffffff'
COLORS
