FROM tomcat:8.5-jdk8-openjdk

COPY ./webapp.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
