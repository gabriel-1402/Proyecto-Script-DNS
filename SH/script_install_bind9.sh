#!/bin/bash
conn=$(ansible webservers -m ping)
status=$(ansible webservers -m command -a "/bin/systemctl status bind9" | grep "Active: active")
if [ ! "$conn" ];then
    echo "Conexion Fallida"
else
        echo "Conexion Establecida"
        if [ -z "$status" ];then
                echo "Servicio no instalado"
                echo "Procedemos a instalarlo"
                ansible-playbook -v /etc/ansible/instalar_bind9.yaml --extra-vars "ansible_sudo_pass=nando"
                echo "Servicio instalado"
        else
                echo "Servicio instalado"
        fi
fi

