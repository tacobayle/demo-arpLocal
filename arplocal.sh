#!/bin/bash
echo "Copying the github repos"
ansible-playbook git.yml
echo "#####################################"
echo "Copying the Ansible hostfile"
cp hostsArpLocal aviLsc/hosts
cp hostsArpLocal cs/hosts
cp hostsArpLocal aviBootstrap/hosts
cp hostsArpLocal aviLscCloud/hosts
cp hostsArpLocal vyos/hosts
echo "#####################################"
echo "Copying the config files"
cp params_aviLsc.yml aviLsc/vars/params.yml
cp params_aviBootstrap.yml aviBootstrap/vars/params.yml
cp vyos_arplocal.conf vyos/config.conf
cp params_vyos.yml vyos/vars/params.yml
cp params_cs cs/vars/params.yml
cp params_aviLscCloud.yml aviLscCloud/vars/params.yml
cp params_aviAlerts.yml aviAlerts/vars/params.yml
echo "#####################################"
echo "Apply the configuration"
cd aviLsc
ansible-playbook -i hosts generateCreds.yml
cd ../vyos
ansible-playbook -i hosts vyos.yml
cd ../cs
ansible-playbook -i hosts main.yml
cd ../aviBootstrap
ansible-playbook -i hosts main.yml
cd ../aviLscCloud
ansible-playbook -i hosts main.yml
cd ../aviAlerts
ansible-playbook configureAlerts.yml
cd ..
rm -fr aviBootstrap aviLsc aviLscCloud cs vyos aviAlerts
