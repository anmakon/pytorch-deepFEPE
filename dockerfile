FROM ubuntu:18.04
MAINTAINER anna.konrad.2020@mumail.ie

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

RUN apt-get update --fix-missing && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:deadsnakes/ppa && \
        apt-get update -y  && \
        apt-get install -y build-essential python3.6 python3.6-dev python3-pip && \
        apt-get install -y git  && \
        # update pip
        python3.6 -m pip install pip --upgrade && \
        python3.6 -m pip install wheel

# Install requirements
RUN apt-get install -y git vim libsm6 libxrender1
RUN pip3 install torch==1.3.1 torchvision==0.4.2

RUN export GIT_LFS_SKIP_SMUDGE=1
RUN git clone --recursive https://github.com/eric-yyjau/pytorch-deepFEPE.git

RUN cd pytorch-deepFEPE && \
	pip3 install -r requirements.txt && \
	pip3 install -r requirements_torch.txt

RUN git clone https://github.com/eric-yyjau/pytorch-superpoint.git --branch module_20200707

RUN locale && \
	cd pytorch-superpoint && \
	pip3 install --upgrade setuptools wheel && \
	python3.6 setup.py bdist_wheel && \
	pip3 install -e .
