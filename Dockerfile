#Dockerfile :: Openvpn on Ubuntu 14.04 

#Ubuntu base image
FROM phusion/baseimage

#Install openvpn easy-rsa 
RUN apt-get update && \
    apt-get install -y iptables openvpn iptables curl && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

#COPY ovpn_env.sh /etc/openvpn
#COPY openssl-1.0.cnf /usr/share/easy-rsa
#RUN mv /usr/share/easy-rsa /usr/share/easy-rsa.bak

ADD ./easy-rsa /usr/share/easy-rsa
ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
RUN ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin

#RUN mv /etc/openvpn /etc/openvpn.bak

VOLUME ["/etc/openvpn"]

# Prevents refused client connection because of an expired CRL
ENV EASYRSA_CRL_DAYS 3650

ENV PATH $PATH:/etc/openvpn/easy-rsa


# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

#CMD ["ovpn_run"]

# Setup Supervisor
#RUN apt-get -y install supervisor
#RUN mkdir -p /var/log/supervisor

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

#COPY copy.sh /root

#ENTRYPOINT ["chmod", "+x", "/root/copy.sh"]
