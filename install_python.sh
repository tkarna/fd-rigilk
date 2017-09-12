source ./firedrake_env.sh

mkdir $BASEDIR/src

echo "*************************************************************************"
echo " python3"
echo "*************************************************************************"

cd $BASEDIR/src
mkdir python3
cd python3
PYVERSION=3.6.2
wget https://www.python.org/ftp/python/$PYVERSION/Python-$PYVERSION.tar.xz
tar xfJ Python-$PYVERSION.tar.xz
cd Python-$PYVERSION/

# NOTE config flags in Ubuntu python3/zesty,now 3.5.3-1 amd64
# '--enable-shared' '--prefix=/usr' '--enable-ipv6' '--enable-loadable-sqlite-extensions' '--with-dbmliborder=bdb:gdbm' '--with-computed-gotos' '--without-ensurepip' '--with-system-expat' '--with-system-libmpdec' '--with-system-ffi' '--with-fpectl' 'CC=x86_64-linux-gnu-gcc' 'CFLAGS=-g -fdebug-prefix-map=/build/python3.5-7CCmgg/python3.5-3.5.3=. -fstack-protector-strong -Wformat -Werror=format-security ' 'LDFLAGS=-Wl,-Bsymbolic-functions -Wl,-z,relro' 'CPPFLAGS=-Wdate-time -D_FORTIFY_SOURCE=2'

# NOTE build flags for system's python2.7
# '--build=x86_64-redhat-linux-gnu' '--host=x86_64-redhat-linux-gnu' '--program-prefix=' '--disable-dependency-tracking' '--prefix=/usr' '--exec-prefix=/usr' '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc' '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib64' '--libexecdir=/usr/libexec' '--localstatedir=/var' '--sharedstatedir=/var/lib' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--enable-ipv6' '--enable-shared' '--enable-unicode=ucs4' '--with-dbmliborder=gdbm:ndbm:bdb' '--with-system-expat' '--with-system-ffi' '--with-dtrace' '--with-tapset-install-dir=/usr/share/systemtap/tapset' '--with-valgrind' 'build_alias=x86_64-redhat-linux-gnu' 'host_alias=x86_64-redhat-linux-gnu' 'CC=gcc' 'CFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches   -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv  ' 'LDFLAGS=-Wl,-z,relro   ' 'CPPFLAGS= '

# NOTE adapted from system's python (works!)
./configure --prefix=$BASEDIR --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --enable-ipv6 --enable-shared --with-dbmliborder=gdbm:ndbm:bdb --with-system-expat --with-system-ffi --with-dtrace --with-valgrind build_alias=x86_64-redhat-linux-gnu host_alias=x86_64-redhat-linux-gnu CC=gcc "CFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv" "LDFLAGS=-Wl,-z,relro"

make -j12
make install

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
