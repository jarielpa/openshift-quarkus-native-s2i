FROM registry.access.redhat.com/ubi7/ubi-minimal:7.7-98 

ENV QUARKUS_HOME=/opt/quarkus

EXPOSE 8080

LABEL io.openshift.s2i.scripts-url="image:///usr/local/s2i" \    
      io.openshift.expose-services="8080:http" \
      io.k8s.description="Quarkus.io S2I binary image for running native application on UBI minimal" \
      io.k8s.display-name="Quarkus.io S2I (UBI + Native image)" \
      io.openshift.tags="builder,java,quarkus,native"

RUN microdnf install tar && microdnf clean all

COPY s2i /usr/local/s2i

ENV PATH=$PATH:"/usr/local/s2i"

RUN chmod 755 /usr/local/s2i/* && mkdir $QUARKUS_HOME && chown -R 1001:0 $QUARKUS_HOME \
    && chown -R 1001:0 $HOME && chmod -R ug+rwX $QUARKUS_HOME

USER 1001

CMD $STI_SCRIPTS_PATH/usage
