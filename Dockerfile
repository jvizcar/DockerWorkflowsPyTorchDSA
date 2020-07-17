# from an official PyTorch image
FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime

# switch to the root user
USER root

# open up all permissions for /opt/conda - allows conda install from non-root users
# NOTE - this takes a while to run (~10 minutes)
RUN chmod 777 -R /opt/conda

# create user and switch to it
RUN useradd -ms /bin/bash mainuser
USER mainuser

# install additional Python libraries with conda
RUN conda install -y jupyter=1.0.0 \
					 pandas=1.0.5 \
					 imageio=2.9.0 \
					 matplotlib=3.1.3

# install girder_client with pip
RUN pip install girder_client

# set-up jupyter notebook start ip
RUN mkdir -p /home/mainuser/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/mainuser/.jupyter/jupyter_notebook_config.py

# as root open up permissions for /mnt
USER root
RUN chmod 777 -R /mnt

# install some helpful system programs
RUN apt-get update
RUN apt-get install -y vim unzip curl tree screen

# switch back to main user
USER mainuser

# swith working dir to /mnt
WORKDIR /mnt