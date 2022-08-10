#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='{{ scheme_name }}'
cursor-color='#{{ Cursor_Color.hex }}'
foreground='#{{ Foreground_Color.hex }}'
background='rgba({{ Background_Color.rgb }},.95)'
palette='#{{ Ansi_0_Color.hex }}:#{{ Ansi_1_Color.hex }}:#{{ Ansi_2_Color.hex }}:#{{ Ansi_3_Color.hex }}:#{{ Ansi_4_Color.hex }}:#{{ Ansi_5_Color.hex }}:#{{ Ansi_6_Color.hex }}:#{{ Ansi_7_Color.hex }}:#{{ Ansi_8_Color.hex }}:#{{ Ansi_9_Color.hex }}:#{{ Ansi_10_Color.hex }}:#{{ Ansi_11_Color.hex }}:#{{ Ansi_12_Color.hex }}:#{{ Ansi_13_Color.hex }}:#{{ Ansi_14_Color.hex }}:#{{ Ansi_15_Color.hex }}'
COLORS
