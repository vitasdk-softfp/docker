FROM ubuntu:26.04

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apt-get update && apt install -y git curl bash sudo python3 bzip2 wget xz-utils

RUN git clone https://github.com/vitasdk-softfp/vdpm.git --depth=1 && \
    cd vdpm/ && chmod +x ./*.sh && \
    ./bootstrap-vitasdk.sh && ./install-all.sh && cd .. && rm -fr vdpm/

# Second stage of Dockerfile
FROM ubuntu:26.04

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apt-get update && apt-get install -y bash make pkgconf curl fakeroot libarchive-tools file xz-utils cmake sudo git python3 bzip2 wget

RUN useradd user &&\
    echo "export VITASDK=${VITASDK}" > /etc/profile.d/vitasdk.sh && \
    echo 'export PATH=$PATH:$VITASDK/bin'  >> /etc/profile.d/vitasdk.sh

COPY --from=0 --chown=user ${VITASDK} ${VITASDK}
