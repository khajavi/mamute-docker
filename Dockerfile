FROM centos:7

MAINTAINER Jef Verelst, https://github.com/kullervo16

RUN yum install -y unzip java-1.7.0-openjdk java-1.7.0-openjdk-devel && yum clean all

ADD https://github.com/caelum/mamute/releases/download/v1.4.0/mamute-1.4.0.war /opt/mamute/
WORKDIR /opt/mamute
RUN unzip /opt/mamute/mamute-1.4.0.war
ADD startup.sh /opt/mamute/
RUN chmod +x /opt/mamute/*.sh
ADD hibernate.cfg.xml /opt/mamute/WEB-INF/classes/development/hibernate.cfg.tmp

EXPOSE 8080
ENTRYPOINT ["/opt/mamute/startup.sh"]

# variables to specify at startup
#ENV DB_HOST the host that runs the database
ENV DB_PORT 3306
#ENV DB_USER the user to connect to the DB
#ENV DB_PWD  the password
#ENV DB_NAME the database name
ENV MAMUTE_HOST localhost # change this when you want to expose it on a public hostname
ENV MAMUTE_PORT 8080

