FROM alpine:3.12

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apk update 

RUN apk add git curl bash sudo python3

RUN git clone https://github.com/vitasdk-softfp/vdpm.git --depth=1 && \
    cd vdpm/ && chmod +x ./*.sh && \
    ./bootstrap-vitasdk.sh && ./install-all.sh && cd .. && rm -fr vdpm/

# Second stage of Dockerfile
FROM alpine:3.12

COPY --from=0 ${VITASDK} ${VITASDK}

ARG USER=vitasdk
ENV HOME /home/$USER

# install sudo as root
RUN apk add --no-cache sudo

# add new user
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME
