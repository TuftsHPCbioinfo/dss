FROM tuftsttsrt/miniforge:25.3.1

LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"
LABEL description="Tufts Data Science for Sustainability teaching image with a compatible scientific Python and Jupyter stack"

ENV DSS_ENV=/opt/miniforge/envs/dss-pyfix \
    PATH="/opt/miniforge/envs/dss-pyfix/bin:/opt/miniforge/bin:${PATH}" \
    MPLBACKEND=Agg \
    PROJ_DATA=/opt/miniforge/envs/dss-pyfix/share/proj \
    PROJ_LIB=/opt/miniforge/envs/dss-pyfix/share/proj \
    GDAL_DATA=/opt/miniforge/envs/dss-pyfix/share/gdal \
    PIP_NO_CACHE_DIR=1

# Build a clean environment instead of modifying the inherited base environment.
# This avoids loading stale pip and Conda binary files from different SciPy builds.
RUN conda config --system --set channel_priority strict \
    && conda clean --all --yes \
    && conda create --yes --prefix "${DSS_ENV}" --channel conda-forge \
        python=3.12 \
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
    && "${DSS_ENV}/bin/python" -m ipykernel install \
        --prefix=/opt/miniforge \
        --name=dss-pyfix \
        --display-name="Python 3 (DSS updated)" \
    && conda clean --all --yes \
    && rm -rf /root/.cache/pip

COPY validate-python-stack /usr/local/bin/validate-python-stack

RUN chmod 0755 /usr/local/bin/validate-python-stack \
    && /usr/local/bin/validate-python-stack
