#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='NvimDark'
cursor-color='#62656b'
foreground='#e0e2ea'
background='rgba(20,22,27,.95)'
palette='#07080d:#ffc0b9:#b3f6c0:#fce094:#a6dbff:#ffcaff:#8cf8f7:#eef1f8:#62656b:#ffc0b9:#b3f6c0:#fce094:#a6dbff:#ffcaff:#8cf8f7:#eef1f8'
COLORS
