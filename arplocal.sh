#!/bin/bash
echo "Copying the github repos"
ansible-playbook git.yml
echo "#####################################"
echo "Copying the Ansible hostfile"
cp hostsArpLocal cs/hosts
cp hostsArpLocal aviBootstrap/hosts
cp hostsArpLocal aviLscCloud/hosts
cp hostsArpLocal vyos/hosts
echo "#####################################"
echo "Copying the config files"
cp params_aviBootstrap.yml aviBootstrap/vars/params.yml
cp vyos_arplocal.conf vyos/config.conf
cp params_vyos.yml vyos/vars/params.yml
cp params_cs cs/vars/params.yml
cp params_aviLscCloud.yml aviLscCloud/vars/params.yml
echo "#####################################"
echo "Apply the configuration"
cd vyos
ansible-playbook -i hosts vyos.yml
cd ../cs
ansible-playbook -i hosts main.yml
cd ../aviBootstrap
ansible-playbook -i hosts main.yml
cd ../aviLscCloud
ansible-playbook -i hosts main.yml
