#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Redacted'
cursor-color='#202020'
foreground='#171717'
background='rgba(255,253,248,.95)'
palette='#292929:#821e1e:#125b31:#654b00:#17458d:#5e2e86:#005766:#393939:#464646:#8d2424:#176238:#6c5000:#123a78:#66368e:#004a57:#414141'
COLORS
