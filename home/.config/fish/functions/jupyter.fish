function jupyter
    uv run \
        --with jupyter \
        --with python-localvenv-kernel \
        --with jupyterlab-vim \
        --with jupyter-ruff jupyter $argv
end
