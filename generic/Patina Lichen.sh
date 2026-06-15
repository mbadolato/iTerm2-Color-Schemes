#!/bin/sh
# Patina Lichen

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "39/3a/34"
put_template 1  "8b/46/46"
put_template 2  "33/64/4d"
put_template 3  "7f/50/31"
put_template 4  "35/61/6d"
put_template 5  "85/4b/3f"
put_template 6  "2a/63/61"
put_template 7  "5a/52/48"
put_template 8  "5b/5b/54"
put_template 9  "8b/46/46"
put_template 10 "42/63/38"
put_template 11 "7f/50/31"
put_template 12 "35/61/6d"
put_template 13 "85/4b/3f"
put_template 14 "2a/63/61"
put_template 15 "39/3a/34"

color_foreground="39/3a/34"
color_background="cd/d1/c6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "393a34"
  put_template_custom Ph "cdd1c6"
  put_template_custom Pi "393a34"
  put_template_custom Pj "aab0a3"
  put_template_custom Pk "393a34"
  put_template_custom Pl "393a34"
  put_template_custom Pm "cdd1c6"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
