#!/bin/bash -ex

WORKING_DIR=./.myenv
ENV_NAME=gluonts-multimodel
mkdir -p "${WORKING_DIR}"

# Install Miniconda to get a separate python and pip
wget https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86_64.sh -O "$WORKING_DIR/miniconda.sh"

# Install Miniconda into the working directory
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda"

# Install pinned versions of any dependencies
source "$WORKING_DIR/miniconda/bin/activate"

conda create -y -n $ENV_NAME anaconda python=3.6

conda activate $ENV_NAME

## Install required library
pip install -r requirements.txt

## install python r interface
conda install -c r rpy2==2.9.4 --yes

## install forecast R packages
R -e 'install.packages(c("forecast", "nnfor"), repos="https://cloud.r-project.org")'

## install Prophet python packages
conda install -c plotly plotly==3.10.0 --yes
conda install -c conda-forge fbprophet=0.6=py36he1b5a44_0 --yes
conda install -c anaconda ujson=1.35=py36h14c3975_0 --yes

## install gluonts
pip install gluonts==0.5.0

# Cleanup
conda deactivate
source "${WORKING_DIR}/miniconda/bin/deactivate"
rm -rf "${WORKING_DIR}/miniconda.sh"
