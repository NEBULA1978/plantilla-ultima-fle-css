#!/bin/bash

# Nombre del archivo de texto
archivo_menu="menu2.txt"
cat $archivo_menu

# Nombre del archivo HTML de salida
archivo_html="menu.html"

# Función para generar el archivo HTML con un rango de líneas especificado
generar_html() {
  local primera_linea=$1
  local ultima_linea=$2

  # Encabezado del archivo HTML
  echo '<ul>' > "$archivo_html"

  # Contador de líneas
  local contador=0

  # Leer el archivo de texto línea por línea y generar elementos de lista HTML
  while IFS= read -r linea
  do
    contador=$((contador+1))

    # Verificar si la línea está dentro del rango especificado
    if [ $contador -ge $primera_linea ] && [ $contador -le $ultima_linea ]; then
      if [ -n "$linea" ]; then  # Ignorar líneas en blanco
        echo "  <li>$linea</li>" >> "$archivo_html"
      fi
    fi
  done < "$archivo_menu"

  # Cerrar la lista HTML
  echo '</ul>' >> "$archivo_html"

  echo "Menú HTML generado en $archivo_html"
}
cat $archivo_menu
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
