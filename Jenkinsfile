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
        stage('setup environment') {
            steps {
                sh 'apt-get update && apt-get install -y curl zip'
                sh 'curl -sL https://aka.ms/InstallAzureCLIDeb | bash'
            }
        }
        stage('Deploy to Azure') {
            environment {
                AZURE_CLIENT_ID = credentials('AZURE_CLIENT_ID')
                AZURE_CLIENT_SECRET = credentials('AZURE_CLIENT_SECRET')
                AZURE_TENANT_ID = credentials('AZURE_TENANT_ID')
            }
            steps {
                sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID'
                sh 'cd MeuProjeto && dotnet publish -c Release -o publish && zip -r ../publish.zip publish'
                sh 'az webapp deployment source config-zip --resource-group legacylmg-rg --name legacylmg-app --src publish.zip'
            }
        }
    }
}
