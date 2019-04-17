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
                def exists = fileExists '/usr/bin/chef-client'
                if (exists) {
                    echo "Skipping ChefDK install - already installed"
                } else {
                sh 'sudo apt-get install -y wget'
                sh 'wget https://packages.chef.io/files/stable/chefdk/3.9.0/ubuntu/16.04/chefdk_3.9.0-1_amd64.deb'
                sh 'sudo dpkg -i chefdk_3.9.0-1_amd64.deb'
            }
        }
        stage('Download Apache Cookbook') {
            steps {
                git credentialsId: 'git-repo-creds', url: 'git@github.com:mibradl/apache.git'
            }
        }
        stage('Install Ruby') {
            steps {
                sh 'sudo usermod -aG root,docker tomcat'
                sh 'sudo apt-get install rubygems -y'
                sh 'sudo apt-get install ruby-dev -y'
                sh 'sudo gem install bundler -v 2.0.1 --no-doc'
                sh 'bundle install'
            }
        }
        stage('Run Test Kitchen') {
            steps {
                sh 'sudo kitchen test'
            }
        }
    }
}
