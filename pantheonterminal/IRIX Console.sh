#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='IRIX Console'
cursor-color='#c7c7c7'
foreground='#f2f2f2'
background='rgba(12,12,12,.95)'
palette='#1a1919:#d42426:#37a327:#c29d28:#0739e2:#911f9c:#4497df:#cccccc:#767676:#f34f59:#45c731:#f9f2a7:#4079ff:#c31ba2:#6ed7d7:#f2f2f2'
COLORS
