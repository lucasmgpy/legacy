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
