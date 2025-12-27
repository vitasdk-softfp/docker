FROM alpine:latest

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apk update 

RUN apk add git curl bash sudo

RUN git clone https://github.com/vitasdk-softfp/vdpm.git --depth=1 && \
    cd vdpm/ && chmod +x ./*.sh && \
    ./bootstrap-vitasdk.sh && ./install-all.sh && cd .. && rm -fr vdpm/

# Second stage of Dockerfile
FROM alpine:latest

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apk add --no-cache bash make pkgconf curl fakeroot libarchive-tools file xz cmake sudo git

RUN adduser -D user &&\
    echo "export VITASDK=${VITASDK}" > /etc/profile.d/vitasdk.sh && \
    echo 'export PATH=$PATH:$VITASDK/bin'  >> /etc/profile.d/vitasdk.sh

COPY --from=0 --chown=user ${VITASDK} ${VITASDK}
