#!/bin/bash
conn=$(ansible webservers -m ping)
status=$(ansible webservers -m command -a "/bin/systemctl status bind9" | grep "Active: active")
if [ ! "$conn" ];then
    echo "Conexion Fallida"
else
        echo "Conexion Establecida"
        if [ -z "$status" ];then
                echo "El servicio ya esta desinstalado"
        else
                echo "Servicio instalado"
                echo "Procedemos a desinstalarlo"
                ansible-playbook -v /etc/ansible/desinstalar_bind9.yaml --extra-vars "ansible_sudo_pass=nando"
                echo "Servicio desinstalado"
        fi
fi