FROM tensorflow/tensorflow:latest-devel-gpu-py3

RUN apt-get update && apt-get install -y build-essential checkinstall software-properties-common llvm cmake wget git nano nasm yasm zip unzip pkg-config && apt-get update

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    git \
    texlive \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-xetex \
    unzip \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# ENV PATH /opt/conda/bin:$PATH
# ENV MINICONDA_VERSION Miniconda3-4.6.14

RUN apt-get update --fix-missing \
    && apt-get install -y wget bzip2 ca-certificates curl git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN wget --quiet https://repo.anaconda.com/miniconda/${MINICONDA_VERSION}-Linux-x86_64.sh -O ~/miniconda.sh \
#    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
#    && rm ~/miniconda.sh \
#    && /opt/conda/bin/conda clean -tipsy \
#    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh


RUN apt-get install -y python3-pip && apt-get update

RUN pip3 install --upgrade \
    pip \
    setuptools

RUN pip3 install pandas==0.23.0 numpy==1.14.3 scikit-learn==0.19.1 tqdm==4.26.0 seaborn==0.8.1 matplotlib==2.2.2 scipy==1.3.1 catboost==0.13.1 torch==1.3.0 torchvision==0.4.1 torchsummary xgboost

RUN pip3 install comet_ml wldhx.yadisk-direct

# RUN pip3 install ipython[all]
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN useradd -ms /bin/bash admin

EXPOSE 443
EXPOSE 8000

#RUN apt-get update -y && add-apt-repository universe -y && add-apt-repository ppa:certbot/certbot -y && apt-get update -y && apt-get install certbot -y 
#RUN certbot certonly --standalone --text --non-interactive --agree-tos --email "mrartemev.me@gmail.com" --domains "40.124.32.72"

RUN mkdir /srv/jupyterhub/
RUN mkdir /srv/jupyterhub/ssl/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /srv/jupyterhub/ssl/ssl.key -out /srv/jupyterhub/ssl/ssl.cert -subj "/C=RU/ST=Moscow/L=Moscow/O=Lmbd/CN=mrartemev"

COPY jupyterhub_config.py /

#RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && bash nodesource_setup.sh && apt install -y nodejs
RUN apt update -y && apt install -y nodejs nodejs-dev node-gyp libssl1.0-dev && apt install -y npm

RUN npm install -g configurable-http-proxy

RUN pip3 install jupyterhub jupyterlab jupyter_nbextensions_configurator 
#RUN conda update -y conda
#RUN conda install -c conda-forge jupyter_nbextensions_configurator \
#    jupyterhub \
#    jupyterlab \
#    numpy \
#    matplotlib \
#    pandas \
#    r-essentials \
#    scipy \
#    sympy \
#    && conda clean -ay


WORKDIR /workdir
CMD ["jupyterhub", "--ip='*'", "--port=8000"]
#"--no-browser", "--allow-root"]


#ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip=0.0.0.0"]

