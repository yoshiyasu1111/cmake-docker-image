FROM ubuntu:22.04

RUN perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://linux.yz.yamagata-u.ac.jp/pub/linux/ubuntu/archives/%' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y g++ wget make libssl-dev python3 re2c \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && wget https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1.tar.gz \
    && tar xzf cmake-3.25.1.tar.gz \
    && cd cmake-3.25.1 \
    && ./bootstrap \
    && make -j`nproc` \
    && make install \
    && cd .. \
    && rm -fr cmake-3.25.1* \
    && wget https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.1.tar.gz \
    && tar xzf v1.11.1.tar.gz \
    && cd ninja-1.11.1/ \
    && ./configure.py --bootstrap \
    && mv ninja /usr/local/bin/ \
    && cd .. \
    && rm -fr ninja-1.11.1/ v1.11.1.tar.gz \
    && apt-get purge -y g++ wget make libssl-dev \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/*
