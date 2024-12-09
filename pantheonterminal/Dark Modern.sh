#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Dark Modern'
cursor-color='#ffffff'
foreground='#cccccc'
background='rgba(31,31,31,.95)'
palette='#272727:#f74949:#2ea043:#9e6a03:#0078d4:#d01273:#1db4d6:#cccccc:#5d5d5d:#dc5452:#23d18b:#f5f543:#3b8eea:#d670d6:#29b8db:#e5e5e5'
COLORS
