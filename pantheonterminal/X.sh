#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='X'
cursor-color='#f7f1ff'
foreground='#f7f1ff'
background='rgba(5,5,5,.95)'
palette='#0a0a0a:#fc618d:#7bd88f:#fce566:#fd9353:#948ae3:#5ad4e6:#f7f1ff:#424242:#fc618d:#7bd88f:#fce566:#fd9353:#948ae3:#5ad4e6:#f7f1ff'
COLORS
