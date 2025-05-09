#!/bin/sh
# srcery

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
put_template 0  "1c/1b/19"
put_template 1  "ef/2f/27"
put_template 2  "51/9f/50"
put_template 3  "fb/b8/29"
put_template 4  "2c/78/bf"
put_template 5  "e0/2c/6d"
put_template 6  "0a/ae/b3"
put_template 7  "ba/a6/7f"
put_template 8  "91/81/75"
put_template 9  "f7/53/41"
put_template 10 "98/bc/37"
put_template 11 "fe/d0/6e"
put_template 12 "68/a8/e4"
put_template 13 "ff/5c/8f"
put_template 14 "2b/e4/d0"
put_template 15 "fc/e8/c3"

color_foreground="fc/e8/c3"
color_background="1c/1b/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fce8c3"
  put_template_custom Ph "1c1b19"
  put_template_custom Pi "fce8c3"
  put_template_custom Pj "fce8c3"
  put_template_custom Pk "1c1b19"
  put_template_custom Pl "fbb829"
  put_template_custom Pm "1c1b19"
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
