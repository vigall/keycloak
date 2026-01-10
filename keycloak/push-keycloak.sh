#!/bin/bash

# Script para build e push da imagem Keycloak Customizada para o Docker Hub
# Este script deve ser executado a partir da pasta keycloak

set -e

# Configurações
DOCKER_USERNAME="vgallico"
IMAGE_NAME="master-clinic-keycloak"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}"

# Versão (padrão: latest)
VERSION=${1:-latest}

echo "🐳 Keycloak Custom Production Build & Push"
echo "=============================="
echo "Imagem: ${FULL_IMAGE_NAME}:${VERSION}"
echo "Contexto: $(pwd)"
echo ""

# 1. Build da imagem usando o Dockerfile.prod
echo "🔨 Fazendo build da imagem customizada (incluindo temas e config)..."
docker build -t "${FULL_IMAGE_NAME}:${VERSION}" -f Dockerfile.prod .

echo "✅ Build concluído!"

# 2. Push para Docker Hub
echo ""
read -p "📤 Deseja fazer push para o Docker Hub? (Y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "📤 Fazendo push para Docker Hub..."
    docker push "${FULL_IMAGE_NAME}:${VERSION}"
    echo "✅ Push concluído!"
    echo ""
    echo "🎉 Imagem disponível em: https://hub.docker.com/r/${FULL_IMAGE_NAME}"
    echo "📋 Para usar no Render, utilize a imagem: ${FULL_IMAGE_NAME}:${VERSION}"
else
    echo "⏭️  Push cancelado"
fi

echo ""
echo "✨ Script concluído!"
