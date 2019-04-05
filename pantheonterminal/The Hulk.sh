#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='The Hulk'
cursor-color='#16b61b'
foreground='#b5b5b5'
background='rgba(27,29,30,.95)'
palette='#1b1d1e:#269d1b:#13ce30:#63e457:#2525f5:#641f74:#378ca9:#d9d8d1:#505354:#8dff2a:#48ff77:#3afe16:#506b95:#72589d:#4085a6:#e5e6e1'
COLORS
