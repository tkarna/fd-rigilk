# replaces root path by current dir in installation scripts

BASEDIR=`pwd`
sed -i "s|REPLACE_THIS_BY_INSTALLATION_DIR|$BASEDIR|g" firedrake_env.sh
sed -i "s|REPLACE_THIS_BY_INSTALLATION_DIR|$BASEDIR|g" readme.md

