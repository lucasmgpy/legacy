pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/dotnet/sdk:8.0'
            args '--user root'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh './build.sh'
            }
        }
        stage('Test') {
            steps {
                sh './test.sh'
            }
        }
        stage('Install Azure CLI') {
            steps {
                sh 'apt-get update && apt-get install -y curl'
                sh 'curl -sL https://aka.ms/InstallAzureCLIDeb | bash'
            }
        }
        stage('Deploy to Azure') {
            steps {
                sh 'apt-get update && apt-get install -y curl'
                sh 'curl -sL https://aka.ms/InstallAzureCLIDeb | bash'
                sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID'
                sh 'cd MeuProjeto && dotnet publish -c Release -o publish && zip -r ../publish.zip publish'
                sh 'az webapp deployment source config-zip --resource-group legacy-rg --name legacy-app --src publish.zip'
            }
        }
    }
}
