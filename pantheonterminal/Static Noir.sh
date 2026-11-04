#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Static Noir'
cursor-color='#ff3b30'
foreground='#ededed'
background='rgba(10,10,10,.95)'
palette='#1a1a1a:#ff4d42:#9fd08a:#e6c15c:#7fb2e8:#d093d0:#74cfd1:#c9c9c9:#666666:#ff6e64:#b7e2a3:#f2d47c:#9dc7f2:#e0aede:#93e1e2:#ffffff'
COLORS
