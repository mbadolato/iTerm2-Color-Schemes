FROM python:latest

COPY .python-version requirements.txt /colors/

RUN cd /colors/ \
 && pip install --upgrade pip \
 && pip install -r requirements.txt \
;

 ENTRYPOINT [ "/bin/bash" ]
