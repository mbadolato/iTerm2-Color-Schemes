#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='nord'
cursor-color='#eceff4'
foreground='#d8dee9'
background='rgba(46,52,64,.95)'
palette='#3b4252:#bf616a:#a3be8c:#ebcb8b:#81a1c1:#b48ead:#88c0d0:#e5e9f0:#4c566a:#bf616a:#a3be8c:#ebcb8b:#81a1c1:#b48ead:#8fbcbb:#eceff4'
COLORS
