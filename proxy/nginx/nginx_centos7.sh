#!/bin/bash
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "             Install and Configured Nginx\x1b[0m"
echo -e "   \x1b[0m\x1b[1m\x1b[31m"
echo -e "             ByteSec Pvt Ltd\x1b[0m                              "
echo -e "================================================================"
read -p "Upstream server IP Address [1.1.1.1:port]: " VDOMAIN
while [[ -z "$VDOMAIN" ]]
do
  read -p "You Must Upstream service IP Address [1.1.1.1]: " VDOMAIN
done
read -p "Nginx machine ip address or domain name (server_name)" VPSIP
while [[ -z "$VPSIP" ]]
do
  read -p "Nginx machine ip address or domain name (server_name)" VPSIP
done
read -p "Provide Service name: " SERNAME
while [[ -z "$SERNAME" ]]
do
  read -p "Provide Service name: " SERNAME
done
rpm -Uvh http://mirror.webtatic.com/yum/el7/webtatic-release.rpm
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "Updating... Server\x1b[0m"
echo -e "======================================="
yum update -y
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "Install Dependency packages for nginx\x1b[0m"
echo -e "======================================="
yum install epel-release vim firewalld -y
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "Install nginx\x1b[0m"
echo -e "======================================="
yum install nginx -y
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "nginx installed"
echo -e "Configuring Firewall for nginx\x1b[0m"
echo -e "======================================="
systemctl start firewalld && systemctl enable firewalld
firewall-cmd --permanent --add-service=https --zone=trusted &&
firewall-cmd --permanent --add-service=http --zone=trusted &&
firewall-cmd --permanent --remove-service=http --zone=public &&
firewall-cmd --permanent --remove-service=https --zone=public &&
firewall-cmd --set-default-zone=trusted &&
firewall-cmd --reload
systemctl start nginx && systemctl enable nginx && systemctl status nginx
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "Creating new config file for nginx\x1b[0m"
echo -e "======================================="
touch /etc/nginx/conf.d/${SERNAME}.conf

(cat <<EOF
upstream ${SERNAME} {
    server 3.93.194.141:80;
}

# upstream http_service {
    # server 18.234.82.114:80;
# }

server {
    listen 80 default_server;  # Added default_server to handle unmatched requests
    server_name ${VPSIP};

    location / {
        proxy_pass http://${SERNAME};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}

# server {
    # listen 8080 default_server;  # Added default_server to handle unmatched requests
    # server_name 192.168.1.5:8080;

    # location / {
        # proxy_pass http://http2_service;
        # proxy_set_header Host \$host;
        # proxy_set_header X-Real-IP \$remote_addr;
        # proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        # proxy_connect_timeout 60s;
        # proxy_send_timeout 60s;
        # proxy_read_timeout 60s;
    # }
# }
EOF
) >> /etc/nginx/conf.d/${SERNAME}.conf
nginx -t
echo -e "\x1b[0m\x1b[1m\x1b[32m"
echo -e "If no error restart nginx and check all details in conf file"
echo -e "\x1b[0m"
echo -e "======================================="