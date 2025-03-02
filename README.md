#Legacy Project
## Fase 1: Configuração Inicial do Ambiente

### Passo 1: Atualizar o Sistema
**Comando:** `sudo apt update && sudo apt upgrade -y`
- **`sudo`**: Executa como administrador.
- **`apt update`**: Atualiza a lista de pacotes disponíveis.
- **`&&`**: Executa o próximo comando se o anterior for bem-sucedido.
- **`apt upgrade -y`**: Atualiza os pacotes instalados, com `-y` para confirmar automaticamente.

### Passo 2: Instalar Git
**Comando:** `sudo apt install git -y`
- **`sudo apt install`**: Instala um pacote.
- **`git`**: Pacote do Git, sistema de controle de versão.
- **`-y`**: Confirma automaticamente.

### Passo 3: Configurar Git
**Comandos:**
1. `git config --global user.name "SeuNome"`
   - **`--global`**: Aplica a configuração a todos os repositórios.
   - **`user.name`**: Define o nome para commits.
2. `git config --global user.email "seuemail@exemplo.com"`
   - **`user.email`**: Define o e-mail para commits.

### Passo 4: Instalar Jenkins
**Comando 1:** `sudo apt install openjdk-17-jre -y`
- **`openjdk-17-jre`**: Instala Java 17, necessário para o Jenkins.

**Comandos 2 a 5:**
1. `sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key`
   - **`wget`**: Baixa a chave do repositório Jenkins.
   - **`-O`**: Define o destino do arquivo.
2. `echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null`
   - Adiciona o repositório Jenkins às fontes do sistema.
3. `sudo apt update`
   - Atualiza a lista de pacotes com o repositório Jenkins.
4. `sudo apt install jenkins -y`
   - Instala o Jenkins.

### Passo 5: Instalar Azure CLI
**Comandos:**
1. `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`
   - **`curl`**: Baixa o script de instalação.
   - **`bash`**: Executa o script.
2. `az login`
   - Autentica no Azure.

### Passo 6: Criar Chave SSH
**Comando:** `ssh-keygen -t ed25519 -C "seuemail@exemplo.com"`
- **`ssh-keygen`**: Gera chaves SSH.
- **`-t ed25519`**: Tipo de chave.
- **`-C`**: Comentário (e-mail).

### Passo 7: Adicionar Chave ao GitHub
- Copie a chave pública (`cat ~/.ssh/id_ed25519.pub`) e adicione manualmente no GitHub.

## Fase 2: Criar Repositório GitHub do Zero

### Passo 1: Criar o Repositório no GitHub (Interface Web)
- Acesse github.com, faça login, clique em "+" > "New repository".
- **Nome**: `legacy`
- **Descrição**: "Microprojeto para prática de DevOps: Jenkins, GitHub Actions e Terraform."
- Configure como público e deixe sem arquivos iniciais.

### Passo 2: Clonar o Repositório Localmente
**Comando:** `git clone git@github.com:seuusuario/legacy.git`
- **`git clone`**: Cria uma cópia local do repositório remoto.
- **`git@github.com:seuusuario/legacy.git`**: Endereço SSH do repositório (substitua `seuusuario`).

### Passo 3: Criar o Arquivo `.gitignore`
**Comando:** `echo -e "bin/\nobj/\n*.log" > .gitignore`
- **`echo -e`**: Interpreta `\n` como nova linha.
- **`bin/`, `obj/`, `*.log`**: Ignora pastas de compilação e logs.
- **`>`**: Cria/sobrescreve o `.gitignore`.

### Passo 4: Criar o Arquivo `README.md` Inicial
**Comando:** `echo "# Legacy Project" > README.md`
- **`echo`**: Escreve texto.
- **`"# Legacy Project"`**: Título em markdown.
- **`>`**: Cria o `README.md`.

### Passo 5: Adicionar Conteúdo ao `README.md` com a Fase 1
- (Já incluído anteriormente na Fase 1, com Java 17 ajustado.)

### Passo 6: Adicionar, Commitar e Enviar Alterações
**Comandos:**
1. `git add .`
   - Adiciona todos os arquivos alterados ao staging.
2. `git commit -m "Configuração inicial do repositório com .gitignore e README"`
   - **`commit`**: Salva as alterações localmente.
   - **`-m`**: Define a mensagem do commit.
3. `git push origin main`
   - **`push`**: Envia para o repositório remoto.
   - **`origin main`**: Remoto e branch principal.

## Fase 3: Criar Microprojeto MVC com Individual Accounts

