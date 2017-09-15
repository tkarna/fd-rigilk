# Install firedrake and thetis on CMOP rigilk system

## Installation steps

1. Create installation directory, e.g. `$HOME/sources/firedrake`
2. Upload the content of this repository to that directory
3. Execute `./install_full.sh`

*NOTE:* The installation will take more than an hour so it is advisable to run it headless with `nohup` or `screen`.

*NOTE:* The directory where `./install_full.sh` is called will be the root directory of your firedrake installation, stored in `BASEDIR` environment variable.

## Prerequisites

For correct operation Firedrake/Thetis require newer libfabric version that what's installed in the system.
Installing new libfabric implies that openmpi must be recompled as well.
See `install_libfabric.sh` and `install_openmpi.sh` for instructions.

NOTE: libfabric and openmpi installation is *not* part of the high-level `install_full.sh` script and must be done manually.


## Under the hood

`install_full.sh` will

1. Replace currect directory as the `BASEDIR` variable in the installation environment
1. Compile `python` and `mpi4py` under `$BASEDIR/src` and install them under `$BASEDIR`
1. Install firedrake with its installation script

Using that python installation, `firedrake` will be build under `$BASEDIR/firedrake` using its installation script.

## Verifying installation

If installation is successful, the log says

```bash
$tail -n 20 $BASEDIR/firedrake-install.log
2017-06-30 11:39:19,117 INFO

Successfully installed Firedrake.

2017-06-30 11:39:19,117 INFO
Firedrake has been installed in a python virtualenv. You activate it with:

2017-06-30 11:39:19,117 INFO     . /home/users/karna/sources/firedrake/firedrake/bin/activate

2017-06-30 11:39:19,117 INFO   The virtualenv can be deactivated by running:

2017-06-30 11:39:19,117 INFO     deactivate


2017-06-30 11:39:19,117 INFO   To upgrade Firedrake activate the virtualenv and run firedrake-update

2017-06-30 11:39:19,177 INFO   Configuration saved to configuration.json
2017-06-30 11:39:19,178 INFO

Install log saved in firedrake-install.log
```

After activating the firedrake environment, `source $BASEDIR/firedrake/bin/activate`, you should also be able to do

```bash
python -c "import thetis; print thetis.__path__"
```


## Setting up correct environment

Once installation has finished add the following lines to your `~/.bashrc` to activate firedrake automatically on login:

```bash
source REPLACE_THIS_BY_INSTALLATION_DIR/firedrake_env.sh
source $BASEDIR/firedrake/bin/activate
```

## Running jobs

rigilk uses Slurm job management system. Below is an example of a job submission script.

```bash
#!/bin/bash
#SBATCH -J lock           # job name
#SBATCH -o log_lock.o%j   # output and error file name (%j expands to jobID)
#SBATCH -n 4              # total number of mpi tasks requested
#SBATCH -p rigilk     # queue (partition) -- normal, development, etc.
##SBATCH --mail-user=youremail@somewhere.com
##SBATCH --mail-type=begin  # email me when the job starts
##SBATCH --mail-type=end    # email me when the job finishes
mpirun  python lockExchange.py -r medium -re 2.5
```

## Updatine Firedrake

If the firedrake environment is active, you can update firedrake by calling `firedrake-update`. In cases wher PETSc has been updated, this update may take up to an hour. Note that this will also update thetis repository. If you have checked out any feature branches in thetis or other firedrake components, it's advisable to first checkout the master branch before updating.

## Updating Thetis

Thetis `git` repository is located under `BASEDIR/firedrake/src/thetis`. You can pull updates or change branches therein. Thetis is installed in development mode, so there's no need to install anything; changes will be effective immediately.

Note: Using `firedrake-update` may fail if Thetis repository is not on `master` branch. To circumvent, reset the branch manually before updating.

## Installing missing python modules

Thetis may depend on some python packages that are not installed by default (only master branch dependencies are automatically satisfied by the install script). In the firedrake environment you can install missing packages with `pip`:

```bash
pip install netCDF4 uptide pyproj
```

or install requirements directly from the repo:

```bash
pip install -r $BASEDIR/firedrake/src/thetis/requirements.txt
```
