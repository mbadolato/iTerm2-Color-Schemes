#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='GitLab-Light'
cursor-color='#303030'
foreground='#303030'
background='rgba(250,250,255,.95)'
palette='#303030:#a31700:#0a7f3d:#af551d:#006cd8:#583cac:#00798a:#303030:#303030:#a31700:#0a7f3d:#af551d:#006cd8:#583cac:#00798a:#303030'
COLORS
