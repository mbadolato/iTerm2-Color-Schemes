#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='iceberg-light'
cursor-color='#33374c'
foreground='#33374c'
background='rgba(232,233,236,.95)'
palette='#dcdfe7:#cc517a:#668e3d:#c57339:#2d539e:#7759b4:#3f83a6:#33374c:#8389a3:#cc3768:#598030:#b6662d:#22478e:#6845ad:#327698:#262a3f'
COLORS
