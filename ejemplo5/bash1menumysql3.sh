#!/bin/bash

# Solicitar al usuario el nombre de usuario, contraseña y nombre de la base de datos
read -pr "Introduce el nombre de usuario de MySQL: " usuario
read -s -pr "Introduce la contraseña de MySQL: " contrasena
echo # Imprimir una nueva línea
read -pr "Introduce el nombre de la base de datos: " basededatos

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
    while true; do
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
        read -pr "Ingrese el número de la opción: " sql_option

        case $sql_option in
            1)
                # Consulta básica
                mysql -u "$usuario" -p"$contrasena" -D "$basededatos" -e "SELECT * FROM ingeniero"
                ;;
            2)
                # Consulta con JOIN
                mysql -u "$usuario" -p"$contrasena" -D "$basededatos" -e "SELECT tarea.id, tarea.fecha_inicio, tarea.fecha_termino, tarea.fecha_estimada, proyecto.nombre_proyecto FROM tarea INNER JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id INNER JOIN proyecto ON tarea.id_proyecto = proyecto.id WHERE ingeniero.nombre = 'Nombre del Ingeniero';"
                ;;
            3)
                # Consulta con GROUP BY
                mysql -u "$usuario" -p"$contrasena" -D "$basededatos" -e "SELECT proyecto.nombre_proyecto, ingeniero.nombre, COUNT(tarea.id) as cantidad_tareas FROM tarea JOIN proyecto ON tarea.id_proyecto = proyecto.id JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id GROUP BY proyecto.nombre_proyecto, ingeniero.nombre;"
                ;;
            4)
                # Consulta con HAVING
                mysql -u "$usuario" -p"$contrasena" -D "$basededatos" -e "SELECT ingeniero.nombre, COUNT(tarea.id) as cantidad_tareas FROM tarea JOIN ingeniero ON tarea.id_ingeniero = ingeniero.id GROUP BY ingeniero.nombre HAVING COUNT(tarea.id) > 5;"
                ;;
            5)
                # Opciones de optimización
                while true; do
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
                            echo "Ejemplo: CREATE INDEX idx_nomina ON ingeniero (nomina);"
                            read -p "Presione Enter para continuar..."
                            ;;
                        2)
                            # Opción de evitar subconsultas
                            echo "Ejemplo: En lugar de subconsultas, utiliza JOIN o expresiones de tabla comunes (CTE)."
                            read -p "Presione Enter para continuar..."
                            ;;
                        3)
                            # Opción de evitar operaciones costosas
                            echo "Ejemplo: Evita operaciones costosas como ordenación o cálculos matemáticos complejos."
                            read -p "Presione Enter para continuar..."
                            ;;
                        4)
                            # Opción de tipo de datos adecuado
                            echo "Ejemplo: Utiliza el tipo de datos más adecuado para cada columna, como int unsigned en lugar de varchar."
                            read -p "Presione Enter para continuar..."
                            ;;
                        5)
                            # Opción de limitar resultados
                            echo "Ejemplo: Utiliza la cláusula LIMIT para limitar el número de resultados devueltos por la consulta."
                            read -p "Presione Enter para continuar..."
                            ;;
                        6)
                            # Opción de evitar SELECT *
                            echo "Ejemplo: En lugar de SELECT *, especifica las columnas que deseas seleccionar."
                            read -p "Presione Enter para continuar..."
                            ;;
                        7)
                            # Opción de mantenimiento de la base de datos
                            echo "Ejemplo: Realiza tareas de mantenimiento, como la eliminación de registros innecesarios o la optimización de tablas."
                            read -p "Presione Enter para continuar..."
                            ;;
                        8)
                            # Volver al menú anterior
                            break
                            ;;
                        *)
                            echo "Opción inválida."
                            read -p "Presione Enter para continuar..."
                            ;;
                    esac
                done
                ;;
            6)
                # Volver al menú principal
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
    else
        echo "Opción inválida. Presione Enter para continuar..."
        read -p "Presione Enter para continuar..."
    fi
done
