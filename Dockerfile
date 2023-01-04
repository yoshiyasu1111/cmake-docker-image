FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y g++ wget make libssl-dev \
    && wget https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1.tar.gz \
    && tar xzf cmake-3.25.1.tar.gz \
    && cd cmake-3.25.1 \
    && ./bootstrap \
    && make -j`nproc` \
    && make install \
    && cd .. \
    && rm -fr cmake-3.25.1* \
    && apt-get purge -y g++ wget make libssl-dev \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/*
