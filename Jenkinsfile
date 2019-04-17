pipeline {
    agent any
    stages {
        stage('Delete the workspace') {
            steps {
                sh "cd $WORKSPACE"
                deleteDir()
            }
        }
        stage('Second Stage') {
            steps {
                echo "Second stage"
            }
        }
        stage('Third Stage') {
            steps {
                echo "Third Stage"
            }
        }
    }
}
