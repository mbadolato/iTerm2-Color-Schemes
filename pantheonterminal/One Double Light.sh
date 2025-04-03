#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='One Double Light'
cursor-color='#1a1a1a'
foreground='#383a42'
background='rgba(250,250,250,.95)'
palette='#464b57:#e45649:#50a14f:#c18401:#0184bc:#a626a4:#0997b3:#e8d9d9:#0f131e:#f24c2d:#3db637:#e09d00:#2e63d6:#d21fd1:#06b1d8:#ffffff'
COLORS
