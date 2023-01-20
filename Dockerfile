FROM ubuntu:22.04

RUN apt-get update \
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
    && apt-get purge -y g++ wget make libssl-dev python3 re2c \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/* /usr/bin/python
