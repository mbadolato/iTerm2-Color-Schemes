#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='ayu_light'
cursor-color='#ff6a00'
foreground='#5c6773'
background='rgba(250,250,250,.95)'
palette='#000000:#ff3333:#86b300:#f29718:#41a6d9:#f07178:#4dbf99:#ffffff:#323232:#ff6565:#b8e532:#ffc94a:#73d8ff:#ffa3aa:#7ff1cb:#ffffff'
COLORS
