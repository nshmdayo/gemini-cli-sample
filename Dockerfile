FROM ubuntu:24.04

Run apt-get update -y && apt-get install -y gpg wget curl
Run install -dm 755 /etc/apt/keyrings
Run wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
Run echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=arm64] https://mise.jdx.dev/deb stable main" | tee /etc/apt/sources.list.d/mise.list
Run apt-get update
Run apt-get install -y mise
ENV PATH="/root/.local/share/mise/shims:/root/.local/share/mise/installs/node/latest/bin:${PATH}"

RUN mise install node@latest
RUN mise use node@latest
RUN npm install -g @google/gemini-cli

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
