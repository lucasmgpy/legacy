#### Visão Geral
O projeto "legacy" é uma aplicação web ASP.NET Core MVC com autenticação individual, usando SQLite para banco de dados, containerizada com Docker, e deployada no Azure App Service. Foi criado para simular um projeto legado, praticando CI/CD, automação, e manutenção, com foco em aprendizado de práticas DevOps.

#### Tecnologia Stack
- **Linguagens e Frameworks:** C#, ASP.NET Core MVC, Entity Framework Core.
- **Banco de Dados:** SQLite, com arquivo `app.db`.
- **Containerização:** Docker, com imagem `lucasmgpy/legacylmg-app:latest` no Docker Hub.
- **CI/CD:** GitHub Actions, com self-hosted runner em Ubuntu 22.04.
- **Cloud:** Azure App Service, usando um resource group e App Service configurados.
- **Infraestrutura:** Terraform para provisionar recursos no Azure.

#### Estrutura do Projeto
- **Diretórios e Arquivos Principais:**
  - `MeuProjeto/`: Contém o código ASP.NET Core (`.csproj`, `Program.cs`, `app.db`, `wwwroot`, etc.).
  - `infra/`: Arquivo `main.tf` para Terraform, configurando recursos no Azure.
  - `.github/workflows/ci-cd.yml`: Workflow para CI/CD, build, test, e deploy.
  - Scripts Bash: `build.sh`, `test.sh`, `deploy.sh` na raiz para automação.

#### Processos de Build e Deploy
- **Build:** Usa `dotnet build` via `build.sh`, executado no self-hosted runner.
- **Teste:** Roda testes unitários com `dotnet test` via `test.sh`.
- **Containerização:** Cria imagem Docker com `docker build -t lucasmgpy/legacylmg-app:latest .`, publicada no Docker Hub.
- **Deploy:** Configura no Azure App Service com `az webapp config container set`, usando string de conexão `DefaultConnection="Data Source=/app/app.db"`.

#### Troubleshooting
- Erros comuns: Falhas de pull de imagem Docker, strings de conexão ausentes, e timeouts no deploy.
- Solução: Ativar logs com `az webapp log config --application-logging filesystem --level information`, verificar com `az webapp log tail`.

#### Monitoramento e Manutenção
- Use Azure Monitor para métricas (ex.: HTTP 5xx) com `az monitor metrics list`.
- Scripts Bash como `monitor-app.sh` para verificar status: `az webapp show`.

---

### Documentação Completa do Projeto "Legacy"

#### Introdução
O projeto "legacy" é um microprojeto desenvolvido para simular um sistema legado, com o objetivo de praticar habilidades DevOps, incluindo CI/CD, containerização, automação, e deploy em cloud. Ele consiste em uma aplicação web ASP.NET Core MVC com autenticação individual, usando SQLite, containerizada com Docker, e deployada no Azure App Service via GitHub Actions com self-hosted runner.

#### Objetivos
- Simular um projeto legado para aprender automação CI/CD, manutenção de scripts Bash, e integração com Azure.
- Desenvolver habilidades em troubleshooting, automação, e deploy em cloud.
- Garantir compatibilidade e eficiência em deploys, focando em boas práticas DevOps.

#### Tecnologia Stack
Abaixo está a lista de tecnologias utilizadas, com suas funções no projeto:

| Tecnologia                | Função                                                                 |
|---------------------------|------------------------------------------------------------------------|
| ASP.NET Core MVC          | Framework para a aplicação web, com controllers, views, e autenticação |
| Entity Framework Core     | ORM para gerenciar o banco de dados SQLite                            |
| SQLite                    | Banco de dados leve, usando arquivo `app.db` para persistência         |
| Docker                    | Containerização da aplicação, criando imagem `lucasmgpy/legacylmg-app:latest` |
| GitHub Actions            | Plataforma CI/CD para automação de build, teste, e deploy             |
| Self-Hosted Runner        | Runner personalizado em Ubuntu 22.04 para executar workflows          |
| Azure App Service         | Hospedagem da aplicação containerizada, usando um resource group      |
| Terraform                 | Provisionamento de infraestrutura no Azure                            |
| Azure CLI                 | Gerenciamento de recursos Azure via CLI, como logs e configurações    |
| Bash Scripts              | Automação de tarefas (build, teste, deploy) com `build.sh`, `test.sh` |

