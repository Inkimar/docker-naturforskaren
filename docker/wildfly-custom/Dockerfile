FROM jboss/wildfly:16.0.0.Final

WORKDIR /opt/jboss/wildfly

ADD modules /opt/jboss/wildfly/modules/
ADD customization /opt/jboss/wildfly/customization/

USER root
RUN chmod +x /opt/jboss/wildfly/customization/execute.sh
RUN /opt/jboss/wildfly/customization/execute.sh

# Fix for Error: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current 
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
RUN chown -R jboss:jboss /opt/jboss/wildfly/

# admin-interface
RUN /opt/jboss/wildfly/bin/add-user.sh admin dina2020--silent


#adding the artifact . NB: docker-compose.yml - DO NOT MAP a VOLUME TO '/opt/jboss/wildfly/standalone/deployments/'
#ADD customization/naturalist.war /opt/jboss/wildfly/standalone/deployments/

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
