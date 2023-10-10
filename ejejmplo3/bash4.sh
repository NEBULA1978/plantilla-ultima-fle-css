#!/bin/bash

# Nombre del archivo de texto
archivo_menu="menu2.txt"

# Función para mostrar el archivo con líneas numeradas
mostrar_archivo_numerado() {
  local contador=1
  while IFS= read -r linea
  do
    printf "%d %s\n" "$contador" "$linea"
    contador=$((contador+1))
  done < "$archivo_menu"
}

# Mostrar el archivo con líneas numeradas
echo "El archivo $archivo_menu tiene $(wc -l < "$archivo_menu") líneas."
mostrar_archivo_numerado

# Nombre del archivo HTML de salida
archivo_html="menu.html"

# Función para generar el archivo HTML con un rango de líneas especificado
generar_html() {
  local primera_linea=$1
  local ultima_linea=$2

  # Contador de líneas
  local contador=0

  # Leer el archivo de texto línea por línea y almacenar líneas en un array
  local lineas=()
  while IFS= read -r linea
  do
    contador=$((contador+1))

    # Verificar si la línea está dentro del rango especificado
    if [ $contador -ge $primera_linea ] && [ $contador -le $ultima_linea ]; then
      if [ -n "$linea" ]; then  # Ignorar líneas en blanco
        lineas+=("$linea")
      fi
    fi
  done < "$archivo_menu"

  # Leer el contenido actual del archivo HTML
  contenido_actual=$(<"$archivo_html")

  # Insertar las líneas en la línea 9 del contenido HTML
  for ((i=${#lineas[@]}-1; i>=0; i--))
  do
    contenido_actual=$(sed -e "9i${lineas[i]}" <<< "$contenido_actual")
  done

  # Escribir el contenido actualizado en el archivo HTML
  echo "$contenido_actual" > "$archivo_html"

  echo "Líneas insertadas en la línea 9 de $archivo_html"
}

# Solicitar al usuario el número de la primera línea
read -p "Ingrese el número de la primera línea: " primera_linea

# Solicitar al usuario el número de la última línea
read -p "Ingrese el número de la última línea: " ultima_linea

# Verificar que los números ingresados sean válidos
if [[ ! $primera_linea =~ ^[0-9]+$ || ! $ultima_linea =~ ^[0-9]+$ || $primera_linea -gt $ultima_linea || $primera_linea -lt 1 ]]; then
  echo "Entrada no válida. Asegúrese de ingresar números válidos y que el rango sea correcto."
  exit 1
fi

# Generar el archivo HTML con el rango especificado
generar_html "$primera_linea" "$ultima_linea"
