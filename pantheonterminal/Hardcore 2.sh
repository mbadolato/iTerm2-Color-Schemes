#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Hardcore'
cursor-color='#bbbbbb'
foreground='#a0a0a0'
background='rgba(18,18,18,.95)'
palette='#1b1d1e:#f92672:#a6e22e:#fd971f:#66d9ef:#9e6ffe:#5e7175:#ccccc6:#505354:#ff669d:#beed5f:#e6db74:#66d9ef:#9e6ffe:#a3babf:#f8f8f2'
COLORS
