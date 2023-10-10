#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Mostrar archivos del directorio actual:|ls"
    "Mostrar calendario:|cal"
    "Mostrar dia de hoy:|date"
    "Ver wifi conectado en Linux Mint:|nmcli device wifi list"
    "Convertir un formato de fichero texto desde MSDOS a UNIX:|dos2unix filedos.txt fileunix.txt"
    "Convertir un formato de fichero de texto desde UNIX a MSDOS:|unix2dos fileunix.txt filedos.txt"
    "Convertir un fichero de texto en HTML:|recode ..HTML < page.txt > page.html"
    "Mostrar todas las conversiones de formato disponibles:|recode -l | more"
    "Crear contenedor Docker con MySQL y persistir datos:|docker_menu"
    "Salir:|exit 0"
)

# Función para el menú de Docker y MySQL
docker_menu() {
    while true; do
        clear
        echo "Menú de Docker y MySQL"
        echo "==============================="
        echo "1. Descargar imagen de MySQL y crear contenedor"
        echo "2. Conectar al contenedor de MySQL"
        echo "3. Montar un volumen para persistir datos"
        echo "4. Salir al menú anterior"
        echo "==============================="
        read -p "Ingrese el número de la opción: " docker_option

        case $docker_option in
            1)
                # Descargar imagen de MySQL y crear contenedor
                docker run -d -p 33060:3306 --name mysql-db -e MYSQL_ROOT_PASSWORD=secret mysql
                ;;
            2)
                # Conectar al contenedor de MySQL
                docker exec -it mysql-db mysql -p
                ;;
            3)
                # Montar un volumen para persistir datos
                docker rm -f mysql-db
                docker volume prune
                docker volume create mysql-db-data
                docker run -d -p 33060:3306 --name mysql-db -e MYSQL_ROOT_PASSWORD=secret --mount src=mysql-db-data,dst=/var/lib/mysql mysql
                ;;
            4)
                # Volver al menú anterior
                break
                ;;
            *)
                echo "Opción inválida."
                read -p "Presione Enter para continuar..."
                ;;
        esac
    done
}

while true; do
    clear
    echo "MENU SCRIPT V.1"
    echo "==============================="
    echo "Escoja una opción:"
    for ((i=0; i<${#opciones[@]}; i++)); do
        echo "$i. ${opciones[i]%%:*}" # Imprimimos el índice y el nombre de la opción (sin el comando).
    done
    echo "==============================="
    read -p "Ingrese el número de la opción: " opcion

    if [[ $opcion =~ ^[0-9]+$ ]] && [ "$opcion" -ge 0 ] && [ "$opcion" -lt ${#opciones[@]} ]; then
        clear
        seleccion="${opciones[$opcion]#*|}" # Obtenemos el comando correspondiente a la opción seleccionada.
        eval "$seleccion" # Ejecutamos el comando.
        read -p "Presione Enter para continuar..."
    else
        echo "Opción inválida. Presione Enter para continuar..."
        read -p "Presione Enter para"
    fi
done
