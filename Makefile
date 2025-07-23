.PHONY: build run shell clean help

IMAGE_NAME := gemini-cli-sample
IMAGE_TAG := latest
WORKSPACE_DIR := /gemini

# Dockerイメージをビルド
build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

# コンテナを実行（デフォルトコマンド）
run:
	docker run -it --rm -v "$$(pwd)/$(WORKSPACE_DIR)":$(WORKSPACE_DIR) $(IMAGE_NAME):$(IMAGE_TAG)

# コンテナでbashシェルを起動
shell:
	docker run -it --rm -v "$$(pwd)/$(WORKSPACE_DIR)":$(WORKSPACE_DIR) $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash

# Dockerイメージを削除
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true
