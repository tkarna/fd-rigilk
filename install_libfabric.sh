# --------------------------------------------
# builds newest libfabric
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

mkdir $HOME/sources/libfabric/
cd $HOME/sources/libfabric/

wget https://github.com/ofiwg/libfabric/releases/download/v1.5.0/libfabric-1.5.0.tar.gz
tar xfv libfabric-1.5.0.tar.gz
cd libfabric-1.5.0/
./configure --prefix=/home/karnat/local/libfabric-1.5.0
make -j12
make install
