#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Peppermint'
cursor-color='#bbbbbb'
foreground='#c8c8c8'
background='rgba(0,0,0,.95)'
palette='#353535:#e74669:#89d287:#dab853:#449fd0:#da62dc:#65aaaf:#b4b4b4:#535353:#e4859b:#a3cca2:#e1e487:#6fbce2:#e586e7:#96dcdb:#dfdfdf'
COLORS