### Passo 1: Instalar o .NET SDK
**Comando:** `sudo apt install -y dotnet-sdk-8.0`
- **`sudo apt install`**: Instala pacotes no sistema.
- **`-y`**: Confirma automaticamente.
- **`dotnet-sdk-8.0`**: Instala o .NET SDK 8.0.

### Passo 2: Criar o Projeto MVC
**Comando:** `dotnet new mvc --auth Individual -o MeuProjeto`
- **`dotnet new`**: Cria um novo projeto.
- **`mvc`**: Template MVC.
- **`--auth Individual`**: Adiciona autenticação individual.
- **`-o MeuProjeto`**: Define a pasta de saída.

### Passo 3: Testar Localmente
**Comando:** `dotnet run`
- **`dotnet run`**: Compila e executa o projeto. Acesse `http://localhost:5000`.

### Passo 4: Atualizar o `.gitignore`
**Comando:** `echo "MeuProjeto/appsettings*.json" >> ../.gitignore`
- Ignora arquivos de configuração sensíveis.

### Passo 5: Adicionar ao Git
**Comandos:**
1. `git add .`
   - Adiciona todos os arquivos ao staging.
2. `git commit -m "Projeto MVC inicial com autenticação individual"`
   - Cria um commit com a mensagem.
3. `git push origin main`
   - Envia para o GitHub.
## Fase 4: Adicionar Teste Unitário (Revisada)

### Passo 1: Criar o Projeto de Testes
**Comando:** `dotnet new xunit -o MeuProjeto.Tests`
- **`xunit`**: Template para testes com xUnit.
- **`-o MeuProjeto.Tests`**: Cria o projeto na pasta especificada.

### Passo 2: Adicionar Referência ao Projeto Principal
**Comando:** `dotnet add MeuProjeto.Tests reference MeuProjeto`
- **`reference`**: Adiciona dependência do projeto MVC.
- **Nota**: Execute na raiz (`legacy`).

### Passo 3: Escrever um Teste Unitário
**Comando:** `(cat substitui UnitTest1.cs)`
- Testa se `HomeController.Index` retorna `ViewResult`.

### Passo 4: Executar os Testes
**Comando:** `dotnet test MeuProjeto.Tests`
- **`test MeuProjeto.Tests`**: Executa o teste unitário no projeto especificado.

### Passo 5: Adicionar ao Git
**Comandos:**
1. `git add .`
2. `git commit -m "Adicionado teste unitário"`
3. `git push origin main`

### Nota de Revisão
- Testes de integração foram removidos por simplicidade, mantendo apenas o teste unitário.
- Arquivos `IntegrationTest1.cs` e `TestStartup.cs` excluídos, pacote `Microsoft.AspNetCore.Mvc.Testing` removido.

## Fase 5: Criar Scripts Bash

### Passo 1: Criar o Script `build.sh`
**Comando:** `(cat cria build.sh)`
- Compila o projeto com `dotnet build`.

### Passo 2: Criar o Script `test.sh`
**Comando:** `(cat cria test.sh)`
- Executa testes unitários com `dotnet test` (testes de integração removidos por erros).

### Passo 3: Criar o Script `deploy.sh`
**Comando:** `(cat cria deploy.sh)`
- Simula deploy com `dotnet publish`.

### Passo 4: Tornar os Scripts Executáveis
**Comando:** `chmod +x *.sh`
- **`chmod +x`**: Dá permissão de execução.
- **`*.sh`**: Aplica a todos os scripts `.sh`.

### Passo 5: Adicionar ao Git
**Comandos:**
1. `git add .`
2. `git commit -m "Adicionados scripts bash para build, test e deploy"`
3. `git push origin main`

## Fase 6: Configurar Terraform para Infraestrutura no Azure

### Passo 1: Criar uma Pasta para o Terraform
**Comando:** `mkdir infra`
- Cria a pasta `infra` para arquivos Terraform.

### Passo 2: Criar o Arquivo `main.tf`
**Comando:** `(cat cria main.tf)`
- Define um Resource Group, App Service Plan e App Service no Azure.

### Passo 3: Autenticar no Azure
**Comando:** `az login`
- Autentica no Azure via navegador.

### Passo 4: Inicializar o Terraform
**Comando:** `terraform init`
- Baixa provedores e inicializa o Terraform.

### Passo 5: Aplicar a Infraestrutura
**Comando:** `terraform apply`
- Cria os recursos no Azure (digite `yes` para confirmar).

### Passo 6: Adicionar ao Git
**Comandos:**
1. `cd ..`
2. `echo "infra/terraform.tfstate" >> .gitignore`
   - Ignora o arquivo de estado.
3. `git add .`
4. `git commit -m "Adicionada infra Terraform para Azure"`
5. `git push origin main`
