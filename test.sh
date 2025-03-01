#!/bin/bash

#Script para correr os testes do projeto
echo "Executando os testes"

cd MeuProjeto.Tests

dotnet test

#verifica se os testes passaram
if [ $? -eq 0 ]; then
    echo "Testes passaram"
else
    echo "Erro nos testes!" >&2
    exit 1
fi
