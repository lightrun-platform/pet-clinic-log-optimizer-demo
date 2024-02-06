FROM --platform=linux/amd64 openjdk:8-jre-alpine as build

COPY target/spring-petclinic-3.0.0-SNAPSHOT.jar /usr/bin/spring-petclinic.jar

ENV JAVA_OPTS='-Dcom.lightrun.DynamicLog.FileHandler.formatter=json \
               -Dlightrun.registration.tags=pet-clinic \
               -agentpath:/opt/lightrun/agent/lightrun_agent.so=--enable_pii_redaction=0,--runtime_reachability_watched_packages_enabled=1,--runtime_reachability_dynamic_sbom_enabled=1,--dynamic_sbom_report_frequency_sec=300,--watched_packages_sync_frequency_sec=60'
EXPOSE 8080
ENTRYPOINT java $JAVA_OPTS -jar /usr/bin/spring-petclinic.jar --server.port=8080
