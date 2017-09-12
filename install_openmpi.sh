# --------------------------------------------
# builds newest openmpi
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

mkdir -p $HOME/sources/openmpi/
cd $HOME/sources/openmpi/

wget https://www.open-mpi.org/software/ompi/v2.1/downloads/openmpi-2.1.1.tar.gz
tar xvf openmpi-2.1.1.tar.gz
cd openmpi-2.1.1/

./configure --prefix=$HOME/local/openmpi-2.1.1 --with-libfabric=$HOME/local/libfabric-1.5.0/
make -j 12
make install

# NOTE to activate, add this to ~/.bashrc
# OPENMPIDIR=$HOME/local/openmpi-2.1.1/
# export PATH=$OPENMPIDIR/bin/:$PATH
# export CPATH=$OPENMPIDIR/include/:$CPATH
# export LD_LIBRARY_PATH=$OPENMPIDIR/lib/:$LD_LIBRARY_PATH
