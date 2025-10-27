#!/bin/sh
# No Clown Fiesta Light

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
put_template 0  "d6/d6/d6"
put_template 1  "87/4e/42"
put_template 2  "67/79/40"
put_template 3  "b8/90/58"
put_template 4  "8b/a1/bf"
put_template 5  "aa/75/9f"
put_template 6  "3e/5f/66"
put_template 7  "15/15/15"
put_template 8  "2b/2b/2b"
put_template 9  "63/77/86"
put_template 10 "67/79/40"
put_template 11 "b8/90/58"
put_template 12 "93/a2/ab"
put_template 13 "aa/75/9f"
put_template 14 "99/ab/93"
put_template 15 "37/37/37"

color_foreground="15/15/15"
color_background="e1/e1/e1"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "151515"
  put_template_custom Ph "e1e1e1"
  put_template_custom Pi "151515"
  put_template_custom Pj "c6d5de"
  put_template_custom Pk "151515"
  put_template_custom Pl "151515"
  put_template_custom Pm "d0d0d0"
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
