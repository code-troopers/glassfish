FROM tifayuki/java:7
MAINTAINER Feng Honglin <hfeng@tutum.co>
MAINTAINER Cedric Gatay <c.gatay@code-troopers.com>

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip && \
    unzip glassfish-3.1.2.2.zip -d /opt && \
    rm glassfish-3.1.2.2.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish3/bin:$PATH

ADD run.sh /run.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 8181

CMD ["/run.sh"]
