#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='idea'
cursor-color='#bbbbbb'
foreground='#adadad'
background='rgba(32,32,32,.95)'
palette='#adadad:#fc5256:#98b61c:#ccb444:#437ee7:#9d74b0:#248887:#181818:#ffffff:#fc7072:#98b61c:#ffff0b:#6c9ced:#fc7eff:#248887:#181818'
COLORS
