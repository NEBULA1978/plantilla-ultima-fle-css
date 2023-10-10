#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Mostrar archivos del directorio actual:|ls"
    "Mostrar calendario:|cal"
    "Mostrar dia de hoy:|date"
    "Ver wifi conectado en Linux Mint:|nmcli device wifi list"
    "Consultas SQL en MySQL:|mysql_menu"  # Opción para consultas SQL en MySQL
    "Salir:|exit 0"
)

# Función para el menú de consultas SQL en MySQL
mysql_menu() {
    clear
    echo "Menú de Consultas SQL en MySQL"
    echo "==============================="
    echo "1. Consulta básica: SELECT * FROM ingeniero;"
    echo "2. Consulta JOIN: Consulta de ejemplo con JOIN."
    echo "3. Consulta GROUP BY: Consulta con GROUP BY."
    echo "4. Consulta HAVING: Consulta con HAVING."
    echo "5. Opciones de optimización: Consejos para optimizar consultas SQL."
    echo "6. Volver al menú principal"
    echo "==============================="
    read -p "Ingrese el número de la opción: " sql_option

    case $sql_option in
        1)
            # Consulta básica
            mysql -u usuario -pcontraseña -D basededatos -e "SELECT * FROM ingeniero"
            ;;
        2)
            # Consulta con JOIN
            mysql -u usuario -pcontraseña -D basededatos -e "SELECT tarea.id, tarea.fecha_inicio, tarea.fecha_termino, tarea.fecha_estimada, proyecto.nombre_proyecto FROM tarea INNER JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id INNER JOIN proyecto ON tarea.id_proyecto = proyecto.id WHERE ingeniero.nombre = 'Nombre del Ingeniero';"
            ;;
        3)
            # Consulta con GROUP BY
            mysql -u usuario -pcontraseña -D basededatos -e "SELECT proyecto.nombre_proyecto, ingeniero.nombre, COUNT(tarea.id) as cantidad_tareas FROM tarea JOIN proyecto ON tarea.id_proyecto = proyecto.id JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id GROUP BY proyecto.nombre_proyecto, ingeniero.nombre;"
            ;;
        4)
            # Consulta con HAVING
            mysql -u usuario -pcontraseña -D basededatos -e "SELECT ingeniero.nombre, COUNT(tarea.id) as cantidad_tareas FROM tarea JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id GROUP BY ingeniero.nombre HAVING COUNT(tarea.id) > 5;"
            ;;
        5)
            # Opciones de optimización
            clear
            echo "Opciones de optimización de consultas SQL:"
            echo "1. Utiliza índices"
            echo "2. Evita las subconsultas"
            echo "3. Evita el uso de operaciones costosas"
            echo "4. Utiliza el tipo de datos adecuado"
            echo "5. Limita el número de resultados"
            echo "6. Evita el uso de SELECT *"
            echo "7. Mantén la base de datos optimizada"
            echo "8. Volver al menú anterior"
            read -p "Ingrese el número de la opción: " optimization_option

            case $optimization_option in
                1)
                    # Opción de índices
                    echo "CREATE INDEX idx_nomina ON ingeniero (nomina);" | mysql -u usuario -pcontraseña -D basededatos
                    ;;
                2)
                    # Opción de evitar subconsultas
                    # Puedes proporcionar ejemplos aquí
                    ;;
                3)
                    # Opción de evitar operaciones costosas
                    # Puedes proporcionar ejemplos aquí
                    ;;
                4)
                    # Opción de tipo de datos adecuado
                    # Puedes proporcionar ejemplos aquí
                    ;;
                5)
                    # Opción de limitar resultados
                    # Puedes proporcionar ejemplos aquí
                    ;;
                6)
                    # Opción de evitar SELECT *
                    # Puedes proporcionar ejemplos aquí
                    ;;
                7)
                    # Opción de mantenimiento de la base de datos
                    # Puedes proporcionar ejemplos aquí
                    ;;
                8)
                    # Volver al menú anterior
                    ;;
                *)
                    echo "Opción inválida."
                    ;;
            esac
            ;;
        6)
            # Volver al menú principal
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac

    read -p "Presione Enter para continuar..."
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
    else
        echo "Opción inválida. Presione Enter para continuar..."
    fi
done
