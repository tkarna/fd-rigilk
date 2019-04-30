# ------------------------------------------------------------------------------
# set environment variables for firedrake install
# ------------------------------------------------------------------------------

source /home/karnat/bin/activate_gcc6.4
source /home/karnat/bin/activate_openmpi-2.1.3.sh
source /home/karnat/bin/activate_cmake-3.11.4

export BASEDIR=/home/karnat/sources/firedrake

export PATH=$BASEDIR/bin/:$PATH
export LD_LIBRARY_PATH=$BASEDIR/lib/:$BASEDIR/lib64/:$LD_LIBRARY_PATH

source $BASEDIR/firedrake/bin/activate

export OMPI_MCA_mpi_warn_on_fork=0

# custom prompt
RR="thetis"
export PS1="\[\e[32;1m\][$RR] \u@\H:\w\[\e[00m\]\n\[\e[36m\]\342\226\210\342\226\210 \t \$\[\e[00m\]"

# env for PyOP2 local compilation
export PYOP2_NODE_LOCAL_COMPILATION=1
# export PYOP2_CACHE_DIR=/tmp/karnat/pyop2
# export FIREDRAKE_TSFC_KERNEL_CACHE_DIR=/tmp/karnat/tsfc-cache

export PYOP2_CACHE_DIR=/home/karnat/temp/pyop2-cache
export FIREDRAKE_TSFC_KERNEL_CACHE_DIR=/home/karnat/temp/tsfc-cache
