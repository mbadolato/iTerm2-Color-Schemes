FROM python:latest

COPY .python-version requirements.txt /colors/

RUN cd /colors/ \
 && curl -fsSL https://pyenv.run | bash \
 && export PYENV_ROOT="$HOME/.pyenv" \
 && [ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH" \
 && eval "$(pyenv init - bash)" \
 && pyenv install

 ENTRYPOINT [ "/bin/bash" ]
