#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Coffee Theme'
cursor-color='#a1a1a1'
foreground='#000000'
background='rgba(245,222,179,.95)'
palette='#000000:#c91b00:#00c200:#adaa00:#0225c7:#ca30c7:#00b8ba:#a1a1a1:#686868:#ff6e67:#1fba28:#b2af1b:#6871ff:#f26af2:#20bdbf:#ffffff'
COLORS
