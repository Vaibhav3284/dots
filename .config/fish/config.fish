if status is-interactive
    # Commands to run in interactive sessions can go here

    function fish_greeting
        #
    end
end

# Starship auto start
starship init fish | source

# Hints
set -U fish_autosuggestion_enabled 1
set -g fish_color_autosuggestion 586e75
