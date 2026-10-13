#!/bin/sh
# Yngwie's Strat

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
put_template 0  "34/2d/27"
put_template 1  "9c/29/22"
put_template 2  "37/66/3e"
put_template 3  "78/50/15"
put_template 4  "24/4f/85"
put_template 5  "67/41/6c"
put_template 6  "17/61/6b"
put_template 7  "3e/37/30"
put_template 8  "51/46/3b"
put_template 9  "b0/39/2b"
put_template 10 "3b/6d/45"
put_template 11 "84/5b/16"
put_template 12 "31/5e/9c"
put_template 13 "79/50/80"
put_template 14 "20/6f/79"
put_template 15 "27/25/22"

color_foreground="25/23/1f"
color_background="fb/e6/8b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "25231f"
  put_template_custom Ph "fbe68b"
  put_template_custom Pi "29241d"
  put_template_custom Pj "b6a251"
  put_template_custom Pk "211e19"
  put_template_custom Pl "9c2922"
  put_template_custom Pm "fff2bd"
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
