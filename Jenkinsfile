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
                script {
                    def exists = fileExists '/usr/bin/chef-client'
                    if (exists) {
                        echo "Skipping ChefDK install - already installed"
                    } else {
                          sh 'sudo apt-get install -y wget'
                          sh 'wget https://packages.chef.io/files/stable/chefdk/3.9.0/ubuntu/16.04/chefdk_3.9.0-1_amd64.deb'
                          sh 'sudo dpkg -i chefdk_3.9.0-1_amd64.deb'
                    }
                }
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
        stage('Send Slack Notification') {
            steps {
                slackSend color: 'slackSend color: "#439FE0"', message: '"student-4:Please approve ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.JOB_URL} | Open>)"'
            }
        }
        stage('Wait for input') {
            steps {
                input 'Please approve or deny this build'
            }
        }
        stage('Upload to Chef, Converge Nodes') {
            steps {
            withCredentials([zip(credentialsId: 'chef-started.zip', variable: 'CHEFREPO')]) {
                sh "mkdir -p $CHEFREPO/chef-repo/apache"
                sh "mv  $WORKSPACE/* $CHEFREPO/chef-repo/cookbooks/apache"
                sh "sudo rm -rf $CHEFREPO/chef-repo/cookbooks/apache/Berksfile.lock"
                sh "knife cookbook upload apache --force -o $CHEFREPO/chef-repo/cookbooks -c $CHEFREPO/chef-repo/.chef/knife.rb"
                }
            }
        }
    }
}
