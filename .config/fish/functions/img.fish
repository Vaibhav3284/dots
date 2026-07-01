function img
    switch $argv[1]
        case '.'
            sxiv -tr .
        case '*'
            sxiv -b $argv[1]
    end
end
