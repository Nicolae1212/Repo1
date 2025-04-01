#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[0;33m'
SC='\033[0m' # Sin color

# Log de actividad
LOGFILE="../logs/actividad.log"

# Función para mostrar el menú
menu() {
    clear
    echo -e "${AMARILLO}=== Menú de Administración ===${SC}"
    echo "1. Crear estructura de usuarios y permisos"
    echo "2. Generar y analizar logs"
    echo "3. Crear backup de directorios críticos (simulado)"
    echo "4. Mostrar espacio disponible en disco"
    echo "5. Limpiar archivos temporales viejos"
    echo "6. Salir"
    echo -n "Seleccione una opción: "
}

# Función para registrar las acciones
registrar_actividad() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") - $1" >> "$LOGFILE"
}

# Función de backup (simulado)
backup() {
    echo -e "${VERDE}Creando backup...${SC}"
    bash scripts/respaldar.sh
    registrar_actividad "Backup de directorios ejecutado."
}

# Función para mostrar espacio en disco
espacio_disco() {
    echo -e "${AMARILLO}Espacio en disco:${SC}"
    df -h | grep "/dev/"
    registrar_actividad "Espacio en disco consultado."
}

# Función para limpiar archivos temporales
limpiar_temp() {
    echo -e "${ROJO}Eliminando archivos temporales en /tmp...${SC}"
    bash scripts/limpiar_temp.sh
    registrar_actividad "Archivos temporales eliminados."
}

# Loop del menú
while true; do
    menu
    read -r opcion
    case $opcion in
        1) 
            bash scripts/usuarios.sh
            registrar_actividad "Estructura de usuarios y permisos creada."
            ;;
        2) 
            bash scripts/logs.sh
            registrar_actividad "Logs generados y analizados."
            ;;
        3) 
            backup
            ;;
        4) 
            espacio_disco
            ;;
        5) 
            limpiar_temp
            ;;
        6) 
            echo -e "${ROJO}Saliendo...${SC}"
            registrar_actividad "El programa fue cerrado."
            exit 0
            ;;
        *) 
            echo -e "${ROJO}Opción no válida, intente de nuevo.${SC}"
            ;;
    esac
    echo -e "\nPresione Enter para continuar..."
    read -r
done
