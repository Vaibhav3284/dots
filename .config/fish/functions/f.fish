function f
    # fzf tiene un flag --preview que ejecuta un comando
    # por cada línea que seleccionas.
    # Usamos 'eza' para mostrar el contenido de ese directorio.
    set -l dir (fd --type d . $HOME | fzf --preview 'eza --icons --color=always --git --long {}')

    if test -n "$dir"
        cd "$dir"
    end
end
