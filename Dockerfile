# reprostat/octave

# Please follow docker best practices
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

# Docker images to build GNU Octave <https://www.octave.org>.

ARG OCTAVE_VERSION_MAJOR
FROM  gnuoctave/octave-build:${OCTAVE_VERSION_MAJOR}

LABEL maintainer="Tibor Auer <tibor.auer@gmail.com>"

ENV LAST_UPDATED=2024-02-26


# Update builder image with latest security updates
RUN apt-get --yes update  && \
    apt-get --yes upgrade && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get --no-install-recommends --yes install \
	bc \
    	libopencv-dev \
    	libavformat-dev \
    	libavcodec-dev \
    	libswscale-dev \
    	graphviz \
    	tcsh \
    	&& \
    pip3 install --upgrade --no-cache-dir \
      pip                           \
      sympy                         \
      || true                    && \
    apt-get --yes clean          && \
    apt-get --yes autoremove     && \
    rm -Rf /var/lib/apt/lists/*


# Install Octave
ARG OCTAVE_VERSION
ARG GNU_MIRROR=https://ftpmirror.gnu.org/octave
RUN mkdir -p /tmp/build  \
    && cd    /tmp/build  \
    && wget -q "${GNU_MIRROR}/octave-${OCTAVE_VERSION}.tar.gz"  \
    && tar -xf octave-${OCTAVE_VERSION}.tar.gz     \
    && cd      octave-${OCTAVE_VERSION}            \
    && ./configure    ${OCTAVE_CONFIGURE_ARGS}     \
          F77_INTEGER_8_FLAG=${F77_INTEGER_8_FLAG} \
    && make -j8      \
    && make install  \
    && rm -rf /tmp/build

# Install dependencies
ARG AWSCLI_MIRROR=https://awscli.amazonaws.com
ARG AWSCLI_PKG=awscli-exe-linux-x86_64.zip
ARG CONDA_MIRROR=https://repo.anaconda.com/miniconda
ARG CONDA_PKG=Miniconda3-latest-Linux-x86_64.sh
RUN mkdir /tmp/install \
    && cd /tmp/install \ 
    && wget -q "${AWSCLI_MIRROR}/${AWSCLI_PKG}" \
    && unzip -q ${AWSCLI_PKG} \
    && ./aws/install \
    && mkdir -p /opt/software/config \
    && wget -q "${CONDA_MIRROR}/${CONDA_PKG}" \
    && bash ./${CONDA_PKG} -b -u -p /opt/software/miniconda3 \
    && /opt/software/miniconda3/bin/conda init bash \
    && sed '/>>> conda initialize >>>/,/<<< conda initialize <<</!d' ~/.bashrc >> /opt/software/config/conda_bash.sh \
    && rm -rf /tmp/install

WORKDIR /workdir

CMD ["octave-cli"]
