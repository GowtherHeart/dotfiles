function venv
    set -l venv_dir ~/.venv

    if test (count $argv) -ne 1
        echo "Usage: venv <environment-name>"
        return 1
    end

    set -l env_path $venv_dir/$argv[1]

    if test -d $env_path
        source $env_path/bin/activate.fish
    else
        echo "Virtual environment '$argv[1]' not found."
        return 1
    end
end
