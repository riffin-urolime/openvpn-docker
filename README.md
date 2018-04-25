# openvpn-docker
Openvpn Docker

Clone the repo

docker-compose build

docker-compose up &

Bash into the docker and perform the following:

ovpn_genconfig -u udp://vpn.server.com
ovpn_initpki
ovpn_run &

To create a client certificate:

easyrsa build-client-full USERNAME nopass
ovpn_getclient USERNAME > USERNAME.ovpn

To revoke a client:

ovpn_revokeclient USERNAME
ovpn_revokeclient USERNAME remove
