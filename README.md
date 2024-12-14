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


