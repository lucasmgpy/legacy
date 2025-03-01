#!/bin/bash

# Script para compilar o projeto MeuProjeto
echo "Iniciando build do projeto..."

# Navega até a pasta do projeto
cd MeuProjeto

# Executa o comando de build do .NET
dotnet build

# Verifica se o build foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Build concluído com sucesso!"
else
    echo "Erro no build!" >&2
    exit 1
fi
