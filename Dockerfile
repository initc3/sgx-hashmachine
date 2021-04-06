FROM initc3/linux-sgx:2.13-ubuntu20.04

RUN apt-get update && apt-get install -y \
                autotools-dev \
                automake \
                xxd \
                iputils-ping \
                vim \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/sgx-quote

ENV SGX_SDK /opt/sgxsdk
ENV PATH $PATH:$SGX_SDK/bin:$SGX_SDK/bin/x64
ENV PKG_CONFIG_PATH $SGX_SDK/pkgconfig
ENV LD_LIBRARY_PATH $SGX_SDK/sdk_libs

COPY . .

RUN set -eux; \
    ./bootstrap; \
    ./configure --with-sgxsdk=/opt/sgxsdk; \
    make;
