FROM continuumio/anaconda3

# Argumentos do container
ENV UNAME=lmuffato
ENV USER_ID=1000
ENV GROUP_ID=1000

ENV QT_SCALE_FACTOR=1.5
ENV QT_API=pyqt5
ENV PWD=/app
ENV SPYDER_WORKING_IDR=/app
ENV XDG_RUNTIME_DIR=/app

ARG ROOT=/
ARG UNAME=lmuffato
ARG UID=1000
ARG GID=1000

# Define o diretório de trabalho do container
WORKDIR /app

# Adiciona privilégios ao usuário
# útil para intercambiar a edição de arquivos entre spyder, vscode, e jupyter notebook
RUN addgroup --gid ${GID} ${UNAME}
RUN adduser --uid ${UID} --ingroup ${UNAME} --shell /bin/sh --disabled-login ${UNAME}
RUN adduser ${UNAME} sudo
RUN echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R ${UID}:${GID} /home/${UNAME}
RUN chmod -R 777 /home/${UNAME}

# Instala as dependêndias do anaconda
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependências necessárias para o spyder na interface gráfica
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    libstdc++-12-dev \
    libglib2.0-0 \
    libx11-6 \
    libsm6 \
    libxrender1 \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    python3-qtconsole \
    python3-setuptools \
    python3-pip \
    libgl1-mesa-dri \
    libglx-mesa0 \
    mesa-utils \
    libgl1-mesa-glx \
    libpci3 \
    net-tools && apt-get clean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Cria um  link simbólico para libstdc++ (spider)
RUN ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/conda/lib/libstdc++.so.6

COPY requirements.txt .

# Pacotes adicionais que não vem no anaconda ou não podem ser instalados pelo conda
RUN pip install --no-cache-dir -r requirements.txt

# Usado para criar interfaces gráficas (janela) com Qt em Python
RUN conda install pyqt=5 qt=5

# Instala ao spyder no ambiente conda
RUN conda install spyder=6.0.3 -y

# Isso aumenta em muito o peso da imagem, se não for usar, melhor comentar o trecho abaixo
RUN conda install tensorflow pyspark -y
RUN conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y

# Ajusta as permissões do diretório de configuração do Spyder
RUN mkdir -p /home/${UNAME}/.config/spyder-py3/config && \
    chown -R ${UID}:${GID} /home/${UNAME}/.config && \
    chmod -R 755 /home/${UNAME}/.config

# Ajusta permissões do diretório de trabalho
RUN chown -R ${UID}:${GID} /app

# Define o usuário a ser usado no container
USER ${UNAME}

# Container vai ficar ativo mesmo sem ter uma execução
CMD ["tail", "-f", "/dev/null"]
