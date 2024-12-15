FROM rockylinux:9.3
MAINTAINER Victor Vlasák <developer@vvlasy.cz>

ENTRYPOINT [ "/init" ]

# RADIUS Authentication Messages
EXPOSE 1812/udp

# RADIUS Accounting Messages
EXPOSE 1813/udp

# Install freeradius with ldap support
RUN yum -y install freeradius-ldap \
        && yum -y update \
        && yum -y clean all

# Install tini init
ENV TINI_VERSION v0.10.0
RUN curl -L https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini > /usr/bin/tini \
        && chmod +x /usr/bin/tini

# Copy our configuration
COPY ldap /etc/raddb/mods-available/
COPY eap /etc/raddb/mods-available/
COPY init /
