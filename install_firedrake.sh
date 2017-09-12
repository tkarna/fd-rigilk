source ./firedrake_env.sh

cd $BASEDIR
curl -O https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install
export PETSC_CONFIGURE_OPTIONS="--download-fblaslapack"
python3 firedrake-install -v --disable-ssh --no-package-manager --install thetis
