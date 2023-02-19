pipeline {
  agent {
    kubernetes {
      inheritFrom 'planetarium'
      yaml '''
        spec:
          tolerations:
            - effect: NoSchedule
              key: role
              operator: Equal
              value: green   
      '''
    }
  }

  environment {
    PLANETARIUM_REGISTRY='twcl774/p3planetarium'
    PLANETARIUM_IMAGE=''
  }

  stages {
    stage("build and push docker image") {
      steps{
        echo "Docker Build and Push"
        container("docker") {
          script{
            PLANETARIUM_IMAGE= docker.build(PLANETARIUM_REGISTRY,".") 
            docker.withRegistry("", 'docker-creds') {
              PLANETARIUM_IMAGE.push("$currentBuild.number")
            }                    
          }
        }
      }
    }
  }
}