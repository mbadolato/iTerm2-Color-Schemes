#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Chalk'
cursor-color='#708284'
foreground='#d2d8d9'
background='rgba(43,45,46,.95)'
palette='#7d8b8f:#b23a52:#789b6a:#b9ac4a:#2a7fac:#bd4f5a:#44a799:#d2d8d9:#888888:#f24840:#80c470:#ffeb62:#4196ff:#fc5275:#53cdbd:#d2d8d9'
COLORS