#### Estrutura do Projeto
A estrutura do repositório `legacy` é organizada da seguinte forma, com detalhes de cada componente:

- **Raiz do Repositório (`~/legacy/`):**
  - `build.sh`: Script Bash para buildar o projeto com `dotnet build`.
  - `test.sh`: Script Bash para rodar testes unitários com `dotnet test`.
  - `deploy.sh`: Script Bash para simular deploy, usado no workflow.
  - `.github/workflows/ci-cd.yml`: Workflow YAML para CI/CD, disparado em `push` para `dev` e `main`.
  - `.gitignore`: Ignora arquivos como `actions-runner/` e `infra/.terraform.lock.hcl`.

- **Diretório `MeuProjeto/`:**
  - `MeuProjeto.csproj`: Arquivo de projeto ASP.NET Core, definindo dependências e configurações.
  - `Program.cs`: Código principal, configurando o app com `UseSqlite` e `DefaultConnection`.
  - `app.db`: Arquivo SQLite para banco de dados, persistido no contêiner.
  - `Controllers/`, `Views/`, `wwwroot/`: Estrutura MVC para controllers, views, e assets web.
  - `Dockerfile`: Define a imagem Docker com multi-stage build, expondo porta 8080.

- **Diretório `infra/`:**
  - `main.tf`: Arquivo Terraform para provisionar resources no Azure, como resource group e App Service.

#### Processos de Build e Deploy
O processo de build, teste, e deploy é automatizado via GitHub Actions, com os seguintes passos:

1. **Build:**
   - Executado pelo script `build.sh` no self-hosted runner:
     ```bash
     #!/bin/bash
     echo "Iniciando build do projeto..."
     dotnet build MeuProjeto/MeuProjeto.csproj
     if [ $? -eq 0 ]; then echo "Build concluído com sucesso!"; else echo "Erro no build!" >&2; exit 1; fi
     ```
   - No workflow, chamado com:
     ```yaml
     - name: Build
       run: ./build.sh
     ```

2. **Teste:**
   - Executado pelo script `test.sh` no self-hosted runner:
     ```bash
     #!/bin/bash
     echo "Executando testes..."
     cd MeuProjeto.Tests
     dotnet test
     if [ $? -eq 0 ]; then echo "Testes concluídos com sucesso!"; else echo "Erro nos testes!" >&2; exit 1; fi
     ```
   - No workflow, chamado com:
     ```yaml
     - name: Test
       run: ./test.sh
     ```

3. **Containerização e Deploy:**
   - Cria a imagem Docker com:
     ```yaml
     - name: Build Docker Image
       run: |
         cd MeuProjeto
         docker build -t lucasmgpy/legacylmg-app:latest .
     ```
   - Publica no Docker Hub e deploya no Azure App Service:
     ```yaml
     - name: Build and Push Docker Image
       run: |
         cd MeuProjeto
         docker build -t lucasmgpy/legacylmg-app:latest .
         docker push lucasmgpy/legacylmg-app:latest
     - name: Deploy to Azure
       if: github.ref == 'refs/heads/main'
       env:
         AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
         AZURE_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
         AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
       run: |
         az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
         az webapp config container set --name legacylmg-app --resource-group legacylmg-rg --container-image-name lucasmgpy/legacylmg-app:latest --container-registry-url https://index.docker.io --port 8080
         az webapp restart --name legacylmg-app --resource-group legacylmg-rg
     ```

#### Troubleshooting
Durante o desenvolvimento, enfrentamos os seguintes problemas comuns e suas soluções:

