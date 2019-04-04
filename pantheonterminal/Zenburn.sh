#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Zenburn'
cursor-color='#73635a'
foreground='#dcdccc'
background='rgba(63,63,63,.95)'
palette='#4d4d4d:#705050:#60b48a:#f0dfaf:#506070:#dc8cc3:#8cd0d3:#dcdccc:#709080:#dca3a3:#c3bf9f:#e0cf9f:#94bff3:#ec93d3:#93e0e3:#ffffff'
COLORS
