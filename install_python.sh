source ./firedrake_env.sh

mkdir $BASEDIR/src

echo "*************************************************************************"
echo " python3"
echo "*************************************************************************"

cd $BASEDIR/src
mkdir python3
cd python3
PYVERSION=3.5.3
wget https://www.python.org/ftp/python/$PYVERSION/Python-$PYVERSION.tar.xz
tar xfJ Python-$PYVERSION.tar.xz
cd Python-$PYVERSION/
# NOTE config flags in Ubuntu python3/zesty,now 3.5.3-1 amd64
# '--enable-shared' '--prefix=/usr' '--enable-ipv6' '--enable-loadable-sqlite-extensions' '--with-dbmliborder=bdb:gdbm' '--with-computed-gotos' '--without-ensurepip' '--with-system-expat' '--with-system-libmpdec' '--with-system-ffi' '--with-fpectl' 'CC=x86_64-linux-gnu-gcc' 'CFLAGS=-g -fdebug-prefix-map=/build/python3.5-7CCmgg/python3.5-3.5.3=. -fstack-protector-strong -Wformat -Werror=format-security ' 'LDFLAGS=-Wl,-Bsymbolic-functions -Wl,-z,relro' 'CPPFLAGS=-Wdate-time -D_FORTIFY_SOURCE=2'
./configure --with-gcc=$HOME/local/gcc-6.3.0/bin/gcc --prefix=$BASEDIR --enable-shared --enable-ipv6 --enable-loadable-sqlite-extensions --with-dbmliborder=bdb:gdbm --with-computed-gotos --with-system-expat --with-system-libmpdec --with-system-ffi --with-fpectl CFLAGS="-g -fstack-protector-strong -Wformat -Werror=format-security"  LDFLAGS="-Wl,-Bsymbolic-functions -Wl,-z,relro" CPPFLAGS="-Wdate-time -D_FORTIFY_SOURCE=2"
make -j12
make install

# NOTE
# The necessary bits to build these optional modules were not found:
# _lzma                 _sqlite3              _tkinter
# To find the necessary bits, look in setup.py in detect_modules() for the module's name.
#
# Failed to build these modules:
# _decimal

echo "*************************************************************************"
echo " mpi4py"
echo "*************************************************************************"

cd $BASEDIR/src
mkdir mpi4py
cd mpi4py
wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-2.0.0.tar.gz
mv mpi4py-* mpi4py-2.0.0.tar.gz
tar xvfz mpi4py-2.0.0.tar.gz
cd mpi4py-2.0.0/
python3 setup.py build
python3 setup.py install

echo "*************************************************************************"
echo " test mpi4py"
echo "*************************************************************************"
# test mpi4py: should print a line for each 5 different processes
mpiexec -n 5 python3 demo/helloworld.py

echo "*************************************************************************"
echo " ipython Cython"
echo "*************************************************************************"
$BASEDIR/bin/pip3 install --no-binary :all: ipython Cython

echo "*************************************************************************"
echo " psutil, virtualenv etc python tools"
echo "*************************************************************************"
$BASEDIR/bin/pip3 install pytest pytest-xdist pytest-benchmark
$BASEDIR/bin/pip3 install mercurial
