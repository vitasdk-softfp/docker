FROM ubuntu:26.04

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH
ENV PARSECOREPATH /usr/local/vita-parse-core/main.py

RUN apt-get update && apt-get install -y bash make pkgconf curl fakeroot libarchive-tools file xz-utils cmake sudo git python3 python3-pip bzip2 wget netcat-openbsd

RUN git clone https://github.com/vitasdk-softfp/vdpm.git --depth=1 && \
    cd vdpm/ && chmod +x ./*.sh && \
    ./bootstrap-vitasdk.sh && ./install-all.sh && cd .. && rm -fr vdpm/

RUN git clone https://github.com/xyzz/vita-parse-core /usr/local/vita-parse-core --depth=1 && \
    python3 -m pip install -r /usr/local/vita-parse-core/requirements.txt --break-system-packages
