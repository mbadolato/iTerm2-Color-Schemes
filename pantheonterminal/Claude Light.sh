#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Claude Light'
cursor-color='#d97757'
foreground='#141413'
background='rgba(250,249,245,.95)'
palette='#0a0a0a:#a84b3a:#2e7c4c:#8a6220:#184e95:#882b4d:#066049:#b6b5aa:#51504d:#e34a4a:#639900:#b87700:#3886e5:#d55382:#199f70:#e2e1da'
COLORS