| Problema                              | Causa                                      | Solução                                                                 |
|---------------------------------------|--------------------------------------------|-------------------------------------------------------------------------|
| Falha no pull de imagem Docker        | Imagem não publicada no Docker Hub         | Publicar com `docker push lucasmgpy/legacylmg-app:latest`               |
| Erro "Connection string not found"    | `DefaultConnection` ausente no Azure       | Configurar com `az webapp config appsettings set --settings DefaultConnection="Data Source=/app/app.db"` |
| Timeout no deploy                     | Imagem grande ou problema de rede          | Usar `az webapp deploy` em vez de `az webapp deployment source config-zip` |
| Falha no startup do contêiner         | Porta incorreta (8080 vs. 80)              | Ajustar `EXPOSE 8080` no `Dockerfile` e configurar no App Service com `--port 8080` |
| Conflito de dependências no Docker    | `containerd.io` conflitando com `containerd` | Remover `containerd.io` e reinstalar `docker.io` com `sudo apt-get install --reinstall docker.io` |

#### Monitoramento e Manutenção
Para manter o projeto "legacy" em produção, siga estas práticas:

- **Monitoramento com Azure Monitor:**
  - Verifique métricas com:
    ```bash
    az monitor metrics list --resource <SUBSCRIPTION_ID>/resourceGroups/legacylmg-rg/providers/Microsoft.Web/sites/legacylmg-app --metric "Http5xx" --interval 5m
    ```
  - Configure alertas para erros HTTP 5xx:
    ```bash
    az monitor metrics alert create --name "HTTP-5xx-Alert" --resource-group legacylmg-rg --scopes <SUBSCRIPTION_ID>/resourceGroups/legacylmg-rg/providers/Microsoft.Web/sites/legacylmg-app --condition "avg Http5xx > 0" --action email <EMAIL_ADDRESS>
    ```

- **Scripts Bash para Manutenção:**
  - Use `monitor-app.sh` para verificar status:
    ```bash
    #!/bin/bash
    set -e
    az webapp show --name legacylmg-app --resource-group legacylmg-rg --query "state" -o tsv | grep -q "Running" || { echo "Site não está rodando"; exit 1; }
    echo "Site legacylmg-app está rodando."
    ```
  - Teste com:
    ```bash
    chmod +x ~/legacy/MeuProjeto/monitor-app.sh
    ~/legacy/MeuProjeto/monitor-app.sh
    ```

- **Atualizações e Segurança:**
  - Atualize o self-hosted runner:
    ```bash
    cd ~/legacy/actions-runner
    ./config.sh remove
    curl -o actions-runner-linux-x64-2.308.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.308.0/actions-runner-linux-x64-2.308.0.tar.gz
    tar xzf ./actions-runner-linux-x64-2.308.0.tar.gz
    ./config.sh --url https://github.com/lucasmgpy/legacy --token <RUNNER_TOKEN>
    ./run.sh
    ```
  - Verifique segredos no GitHub:
    ```bash
    gh secret list --repo lucasmgpy/legacy
    ```

#### Contribuições e Próximos Passos
- Este documento substitui o README.md para fornecer uma documentação completa e estruturada.
- Para contribuir, faça forks no GitHub, crie branches (`git checkout -b feature/nova-funcionalidade`), e envie pull requests.
- Próximos passos: Explorar monitoramento avançado com Prometheus/Grafana, segurança em CI/CD, ou integração com Kubernetes para escalabilidade.

---

### Key Citations
- [Azure CLI Documentation for App Service Logging](https://learn.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest)
- [GitHub Actions Runner Documentation](https://docs.github.com/en/actions/hosting-your-own-runners)
- [Docker Hub Official Documentation](https://docs.docker.com/docker-hub/)
- [Azure Monitor Metrics CLI Reference](https://learn.microsoft.com/en-us/cli/azure/monitor/metrics?view=azure-cli-latest)
- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
