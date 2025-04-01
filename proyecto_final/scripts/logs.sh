#!/bin/bash

LOGFILE="../logs/eventos.log"

# Crear el archivo de logs vacío
> "$LOGFILE"

# Eventos y usuarios simulados
EVENTOS=("INFO" "WARNING" "ERROR" "LOGIN" "BACKUP")
USUARIOS=("admin1" "tecnico1" "auditor1" "usuarioX")

# Generar 30 líneas de log con datos aleatorios
for i in {1..30}; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    EVENTO=${EVENTOS[$RANDOM % ${#EVENTOS[@]}]}
    USUARIO=${USUARIOS[$RANDOM % ${#USUARIOS[@]}]}
    echo "$TIMESTAMP [$EVENTO] Usuario:$USUARIO - Mensaje de prueba para comprobar que funciona el archivo" >> "$LOGFILE"
done

echo "Logs generados en $LOGFILE"
