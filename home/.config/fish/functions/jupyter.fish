function jupyter
    uv run \
        --with jupyter \
        --with python-localvenv-kernel \
        --with jupyterlab-vim \
        jupyter $argv
end
