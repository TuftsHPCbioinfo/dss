FROM tuftsttsrt/miniforge:24.11.2

# Author label
LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"

# Help message
LABEL description="This container is for Tufts Data Science for Sustainability class taught by Dr. Deborah Sunter"

# Update conda and clean
RUN conda update --all \
    && conda clean --all --yes \
    && rm -rf /root/.cache/pip

# Update some common python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt