FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install curl g++ make libssl-dev re2c \
    && curl -OL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3.tar.gz \
    && tar xf cmake-3.28.3.tar.gz \
    && cd cmake-3.28.3 \
    && ./bootstrap \
    && make -j`nproc` \
    && make install \
    && cd .. \
    && rm -fr cmake-3.28.3* \
    && curl -OL https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.1.tar.gz \
    && tar xf v1.11.1.tar.gz \
    && cd ninja-1.11.1/ \
    && cmake -B build-cmake \
    && cmake --build build-cmake \
    && cmake --install ./build-cmake \
    && cd .. \
    && rm -fr ninja-1.11.1/ v1.11.1.tar.gz \
    && apt-get purge -y curl make libssl-dev re2c \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/*
