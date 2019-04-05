#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Atom'
cursor-color='#d0d0d0'
foreground='#c5c8c6'
background='rgba(22,23,25,.95)'
palette='#000000:#fd5ff1:#87c38a:#ffd7b1:#85befd:#b9b6fc:#85befd:#e0e0e0:#000000:#fd5ff1:#94fa36:#f5ffa8:#96cbfe:#b9b6fc:#85befd:#e0e0e0'
COLORS
