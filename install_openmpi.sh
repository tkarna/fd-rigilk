# --------------------------------------------
# builds newest openmpi
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

mkdir -p $HOME/sources/openmpi/
cd $HOME/sources/openmpi/

wget https://download.open-mpi.org/release/open-mpi/v2.1/openmpi-2.1.3.tar.gz
tar xfv openmpi-2.1.3.tar.gz
cd openmpi-2.1.3/

./configure --prefix=$HOME/local/openmpi-2.1.3 --with-libfabric=$HOME/local/libfabric-1.6.1/
make -j 12
make install

# NOTE to activate, add this to ~/.bashrc
# OPENMPIDIR=$HOME/local/openmpi-2.1.3/
# export PATH=$OPENMPIDIR/bin/:$PATH
# export CPATH=$OPENMPIDIR/include/:$CPATH
# export LD_LIBRARY_PATH=$OPENMPIDIR/lib/:$LD_LIBRARY_PATH
