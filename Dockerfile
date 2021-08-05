FROM archlinux:base-devel
ENV TZ=Europe/London
# Install required toolchain libraries (thanks https://openwrt.org/docs/guide-developer/build-system/install-buildsystem)
# Commented out packages appear to already be cooked into the archlinux:base-devel image
RUN echo "[multilib]" >> /etc/pacman.conf \
    && echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && pacman --noconfirm -Syy \
    lib32-glibc \
    lib32-zlib \
    git \
    cmake \
    time \
    subversion \
#     openssl \
#     patch \
#     ncurses \
#     zlib \dd
#     gawk \
#     flex \
#     gettext \
    wget \
    unzip \
#     xz \
    python2 \
    python3 \
    rsync \
#     curl \
    net-snmp \
#     pam \
    cpio \
    bc \
	inetutils

RUN useradd -m user \
        && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user \
        && mkdir -p /to_build \
        && chown -R user:user /to_build \
        && chmod -R g+rwx /to_build \
        && git config --global user.name "user" && git config --global user.email "user@example.com"

COPY --chown=user:user ./toolchains /toolchains
ARG TOOLCHAIN=rsdk-4.8.5-5281-EL-3.10-u0.9.33-m32fut-161202
# ARG TOOLCHAIN=rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-180611
RUN cd /toolchains \
    && chmod +x activate.sh \
    && tar xvzf ${TOOLCHAIN}.tar.gz \
    && rm -rf *.tar.gz \
    && mv ${TOOLCHAIN} sdk \
    && ls -al /toolchains
ADD files/activate-generic-toolchain.env /toolchains/sdk/activate
COPY --chown=user:user ./files/bashrc /home/user/.bashrc

RUN chmod +x /toolchains/sdk/activate
USER user
WORKDIR /home/user
ENTRYPOINT ["/bin/bash"]
