pipeline {
    agent any
    stages {
        stage('Delete the workspace') {
            steps {
                sh "cd $WORKSPACE"
                deleteDir()
            }
        }
        stage('Installing ChefDK') {
            steps {
                sh 'sudo apt-get install -y wget'
                sh 'wget https://packages.chef.io/files/stable/chefdk/3.9.0/ubuntu/16.04/chefdk_3.9.0-1_amd64.deb'
                sh 'sudo dpkg -i chefdk_3.8.14-1_amd64.deb'
            }
        }
        stage('Third Stage') {
            steps {
                echo "Third Stage"
            }
        }
    }
}
