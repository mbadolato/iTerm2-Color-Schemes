#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='DimmedMonokai'
cursor-color='#f83e19'
foreground='#b9bcba'
background='rgba(31,31,31,.95)'
palette='#3a3d43:#be3f48:#879a3b:#c5a635:#4f76a1:#855c8d:#578fa4:#b9bcba:#888987:#fb001f:#0f722f:#c47033:#186de3:#fb0067:#2e706d:#fdffb9'
COLORS
