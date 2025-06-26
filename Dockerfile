FROM debian

# Add both unstable and experimental repos
RUN echo "deb http://deb.debian.org/debian unstable main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian unstable main" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian experimental main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian experimental main" >> /etc/apt/sources.list && \
    echo 'Package: *\n\
Pin: release a=unstable\n\
Pin-Priority: 500\n\
\n\
Package: *\n\
Pin: release a=experimental\n\
Pin-Priority: 100\n\
\n\
Package: neovim*\n\
Pin: release a=experimental\n\
Pin-Priority: 1000\n\
\n\
Package: libtree-sitter0*\n\
Pin: release a=experimental\n\
Pin-Priority: 1000\n\
\n\
Package: libc6*\n\
Pin: release a=unstable\n\
Pin-Priority: 1000\n\
\n\
Package: base-files*\n\
Pin: release a=unstable\n\
Pin-Priority: 1000' > /etc/apt/preferences.d/pinning

RUN apt-get update && \
    apt-get install -y \
    base-files \
    libc6 \
    libtree-sitter0 && \
    apt-get install -y \
    neovim \
    git \
    gcc \
    clangd \
    python3-pynvim \
    xclip \
    xxd \
    bash-completion && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set neovim as default editor
ENV EDITOR=nvim

CMD ["bash"]