#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='primary'
cursor-color='#000000'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#db4437:#0f9d58:#f4b400:#4285f4:#db4437:#4285f4:#ffffff:#000000:#db4437:#0f9d58:#f4b400:#4285f4:#4285f4:#0f9d58:#ffffff'
COLORS
