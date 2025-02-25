#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Apple System Colors Light'
cursor-color='#98989d'
foreground='#000000'
background='rgba(254,255,255,.95)'
palette='#1a1a1a:#bc4437:#51a148:#c7ad3a:#2e68c5:#8c4bb8:#5e9cbe:#98989d:#464646:#eb5545:#6bd45f:#f8d84a:#3b82f7:#b260ea:#8dd3fb:#ffffff'
COLORS
