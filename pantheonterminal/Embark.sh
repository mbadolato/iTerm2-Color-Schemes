#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Embark'
cursor-color='#a1efd3'
foreground='#eeffff'
background='rgba(30,28,49,.95)'
palette='#1e1c31:#f0719b:#a1efd3:#ffe9aa:#57c7ff:#c792ea:#87dfeb:#f8f8f2:#585273:#f02e6e:#2ce592:#ffb378:#1da0e2:#a742ea:#63f2f1:#a6b3cc'
COLORS
