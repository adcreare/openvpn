#build the CA
./easyrsa init-pki
./easyrsa build-ca nopass


##clients
#Make the request
./easyrsa gen-req client1-lappy nopass

#sign the request
./easyrsa sign-req client client1-lappy 


##server
./easyrsa gen-req server nopass
./easyrsa sign-req server server

./easyrsa gen-dh


##Copy keys
cp pki/ca.crt /etc/openvpn

cp pki/issued/server.crt /etc/openvpn/
cp pki/private/server.key /etc/openvpn/

cp pki/dh.pem /etc/openvpn/

cd /etc/openvpn
sudo openvpn --genkey --secret ta.key
