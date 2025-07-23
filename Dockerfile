FROM ubuntu:24.04

# パッケージのインストールを効率化
RUN apt-get update -y && apt-get install -y \
    gpg \
    wget \
    curl \
    && install -dm 755 /etc/apt/keyrings \
    && wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=arm64] https://mise.jdx.dev/deb stable main" | tee /etc/apt/sources.list.d/mise.list \
    && apt-get update \
    && apt-get install -y mise \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/share/mise/shims:/root/.local/share/mise/installs/node/latest/bin:${PATH}"

RUN mise install node@latest \
    && mise use node@latest \
    && npm install -g @google/gemini-cli

RUN mkdir -p /gemini
WORKDIR /gemini
VOLUME ["/gemini"]

CMD ["/bin/bash"]