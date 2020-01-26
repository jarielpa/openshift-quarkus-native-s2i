# Quarkus Native S2I Image for OpenShift

### General

Default base image ubi-minimal:7.7-98.

Dockerfile.alpine base image is frolvlad/alpine-glibc:alpine-3.11_glibc-2.30


#### Build S2I Image in OpenShift

	oc new-build --binary --name=openshift-quarkus-native-s2i -l app=openshift-quarkus-native-s2i
	oc start-build openshift-quarkus-native-s2i --from-dir=. --follow --wait

#### Build Alpine S2I in OpenShift	

	oc new-build --binary --name=openshift-quarkus-native-alpine-s2i -l app=openshift-quarkus-native-alpine-s2i
	oc patch bc/openshift-quarkus-native-alpine-s2i -p '{"spec":{"strategy":{"dockerStrategy":{"dockerfilePath":"Dockerfile.alpine"}}}}'	

#### Build and deploy your app

	mvn package -Pnative -DskipTests

	oc new-build openshift-quarkus-native-s2i:latest --binary --name=myapp

or 	

	qoc new-build openshift-quarkus-native-alpine-s2i:latest --binary --name=myapp
    
	oc start-build myapp --from-file=target/myapp-1.0-SNAPSHOT-runner --follow --wait
	oc new-app --image-stream=myapp:latest
	oc expose service myapp
     

#### Build locally

	docker build . -t openshift-quarkus-native-s2i