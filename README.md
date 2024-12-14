# Informe del Sistema en Bash
## 📋 Descripción

*Este script de Bash es una herramienta poderosa y modular para monitorear el estado de tu sistema. Genera un informe detallado con información clave sobre rendimiento, recursos y procesos, además de guardar un archivo de log para referencias futuras.*

# 🚀 Funcionalidades

## 📅 Información General:
*-Fecha y hora actual.*

*-Información del sistema operativo y del kernel.*

## 💾 Recursos del Sistema:
*-Uso de disco (raíz y otros puntos de montaje).*

*-Estado de la memoria (en MB).*

*-Uso de la CPU (en %).*

*-Temperatura del sistema (si está disponible).*

## 🔍 Análisis y Monitorización:
*-Lista de usuarios conectados.*

*-Servicios activos en el sistema.*

*-Estadísticas de red.*

*-Procesos con mayor consumo de CPU y memoria.*

*-Búsqueda de procesos específicos.*

## 📂 Archivo de Log:
*-Guarda un informe detallado en un archivo de log con marca de tiempo.*

## 🛠️ Instalación y Uso
   
**1. Clona el repositorio:**   
   git clone https://github.com/tuusuario/tu-repositorio.git

   cd tu-repositorio
**2. Configura los permisos del script**
   Asegúrate de que el script tenga permisos de ejecución:

   chmod +x informe_completo.sh

**3. Ejecuta el script**
   ./informe_completo.sh

## 📝 Ejemplo de Salida
*-Salida en Terminal*

![image](https://github.com/user-attachments/assets/671a8c81-8eaa-4610-bbca-aadb67f92a3a)

![image](https://github.com/user-attachments/assets/af6b29fe-4b0c-4ed1-8441-a7aabe4eb0f5)

![image](https://github.com/user-attachments/assets/bcc65096-cb7f-4592-a406-184a061e9881)

![image](https://github.com/user-attachments/assets/507b86ef-3943-43b1-814a-aaf0130b4af9)

![image](https://github.com/user-attachments/assets/64a92587-5260-4bb0-9aaa-c6e2b20a3fb7)

![image](https://github.com/user-attachments/assets/ce29936a-4e97-4371-ba59-791bf1c8910a)

![image](https://github.com/user-attachments/assets/5619208b-6f72-4c2e-b294-d0f27134ac9e)

![image](https://github.com/user-attachments/assets/3ef96236-11c8-420a-b015-29b4b09e7ee2)

![image](https://github.com/user-attachments/assets/57b9d58f-7bc5-4b59-9469-6840c61bbc73)

![image](https://github.com/user-attachments/assets/a31d965e-b156-4f72-ba8a-1e3d1cb4848f)

![image](https://github.com/user-attachments/assets/4a277bb8-61b7-49b1-84bc-4baa6d7aa6d8)

## Archivo de Log
*Un archivo de log con la salida completa se genera automáticamente:*
**sistema_informe_20241214_191206.log**

## 🌟 Características Avanzadas
*-Modularidad: Cada funcionalidad está encapsulada en funciones independientes para facilitar la reutilización.*

*-Manejo de errores: Uso de set -euo pipefail para garantizar la robustez del script.*

*-Compatibilidad: Diseñado para adaptarse a la mayoría de distribuciones Linux (Ubuntu, Debian, CentOS, etc.).*

*-Logs automatizados: Útil para auditorías o seguimiento histórico del sistema.*

## 📦 Requisitos
**Este script utiliza los siguientes comandos. Asegúrate de tenerlos instalados:**

*-bash (interprete de shell)*

*-df, free, ps, who, top, netstat*

*-Opcional: sensors, lsb_release*

## 🛡️ Notas de Seguridad
**Ejecuta este script solo en sistemas en los que tengas permisos adecuados, ya que se accede a información del sistema que podría ser sensible.**

## 📧 Contacto
Para preguntas o sugerencias, contáctame en gabarra2000@hotmail.com

[Ver el script completo] 
[Uploading informe_completo.ba#!/bin/bash

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
sh…]()





























   
