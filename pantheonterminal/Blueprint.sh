#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Blueprint'
cursor-color='#ff5a1f'
foreground='#0f172a'
background='rgba(248,250,252,.95)'
palette='#0f172a:#dc2626:#16a34a:#d97706:#2563eb:#7c3aed:#0891b2:#94a3b8:#475569:#ef4444:#22c55e:#f59e0b:#3b82f6:#a855f7:#06b6d4:#1e293b'
COLORS
