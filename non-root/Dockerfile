FROM ubuntu:26.04

ENV VITASDK /usr/local/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

RUN apt-get update && apt install -y git curl bash sudo python3 bzip2 wget xz-utils

RUN git clone https://github.com/vitasdk-softfp/vdpm.git --depth=1 && \
    cd vdpm/ && chmod +x ./*.sh && \
    ./bootstrap-vitasdk.sh && ./install-all.sh && cd .. && rm -fr vdpm/

# Second stage of Dockerfile
FROM ubuntu:26.04

COPY --from=0 ${VITASDK} ${VITASDK}

ARG USER=vitasdk
ENV HOME /home/$USER

# install sudo as root
RUN apt-get update && apt-get install -y sudo

# add new user
RUN useradd $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME
