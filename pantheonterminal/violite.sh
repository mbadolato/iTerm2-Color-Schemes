#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='violite'
cursor-color='#eef4f6'
foreground='#eef4f6'
background='rgba(36,28,54,.95)'
palette='#241c36:#ec7979:#79ecb3:#ece279:#a979ec:#ec79ec:#79ecec:#eef4f6:#49376d:#ef8f8f:#9fefbf:#efe78f:#b78fef:#ef8fcf:#9fefef:#f8fafc'
COLORS
