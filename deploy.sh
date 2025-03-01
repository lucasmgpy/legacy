#!/bin/bash

# Script básico para simular deploy
echo "Iniciando deploy..."

# Navega até a pasta do projeto
cd MeuProjeto

# Simula um deploy (publicação para um diretório)
dotnet publish -c Release -o ./publish

# Verifica se o publish foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Deploy simulado concluído com sucesso!"
else
    echo "Erro no deploy!" >&2
    exit 1
fi
