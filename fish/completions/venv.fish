function __list_venvs
    set -l venv_dir ~/.venv/
    for dir in $venv_dir/*
        if test -d $dir
            echo (basename $dir)
        end
    end
end


complete -c venv -f -a "(__list_venvs)"
