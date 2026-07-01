#!/bin/sh

# Busca automáticamente el primer dispositivo tipo 'headset' o 'headphone'
# Usa upower que es estándar en la mayoría de distros Linux
DEVICE=$(upower -e | grep -E 'headset|headphone' | head -n 1)

if [ -z "$DEVICE" ]; then
    # No hay audífonos detectados
    echo "‹›"
else
    # Extrae el porcentaje
    PERCENTAGE=$(upower -i "$DEVICE" | grep percentage | awk '{print $2}' | tr -d '%')
    
    # Si tenemos un número (están conectados), lo mostramos
    if [ ! -z "$PERCENTAGE" ]; then
        echo "$PERCENTAGE ∙"
    else
        echo ""
    fi
fi
