# --------------------------------------------
# builds newest libfabric
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

mkdir -p $HOME/sources/libfabric/
cd $HOME/sources/libfabric/

wget https://github.com/ofiwg/libfabric/releases/download/v1.6.1/libfabric-1.6.1.tar.gz
tar xfv libfabric-1.6.1.tar.gz
cd libfabric-1.6.1/
./configure --prefix=$HOME/local/libfabric-1.6.1
make -j 18
make install

# NOTE to activate, add this to ~/.bashrc
# FABRICDIR=$HOME/local/libfabric-1.6.1/
# export PATH=$FABRICDIR/bin/:$PATH
# export CPATH=$FABRICDIR/include/:$CPATH
# export LD_LIBRARY_PATH=$FABRICDIR/lib/:$LD_LIBRARY_PATH
