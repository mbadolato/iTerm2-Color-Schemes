#!/bin/sh
# Kurokula

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
put_template 0  "33/33/33"
put_template 1  "c3/5a/52"
put_template 2  "78/b3/a9"
put_template 3  "e1/b9/17"
put_template 4  "5c/91/dd"
put_template 5  "8b/79/a6"
put_template 6  "86/72/68"
put_template 7  "e0/cf/c2"
put_template 8  "51/51/51"
put_template 9  "ff/c3/4c"
put_template 10 "af/ff/a5"
put_template 11 "ff/f7/00"
put_template 12 "90/db/ff"
put_template 13 "ad/93/ff"
put_template 14 "ff/cd/b6"
put_template 15 "ff/ff/ff"

color_foreground="e0/cf/c2"
color_background="14/15/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0cfc2"
  put_template_custom Ph "141515"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "515151"
  put_template_custom Pk "ffc34c"
  put_template_custom Pl "7a1c1c"
  put_template_custom Pm "fffbf2"
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
