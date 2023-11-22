#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Apple System Colors'
cursor-color='#98989d'
foreground='#ffffff'
background='rgba(30,30,30,.95)'
palette='#1a1a1a:#cc372e:#26a439:#cdac08:#0869cb:#9647bf:#479ec2:#98989d:#464646:#ff453a:#32d74b:#ffd60a:#0a84ff:#bf5af2:#76d6ff:#ffffff'
COLORS
