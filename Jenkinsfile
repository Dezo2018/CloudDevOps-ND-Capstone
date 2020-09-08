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
                sh 'pylint --rcfile=pylint.cfg --disable=R,C,W1203,W1202 app.py'
            }
        }
	    stage('Security Scan') {
            steps {
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html' 
            }
        }         
        stage('Upload to AWS') {
            steps {
                withAWS(region:'eu-central-1',credentials:'devops') {
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
    }
}
