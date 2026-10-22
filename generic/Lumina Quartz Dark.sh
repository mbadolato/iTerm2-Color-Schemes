#!/bin/sh
# Lumina Quartz Dark

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
put_template 0  "1f/20/21"
put_template 1  "d9/6e/66"
put_template 2  "b9/da/aa"
put_template 3  "dd/bb/67"
put_template 4  "9c/c2/f4"
put_template 5  "e2/a9/dd"
put_template 6  "95/e0/e8"
put_template 7  "ad/b0/b4"
put_template 8  "82/89/8f"
put_template 9  "e5/91/89"
put_template 10 "cb/f8/b6"
put_template 11 "f9/d5/7d"
put_template 12 "c0/db/ff"
put_template 13 "fe/c2/f8"
put_template 14 "ac/f7/ff"
put_template 15 "cd/d0/d4"

color_foreground="cd/d0/d4"
color_background="1a/1b/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cdd0d4"
  put_template_custom Ph "1a1b1c"
  put_template_custom Pi "cdd0d4"
  put_template_custom Pj "403b54"
  put_template_custom Pk "cdd0d4"
  put_template_custom Pl "cdd0d4"
  put_template_custom Pm "1a1b1c"
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
