#!/bin/bash

LOGFILE="../logs/eventos.log"
OUTPUT_FILE="../logs/informe_logs.txt"  # Archivo de salida para el informe

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

# ==========================================
# Análisis de los logs generados
# ==========================================

# Crear o limpiar el archivo de salida del informe
> "$OUTPUT_FILE"
echo "Análisis de Logs - $(date)" > "$OUTPUT_FILE"
echo "----------------------------" >> "$OUTPUT_FILE"

# 1. Número de errores (líneas con [ERROR])
ERRORES=$(grep -c "\[ERROR\]" "$LOGFILE")
echo "Número de errores: $ERRORES" >> "$OUTPUT_FILE"

# 2. Últimos 5 errores
echo -e "\nÚltimos 5 errores:" >> "$OUTPUT_FILE"
grep "\[ERROR\]" "$LOGFILE" | tail -5 >> "$OUTPUT_FILE"

# 3. Mensajes más frecuentes
echo -e "\nMensajes más frecuentes:" >> "$OUTPUT_FILE"
awk -F" " '{print $3}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 >> "$OUTPUT_FILE"

# 4. Usuarios con más actividad
echo -e "\nUsuarios con más actividad:" >> "$OUTPUT_FILE"
awk -F" " '{print $5}' "$LOGFILE" | cut -d":" -f2 | sort | uniq -c | sort -nr >> "$OUTPUT_FILE"

echo "Informe de análisis guardado en: $OUTPUT_FILE"

