#!/bin/bash

# Nombre del archivo de texto
archivo_menu="menu.txt"

# Nombre del archivo HTML de salida
archivo_html="menu.html"

# Encabezado del archivo HTML
echo '<ul>' > "$archivo_html"

# Leer el archivo de texto línea por línea y generar elementos de lista HTML
while IFS= read -r linea
do
  echo "  <li><a href=\"#\">$linea</a></li>" >> "$archivo_html"
done < "$archivo_menu"

# Cerrar la lista HTML
echo '</ul>' >> "$archivo_html"

echo "Menú HTML generado en $archivo_html"
