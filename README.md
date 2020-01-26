# Quarkus Native S2I Image for OpenShift

### General

Based on ubi-minimal:7.7-98


#### Build S2I Image in OpenShift

	oc new-build --binary --name=openshift-quarkus-native-s2i -l app=openshift-quarkus-native-s2i
	
	oc start-build openshift-quarkus-native-s2i --from-dir=. --follow --wait	

#### Build and deploy your app

	mvn package -Pnative -DskipTests

	oc new-build openshift-quarkus-native-s2i:latest --binary --name=myapp
	oc start-build myapp --from-file=target/myapp-1.0-SNAPSHOT-runner --follow --wait
	oc new-app --image-stream=myapp:latest
	oc expose service myapp
   
  

#### Build locally

	docker build . -t openshift-quarkus-native-s2i