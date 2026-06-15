FROM python:3.11-slim

# Install Python requirements at build time
COPY requirements.txt .python-version /tmp/

RUN pip install --upgrade pip \
 && pip install -r /tmp/requirements.txt \
 && rm -rf /root/.cache/pip

WORKDIR /colors

ENTRYPOINT ["/bin/bash", "-c", "cd /colors/tools && python -m gen && python -m screenshot_gen && python ./generate_screenshots_readme.py"]
