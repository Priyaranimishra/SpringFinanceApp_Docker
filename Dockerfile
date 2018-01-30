FROM java:8
RUN apt-get update && \
apt-get install tomcat8 -y && \
sed -i "s|-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC|-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC |g" /etc/default/tomcat8
#Moving the war to tomcat folder
COPY target/finance.war /var/lib/tomcat8/webapps/

#Setting up the catalina running environments
ENV CATALINA_BASE "/var/lib/tomcat8"
ENV CATALINA_HOME "/usr/share/tomcat8"
ENV CATALINA_TMPDIR "/tmp/tomcat8-tomcat8-tmp"

#making tmp directory to store tomcat8 tmp files
RUN mkdir -p /tmp/tomcat8-tomcat8-tmp

#Exposing 8080 port
#EXPOSE 8080

#Run /usr/share/tomcat8/bin/catalina.sh as tomcat8 user
USER tomcat8

CMD ["/usr/share/tomcat8/bin/catalina.sh", "run"]


