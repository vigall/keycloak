#!/bin/bash

# Script para build e push da imagem Docker do Keycloak para o Docker Hub
# Uso: ./push-keycloak.sh [versão]

set -e

# Configurações
DOCKER_USERNAME="vgallico"
IMAGE_NAME="master-clinic-keycloak"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}"

# Versão (padrão: latest)
VERSION=${1:-latest}

echo "🐳 Keycloak Docker Build & Push Script"
echo "=============================="
echo "Imagem: ${FULL_IMAGE_NAME}:${VERSION}"
echo ""

# 1. Verificar se Docker está rodando
echo "📋 Verificando Docker..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker Desktop e tente novamente."
    exit 1
fi
echo "✅ Docker está rodando"

# 2. Login no Docker Hub (se necessário)
echo ""
echo "🔐 Verificando login no Docker Hub..."
if ! docker info | grep -q "Username:"; then
    echo "⚠️  Não está logado no Docker Hub. Execute: docker login"
    echo "   Username: ${DOCKER_USERNAME}"
    read -p "Pressione Enter para continuar após fazer login..."
fi

# 3. Build da imagem
echo ""
echo "🔨 Fazendo build da imagem (usando Dockerfile.prod)..."
docker build -t "${FULL_IMAGE_NAME}:${VERSION}" -f Dockerfile.prod .

echo "✅ Build concluído: ${FULL_IMAGE_NAME}:${VERSION}"

# 4. (Opcional) Teste local
echo ""
read -p "🧪 Deseja testar a imagem localmente? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Iniciando container de teste..."
    echo "   Keycloak rodará em: http://localhost:8443/auth"
    echo "   Nota: O teste local usará 'start-dev' para ignorar a necessidade de DB externo."
    echo ""
    
    # Parar container anterior se existir
    docker stop keycloak-test 2>/dev/null || true
    docker rm keycloak-test 2>/dev/null || true
    
    # Executar container em modo dev para teste rápido
    docker run --rm -d \
        --name keycloak-test \
        -p 8443:8443 \
        -e KEYCLOAK_ADMIN=admin \
        -e KEYCLOAK_ADMIN_PASSWORD=admin \
        -e KC_HOSTNAME_STRICT=false \
        -e KC_HTTP_ENABLED=true \
        -e KC_HTTP_RELATIVE_PATH=/auth \
        "${FULL_IMAGE_NAME}:${VERSION}" start-dev
    
    echo "✅ Container iniciado em http://localhost:8443/auth"
    echo "   Login: admin / admin"
    echo "   Para parar: docker stop keycloak-test"
    echo "   Para ver logs: docker logs -f keycloak-test"
    echo ""
fi

# 5. Push para Docker Hub
echo ""
read -p "📤 Deseja fazer push para o Docker Hub? (Y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "📤 Fazendo push para Docker Hub..."
    docker push "${FULL_IMAGE_NAME}:${VERSION}"
    echo "✅ Push concluído!"
    echo ""
    echo "🎉 Imagem disponível em: https://hub.docker.com/r/${FULL_IMAGE_NAME}"
    echo "   Tag: ${VERSION}"
    echo ""
    echo "📋 Para usar no Render ou outro serviço:"
    echo "   Image URL: docker.io/${FULL_IMAGE_NAME}:${VERSION}"
else
    echo "⏭️  Push cancelado"
fi

echo ""
echo "✨ Script concluído!"
