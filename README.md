# TODO
- adjust application.properties to exclude sensitive info **DONE**
- create dockerfile **DONE**
- create image **DONE**
- create manifests
    - deployment
    - clusterIP
        - make sure to add label "release: prometheus" assuming that is name of kube-prometheus-stack helm chart install
- add to TODO list? :)

## Environment Variables
- SPRING_DATASOURCE_URL
    - jdbc:postgresql://localhost:5432/postgres
    - jdbc:postgresql://host.docker.internal:5432/postgres
- SPRING_DATASOURCE_USERNAME
    - postgres
- SPRING_DATASOURCE_PASSWORD
    - L0c@1