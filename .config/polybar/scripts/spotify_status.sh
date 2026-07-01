#!/bin/bash

# Configuración
MAX_LENGTH=35

# Comprobar si corre Spotify
if ! playerctl --player=spotify status &>/dev/null; then
    echo ""
    exit 0
fi

STATUS=$(playerctl --player=spotify status)
# Obtenemos metadata limpia
ARTIST=$(playerctl --player=spotify metadata artist)
TITLE=$(playerctl --player=spotify metadata title)

# Formato: Artista - Titulo
TEXT="$ARTIST - $TITLE"

# Cortar texto si es muy largo
if [ ${#TEXT} -gt $MAX_LENGTH ]; then
    TEXT=$(echo "$TEXT" | cut -c 1-$MAX_LENGTH)...
fi

# ICONOS (Usamos la fuente de iconos, índice 2 en polybar -> %{T2})
# TEXTO (Usamos la fuente cursiva, índice 1 en polybar -> %{T1})

if [ "$STATUS" = "Playing" ]; then
    # El %{T2} activa la fuente de iconos, %{T-} vuelve a la normal (cursiva)
    echo "%{T2} %{T-}$TEXT"
elif [ "$STATUS" = "Paused" ]; then
    echo "%{T2} %{T-}$TEXT"
else
    echo ""
fi
