FROM tuftsttsrt/miniforge:25.3.1

LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"
LABEL description="Tufts Data Science for Sustainability teaching image with a compatible scientific Python and Jupyter stack"

ENV PATH="/opt/miniforge/bin:${PATH}" \
    MPLBACKEND=Agg \
    PIP_NO_CACHE_DIR=1

# Install the compiled scientific stack in one conda-forge transaction. Keeping
# NumPy, SciPy, pandas, and statsmodels under one solver avoids ABI/API mismatches
# caused by updating with Conda and then replacing packages with pip.
RUN conda config --system --set channel_priority strict \
    && conda install --yes --name base --channel conda-forge --update-deps \
        beautifulsoup4 \
        geopandas \
        graphviz \
        imbalanced-learn \
        ipykernel \
        ipython \
        ipywidgets \
        jupyter_client \
        jupyter_core \
        jupyter_server \
        jupyterlab \
        matplotlib \
        nbconvert \
        nbformat \
        notebook \
        numpy \
        pandas \
        patsy \
        pymupdf \
        python-graphviz \
        scikit-learn \
        scipy \
        seaborn \
        statsmodels \
    && conda clean --all --yes \
    && rm -rf /root/.cache/pip

COPY validate-python-stack /usr/local/bin/validate-python-stack

RUN chmod 0755 /usr/local/bin/validate-python-stack \
    && /usr/local/bin/validate-python-stack
