#!/bin/sh
# {{ scheme_name }}
printf "\033]4;0;#{{ Ansi_0_Color.hex }};1;#{{ Ansi_1_Color.hex }};2;#{{ Ansi_2_Color.hex }};3;#{{ Ansi_3_Color.hex }};4;#{{ Ansi_4_Color.hex }};5;#{{ Ansi_5_Color.hex }};6;#{{ Ansi_6_Color.hex }};7;#{{ Ansi_7_Color.hex }};8;#{{ Ansi_8_Color.hex }};9;#{{ Ansi_9_Color.hex }};10;#{{ Ansi_10_Color.hex }};11;#{{ Ansi_11_Color.hex }};12;#{{ Ansi_12_Color.hex }};13;#{{ Ansi_13_Color.hex }};14;#{{ Ansi_14_Color.hex }};15;#{{ Ansi_15_Color.hex }}\007"
printf "\033]10;#{{ Foreground_Color.hex }};#{{ Background_Color.hex }};#{{ Cursor_Color.hex }}\007"
{% if Selection_Color %}
printf "\033]17;#{{ Selection_Color.hex }}\007"
{% endif %}
{% if Selected_Text_Color %}
printf "\033]19;#{{ Selected_Text_Color.hex }}\007"
{% endif %}
{% if Bold_Color %}
printf "\033]5;0;#{{ Bold_Color.hex }}\007"
{% endif %}