# ------------------------------------------------------------------------------
# set environment variables for firedrake install
# ------------------------------------------------------------------------------
export BASEDIR=REPLACE_THIS_BY_INSTALLATION_DIR

# ------------------------------------------------------------------------------
# set paths for builing
# ------------------------------------------------------------------------------
export PATH=$BASEDIR/bin/:$PATH
export CPATH=$BASEDIR/include/:$CPATH
export LD_LIBRARY_PATH=$BASEDIR/lib/:$BASEDIR/lib64/:$LD_LIBRARY_PATH

# ------------------------------------------------------------------------------
# set temp dirs
# ------------------------------------------------------------------------------
TEMP=$BASEDIR/tmp/
mkdir -p $TEMP
export TEMP
export TMPDIR=$TEMP
export TMP=$TEMP
export FIREDRAKE_TSFC_KERNEL_CACHE_DIR=$TEMP/firedrake-cache
export PYOP2_CACHE_DIR=$TEMP/pyop2-cache
