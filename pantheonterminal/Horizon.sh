#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Horizon'
cursor-color='#6c6f93'
foreground='#d5d8da'
background='rgba(28,30,38,.95)'
palette='#000000:#e95678:#29d398:#fab795:#26bbd9:#ee64ac:#59e1e3:#e5e5e5:#666666:#ec6a88:#3fdaa4:#fbc3a7:#3fc4de:#f075b5:#6be4e6:#e5e5e5'
COLORS
