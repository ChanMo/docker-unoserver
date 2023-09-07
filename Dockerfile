FROM ubuntu:22.04
MAINTAINER Chan Mo <chan.mo@outlook.com>

COPY sources.list /etc/apt/sources.list
WORKDIR /app

# Libreoffce
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:libreoffice/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends libreoffice && \
    apt-get remove -y --auto-remove software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Some additional MS fonts for better WMF conversion
COPY fonts/* /usr/share/fonts/
RUN fc-cache -f -v

COPY get-pip.py .
RUN python3 get-pip.py
RUN python3 -m pip install unoserver flask gunicorn

EXPOSE 5000

COPY app.py .

ADD start.sh /

CMD ["/start.sh"]
