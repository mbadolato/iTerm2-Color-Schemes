#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Hacktober'
cursor-color='#c9c9c9'
foreground='#c9c9c9'
background='rgba(20,20,20,.95)'
palette='#191918:#b34538:#587744:#d08949:#206ec5:#864651:#ac9166:#f1eee7:#2c2b2a:#b33323:#42824a:#c75a22:#5389c5:#e795a5:#ebc587:#ffffff'
COLORS
