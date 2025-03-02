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
        stage('Deploy to Azure') {
            steps {
                sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID'
                sh 'cd MeuProjeto && dotnet publish -c Release -o publish'
                sh 'az webapp deployment source config-zip --resource-group legacy-rg --name legacy-app --src MeuProjeto/publish.zip'
            }
        }
    }
}
