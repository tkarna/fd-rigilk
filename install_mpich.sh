# --------------------------------------------
# builds newest mpich
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

# NOTE only version >= 3.3a1 supports libfabric
# NOTE petsc install hangs - mpich appears to be unusable

mkdir -p $HOME/sources/mpich/
cd $HOME/sources/mpich/

wget http://www.mpich.org/static/downloads/3.3a2/mpich-3.3a2.tar.gz
tar xf mpich-3.3a2.tar.gz
cd mpich-3.3a2

./configure --prefix=/home/karnat/local/mpich-3.3a2 --with-device=ch4:ofi --with-libfabric=/home/karnat/local/libfabric-1.5.0/
make -j 12
make install
