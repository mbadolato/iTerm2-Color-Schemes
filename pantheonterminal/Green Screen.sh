#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Green Screen'
cursor-color='#8af0b4'
foreground='#dff7e8'
background='rgba(3,16,9,.95)'
palette='#a9bdb0:#ed8087:#70d19c:#e5cc69:#82b3e7:#c99fdf:#70d2ce:#dff7e8:#c0cec5:#f09ba1:#90dfb4:#ecdc8b:#a1c8ef:#d9bae8:#92e1dc:#f6fff9'
COLORS
