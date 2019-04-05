#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Square'
cursor-color='#fcfbcc'
foreground='#acacab'
background='rgba(26,26,26,.95)'
palette='#050505:#e9897c:#b6377d:#ecebbe:#a9cdeb:#75507b:#c9caec:#f2f2f2:#141414:#f99286:#c3f786:#fcfbcc:#b6defb:#ad7fa8:#d7d9fc:#e2e2e2'
COLORS
