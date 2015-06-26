## Expects easy-rsa2 has already been downloaded https://github.com/OpenVPN/easy-rsa/tree/master/easyrsa3

#step 1
mv  vars.example to vars


#step 2 build the CA
./easyrsa init-pki
./easyrsa build-ca nopass

#step 3 - build the DH key
./easyrsa gen-dh

#Step 4 - Generate the OpenVPN server certificate/key 
./easyrsa gen-req server nopass
./easyrsa sign-req server server

#(Optional) Step 5 - Create static secret 
openvpn --genkey --secret ta.key

# Step 6 - Create the client keys (repeat for each client) change client1-lappy to a name that suits your machine
./easyrsa gen-req client1-lappy nopass
./easyrsa sign-req client client1-lappy 


# Step 7 - Server - Copy the keys - and put them in the right folders 
cp pki/ca.crt /etc/openvpn
cp pki/issued/server.crt /etc/openvpn/
cp pki/private/server.key /etc/openvpn/
cp pki/dh.pem /etc/openvpn/
cp ta.key /etc/openvpn/

# Step 8 - Client - Copy over the following keys
#Certificate from the CA: ca.crt
#Client public key: client1-lappy.crt
#Client private key: client1-lappy.key
#(Optional) shared secret if you created on in step 5 ta.key

