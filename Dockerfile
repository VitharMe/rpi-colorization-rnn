FROM arm32v7/python:3.6-slim-stretch

MAINTAINER Vithar Me <vithar@vithar.me>

RUN apt-get update && apt-get upgrade -y && apt-get install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
    software-properties-common \
    zip \
    python-opencv \
    libopenblas-dev \
    libatlas-base-dev \
    libx11-dev \
    libgtk-3-dev \
    python-pip \
    python-dev \
    python3-yaml \
    python3-setuptools \
    cython3 \
    m4 \
    libblas-dev \
    python-matplotlib \
    python-numpy \
    python-pil \
    python-scipy \
    cython \
    python-skimage \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*
RUN pip install Pillow
RUN pip install Cython
RUN pip2 install dlib
RUN pip3 install pyyaml numpy
RUN git clone --recursive https://github.com/pytorch/pytorch && cd pytorch
RUN cd pytorch && git checkout tags/v0.4.1 -b build && \
    git submodule update --init --recursive && \
    export NO_CUDA=1 && \
    export NO_DISTRIBUTED=1 && \
    python3 setup.py build && python3 setup.py install
COPY download_build_install_opencv.sh /root/.
RUN chmod +x /root/download_build_install_opencv.sh && /root/download_build_install_opencv.sh
RUN git clone https://github.com/scikit-image/scikit-image.git && cd scikit-image && pip install -e .
RUN git clone https://github.com/VitharMe/neural-colorization
RUN cd neural-colorization && wget -O model.pth "https://github.com/zeruniverse/neural-colorization/releases/download/1.1/G.pth"
COPY move.sh /root/.
RUN chmod +x /root/move.sh
CMD ["/root/move.sh"]
