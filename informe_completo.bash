#!/bin/bash

# Configuración estricta para manejar errores y excepciones
# set -e: Detiene el script si ocurre un error.
# set -u: Prohibe el uso de variables no inicializadas.
# set -o pipefail: Detecta fallos en cualquier etapa de una tubería.
set -euo pipefail

# ======================================
# Funciones del Script
# ======================================

# Imprime un encabezado con información del sistema
print_header() {
    echo "=============================="
    echo "Informe del sistema: $(hostname -s)"
    echo "=============================="
}

# Imprime la fecha y hora actual en el formato DD/MM/YYYY HH:MM:SS
print_date() {
    echo "Fecha y Hora: $(date '+%d/%m/%Y %H:%M:%S')"
    echo ""
}

# Muestra el espacio en disco para un punto de montaje especificado
get_disk_usage() {
    local mount_point="$1"
    if df -h "$mount_point" &> /dev/null; then
        echo "Uso del Disco para $mount_point:"
        df -h "$mount_point" | awk 'NR > 1 {print $5}'
    else
        echo "Error: No se pudo obtener información del disco para $mount_point."
        exit 1
    fi
}

# Muestra el uso del disco en otros puntos de montaje
get_additional_disks_usage() {
    echo "Uso del disco en otros puntos de montaje:"
    df -h | grep -E '/home|/var' || echo "No se encontraron puntos de montaje adicionales relevantes."
    echo ""
}

# Muestra los usuarios actualmente conectados al sistema
list_logged_in_users() {
    echo "Usuarios actualmente conectados al sistema:"
    who | awk '{print $1}' | sort | uniq
    echo ""
}

# Muestra el estado de la memoria del sistema
get_memory_usage() {
    echo "Estado de la memoria (en MB):"
    free -m | awk 'NR==1 || NR==2 {print $1, $2, $3, $4}' | column -t
    echo ""
}

# Muestra el estado de la CPU
get_cpu_usage() {
    echo "Estado de la CPU:"
    top -bn1 | grep "Cpu(s)" | awk '{print "Usado:", $2 + $4, "%"}'
    echo ""
}

# Lista los servicios en ejecución
list_running_services() {
    echo "Servicios activos en el sistema:"
    systemctl list-units --type=service --state=running | awk '{print $1, $2, $3}' | head -n 10
    echo ""
}

# Muestra estadísticas de red
get_network_stats() {
    echo "Estadísticas de Red:"
    netstat -i || echo "El comando 'netstat' no está disponible."
    echo ""
}

# Busca un proceso específico ingresado por el usuario
search_process() {
    while true; do
        read -p "Ingrese el proceso que desea buscar: " proceso
        if [[ -z "$proceso" ]]; then
            echo "Debe ingresar un nombre de proceso."
        else
            echo "Buscando procesos con el nombre '$proceso'..."
            procesos_encontrados=$(ps aux | grep -i --color=auto "$proceso" | grep -v grep || true)

            if [[ -z "$procesos_encontrados" ]]; then
                echo "No se encontraron procesos con el nombre '$proceso'. Vuelve a intentar."
            else
                echo "Procesos encontrados:"
                echo "$procesos_encontrados"
                break
            fi
        fi
    done
}

# Muestra los procesos con mayor consumo de recursos
get_top_processes() {
    echo "Procesos con mayor consumo de CPU:"
    ps -eo pid,user,comm,%cpu --sort=-%cpu | head -n 6 | column -t
    echo ""

    echo "Procesos con mayor consumo de Memoria:"
    ps -eo pid,user,comm,%mem --sort=-%mem | head -n 6 | column -t
    echo ""
}

# Muestra la temperatura del sistema (si está disponible)
get_system_temperature() {
    if command -v sensors &> /dev/null; then
        echo "Temperatura del sistema:"
        sensors | grep '°C' || echo "No se detectaron sensores de temperatura."
    else
        echo "El comando 'sensors' no está disponible."
    fi
    echo ""
}

# Proporciona información del sistema operativo
get_system_info() {
    echo "Información del Sistema Operativo:"
    uname -a
    lsb_release -a 2>/dev/null || echo "lsb_release no disponible"
    echo ""
}

# ======================================
# Lógica Principal
# ======================================

main() {
    # Configuración de log
    logfile="sistema_informe_$(date '+%Y%m%d_%H%M%S').log"
    exec > >(tee -i "$logfile") 2>&1

    # Imprime encabezado e información del sistema
    print_header

    # Muestra la fecha y hora actuales
    print_date

    # Muestra el uso del disco para el punto de montaje raíz
    get_disk_usage "/"

    # Muestra el uso del disco en otros puntos de montaje
    get_additional_disks_usage

    # Muestra el estado de la memoria del sistema
    get_memory_usage

    # Muestra el estado de la CPU
    get_cpu_usage

    # Lista los servicios en ejecución
    list_running_services

    # Muestra estadísticas de red
    get_network_stats

    # Lista los usuarios conectados al sistema
    list_logged_in_users

    # Muestra los procesos con mayor consumo de recursos
    get_top_processes

    # Muestra la temperatura del sistema
    get_system_temperature

    # Proporciona información del sistema operativo
    get_system_info

    # Realiza la búsqueda de un proceso específico
    search_process

    echo "Fin del informe. El log se ha guardado en: $logfile"
}

# ======================================
# Ejecución del Script
# ======================================
main
