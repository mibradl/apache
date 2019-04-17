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
                sh 'wget https://packages.chef.io/files/
                stable/chef-workstation/0.2.53/ubuntu/16.04/chef-workstation_0.2.53-1_amd64.deb'
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
