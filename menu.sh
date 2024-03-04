#!/bin/bash


while true; do

echo "----------------------"
echo "MENU DEL SCRIPT"
echo "----------------------"
echo "1. Datos de red del equipo"
echo "2. Estado del servicio"
echo "3. Instalación del servicio"
echo "4. Salir"
echo ""
read -p "Dime una opción: " opcion 

echo ""

case $opcion in

1)
IP=$(ifconfig enp0s3 | grep inet | grep -v inet6 | awk -F " " '{print$2}')
Mascara=$(ifconfig enp0s3 | grep inet | grep -v inet6 | awk -F " " '{print$4}')
Broadcast=$(ifconfig enp0s3 | grep inet | grep -v inet6 | awk -F " " '{print$6}')
echo "La IP de red es: $IP"
echo "La máscara de red es: $Mascara"
echo "El broadcast de red es: $Broadcast"
echo ""

;;

2)
systemctl status bind9 2> /dev/null | grep "could not be found"
if [ "$?" -ne 0 ];then 

echo "El servicio no está instalado"

else

systemctl status bind9 2> /dev/null | grep "Active: active"
echo "El servicio está instalado"
fi



;;

3)
	while true;do

	echo "----------------------"
	echo "INSTALACION DEL SERVICIO BIND9"
	echo "----------------------"
	echo "1. Con comandos"
	echo "2. Con docker"
	echo "3. Con ansible"
	echo "4. Salir"
	echo ""
	read -p "Dime una opción: " opcion2

	echo ""

	case "$opcion2" in

	1)
	echo "Realizando actualización de paquetes en la máquina..."
        echo ""

	comprobacion=$(sudo apt update > /dev/null)

	if [ "$comprobacion" | grep -E "Err" ];
	then
	echo ""
	echo "Actualización NO realizada..."
	echo ""
	break
	else
	echo ""
	echo "Actualización de paquetes realizada con éxito..."
	continue

	fi

	echo "---------------------------------------------------"
	echo "Realizando instalación de BIND9..."
        echo ""

	echo "Realizando actualización de paquetes en la máquina..."
        echo ""

	;;

	2)

	;;

	3)

	;;

	4)
	echo "Saliendo del menu instalador ... "
	echo ""
	break
	;;

	*)

	echo "Elija una opcion del menu"
	;;
	esac



	done

;;

4)
echo "Saliendo del menú..."
echo ""
break

;;

esac

done
