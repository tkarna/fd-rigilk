# --------------------------------------------
# builds gcc using config similar to Ubuntu
# --------------------------------------------

# NOTE this should be run manually if desired - not executed as a part of install_full.sh

mkdir $HOME/sources/gcc/6.3.0/
cd $HOME/sources/gcc/6.3.0/

wget https://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.gz
tar xfv gcc-6.3.0.tar.gz

cd gcc-6.3.0
./contrib/download_prerequisites

cd ..
mkdir objdir
cd objdir

$PWD/../gcc-6.3.0/configure --enable-languages=c,c++,fortran --prefix=$HOME/local/gcc-6.3.0/ --enable-shared --enable-linker-build-id --without-included-gettext --enable-threads=posix --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-libmpx --enable-plugin --enable-default-pie --with-system-zlib --disable-browser-plugin --enable-gtk-cairo --with-arch-directory=amd6 --with-target-system-zlib --disable-werror --with-abi=m64 --disable-multilib --with-tune=generic --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
make -j 12
make install

# NOTE to activate, add this to ~/.bashrc
# GCCDIR=$HOME/local/gcc-6.3.0/
# export PATH=$GCCDIR/bin/:$PATH
# export CPATH=$GCCDIR/include/:$CPATH
# export LD_LIBRARY_PATH=$GCCDIR/lib/:$GCCDIR/lib64/:$LD_LIBRARY_PATH

