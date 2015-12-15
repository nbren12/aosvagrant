#/usr/bin/env bash
cd /vagrant

# apt-get update

# Install Necessary libraries
apt-get install -y gcc
apt-get install -y gfortran
apt-get install -y libnetcdf-dev
apt-get install -y netcdf-bin
apt-get install -y libmpich-dev
apt-get install -y libjasper-dev
apt-get install -y libpng-dev
apt-get install -y  zlib1g-dev
apt-get install -y  m4
apt-get install -y  csh

# Download and extract WRF
if ! [ -e WRFV3 ]
then
    wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.7.TAR.gz > /dev/null 2>/dev/null
    tar xzf WRFV3.7.TAR.gz
fi

# Setup environemental variables
echo "export NETCDF=/usr" >> /home/vagrant/.profile

# Install miniconda
if ! [ -d /opt/anaconda ] 
then
    miniconda=Miniconda3-latest-Linux-x86_64.sh

    if ! [  -f $miniconda ] 
    then
        wget --quiet http://repo.continuum.io/miniconda/$miniconda
    fi

    chmod +x $miniconda
    ./$miniconda -b -p /opt/anaconda
    cat >> /home/vagrant/.profile << EOF
# add for anaconda install
PATH=/opt/anaconda/bin:\$PATH
EOF
fi


PATH=/opt/anaconda/bin:$PATH

# Install important python packages
conda install -c ioos cartopy
conda install ipython jupyter
conda install xray

# Setup X Server
sudo apt-get install -y xorg
sudo apt-get install -y openbox
