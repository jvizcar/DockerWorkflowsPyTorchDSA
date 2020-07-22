# from an official PyTorch image
FROM jvizcar/sage_workflows_pytorch:1.0.0

# switch to root user
USER root

# install additional Python libraries with conda
RUN conda install -y seaborn=0.10.1 scikit-learn=0.23.1

# install histomicstk with all additional dependencies
RUN pip install pip install histomicstk --find-links https://girder.github.io/large_image_wheels

# with back to mainuser user
USER mainuser