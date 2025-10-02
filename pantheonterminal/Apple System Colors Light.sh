#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Apple System Colors Light'
cursor-color='#98989d'
foreground='#000000'
background='rgba(254,255,255,.95)'
palette='#1a1a1a:#cc372e:#26a439:#cdac08:#0869cb:#9647bf:#479ec2:#98989d:#464646:#ff453a:#32d74b:#edbb00:#0a84ff:#bf5af2:#3accf7:#ffffff'
COLORS
