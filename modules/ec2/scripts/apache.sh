#!/bin/bash
sudo su -
apt update -y
apt install apache2 -y
systemctl enable apache2
systemctl start apache2
apt install firewalld -y
firewall-cmd --zone=public --change-interface=eth0 --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --reload
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A PREROUTING -p icmp -j DNAT --to-destination 10.1.1.10
iptables -t nat -A POSTROUTING -p icmp -d 10.1.1.10 -j SNAT --to-source 10.0.1.10
iptables-save > /etc/iptables/rules.v4