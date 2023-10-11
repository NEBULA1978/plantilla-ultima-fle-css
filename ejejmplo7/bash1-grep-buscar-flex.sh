#!/bin/bash

opciones=(
    "Mostrar archivos del directorio actual:|ls"
    "Mostrar calendario:|cal"
    "Mostrar día de hoy:|date"
    "Ver wifi conectado en Linux Mint:|nmcli device wifi list"
    "Buscar 'flex-direction' en apuntes.txt:|grep 'flex-direction' apuntes.txt"
    "Buscar 'Propiedades CSS Flexbox' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de contenedor flexible (flex)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de contenedor flexible en línea (inline-flex)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de dirección de elementos flexibles (flex-direction)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de ajuste de línea de elementos flexibles (flex-wrap)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de propiedad compuesta (flex-flow)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de orden de elementos flexibles (order)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de tamaño inicial de elementos flexibles (flex-basis)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de factor de expansión de elementos flexibles (flex-grow)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de factor de compresión de elementos flexibles (flex-shrink)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de propiedad compuesta (flex)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de márgenes automáticos en elementos flexibles (margin: auto)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de alineación en la dirección principal (justify-content)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de alineación en la dirección secundaria (align-items)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de alineación individual en la dirección secundaria (align-self)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Buscar 'Ejemplo de alineación en la dirección secundaria (align-content)' en apuntes.txt:|grep 'flex' apuntes.txt"
    "Volver al menú anterior:|break"
)

while true; do
    clear
    echo "MENU SCRIPT V.2"
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

        if [ -z "$seleccion" ]; then
            echo "Esta es la descripción de la opción $opcion."
            read -p "Presione Enter para continuar..."
        elif [ "$seleccion" == "break" ]; then
            echo "¡Hasta luego!"
            exit 0
        else
            eval "$seleccion" # Ejecutamos el comando.
            read -p "Presione Enter para continuar..."
        fi
    else
        echo "Opción inválida. Presione Enter para continuar..."
    fi
done
