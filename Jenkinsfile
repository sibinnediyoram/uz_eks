pipeline {
  parameters {
    string (name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
  environment {
    TF_WORKSPACE = "${params.environment}" //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  stages {
    stage('Terraform Init') {
      steps {
        sh '${env.TERRAFORM_HOME}/terraform init -input=false'
        sh 'terraform workspace select ${environment}'
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false -var-file='cluster-dev.tfvars'"
        sh 'terraform show -no-color tfplan > tfplan.txt'
      }
    }
    stage('Approval') {
      when {
        not {
          equals expected: true, actual: params.autoApprove
            }
          }
           steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
        }
      }
    }
  }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
      }
    }
    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}