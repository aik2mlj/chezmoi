function conda-init -d "initialize conda shell functions"
    if type conda | grep -q alias
        echo "initializing conda..."
        eval ~/miniconda3/bin/conda "shell.fish" hook $argv | source
    end
end
