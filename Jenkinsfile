pipeline {
    agent any
    stages {
        stage('Build start') {
            steps {
                sh 'echo "Starting the project!"'
            }
        }
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Lint flask python app') {
            steps {
                sh '''
                    #python --version
                    #apt install python-pip
                    #pip install flask
                    pylint --disable=R,C,W1203,W1202 app.py || exit 0
                '''
            }
        }
	    stage('Security Scan') {
            steps {
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html' 
            }
        }         
        stage('Upload to AWS') {
            steps {
                withAWS(region:'eu-central-1',credentials:'jenkins3-capstone_user_credentials') {
                sh 'echo "Uploading to AWS"'
                s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'clouddevops-nd-capstone')
                }
            }
        }
	    stage('Building docker image') {
	        steps {
			    sh 'docker build -t clouddevops-capstone .'			
	        }
	    }
	    stage('Push docker image to docker-hub') {
		    steps {
			    withDockerRegistry([url: "", credentialsId: "bkocisdocker"]){
			        sh "docker tag clouddevops-capstone bkocis/clouddevops-capstone:latest"
			        sh "docker push bkocis/clouddevops-capstone:latest"
			    }
            }
		}
        stage('Deploy to AWS EKS') {
              steps{
                  withAWS(credentials: 'jenkins3-capstone_user_credentials', region: 'eu-central-1') {
                    sh "aws eks --region eu-central-1 update-kubeconfig --name capstone"
                    sh "kubectl config use-context arn:aws:eks:eu-central-1:643112058200:cluster/capstone"
                    sh "kubectl get nodes"
                    sh "kubectl get deployments"
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl set image deployments/clouddevops-capstone clouddevops-capstone=bkocis/clouddevops-capstone:latest"
                  }
              }
        }		
    }
}
