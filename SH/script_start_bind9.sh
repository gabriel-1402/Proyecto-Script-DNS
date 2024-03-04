#!/bin/bash
conn=$(ansible webservers -m ping)
status=$(ansible webservers -m command -a "/bin/systemctl status bind9" | grep "Stopped BIND Domain Name Server")
if [ ! "$conn" ];then
    echo "Conexion Fallida"
else
        echo "Conexion Establecida"
        if [ -z "$status" ];then
                echo "Servicio iniciado"
        else
                echo "Servicio no iniciado"
                echo "Procedemos a iniciarlo"
                ansible-playbook -v /etc/ansible/start_bind9.yaml --extra-vars "ansible_sudo_pass=nando"
                echo "Servicio iniciado"
        fi
fi