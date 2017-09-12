# Install firedrake and thetis on OHSU exacloud system

## Installation steps

1. Create installation directory, e.g. `$HOME/sources/firedrake`
2. Upload the content of this repository to that directory
3. Execute `./install_full.sh`

*NOTE:* The installation will take more than an hour so it is advisable to run it headless with `nohup` or `screen`.

*NOTE:* The directory where `./install_full.sh` is called will be the root directory of your firedrake installation, stored in `BASEDIR` environment variable.

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
python3 -c "import thetis; print thetis.__path__"
```


## Setting up correct environment

Once installation has finished add the following lines to your `~/.bashrc` to activate firedrake automatically on login:

```bash
source REPLACE_THIS_BY_INSTALLATION_DIR/firedrake_env.sh
source $BASEDIR/firedrake/bin/activate
```

## Running jobs

Exaclould uses Slurm job management system. Below is an example of a job submission script.

```bash
#!/bin/bash
#SBATCH -J lock           # Job name
#SBATCH -o lock.o%j       # Name of stdout output file
#SBATCH -p exacloud       # Queue name
#SBATCH -N 1              # Total # of nodes (now required)
#SBATCH -n 6              # Total # of mpi tasks
#SBATCH -t 00:10:00       # Run time (hh:mm:ss)
##SBATCH --mail-user=youremail@here.com
##SBATCH --mail-type=all  # Send email at begin and end of job
export OPENBLAS_NUM_THREADS=1
mpirun --mca btl sm,openib,self  python3 lockExchange.py -r medium -re 2.5```
```

## Updating Thetis

If you need to pull newer version of Thetis, or use another branch you can do so in the `git` repository under `$BASEDIR/src/thetis`. Thetis is installed in development mode, so there's no need to install anything; changes will be effective immediately.

## Updatine Firedrake

If the firedrake environment is active, you can update firedrake by calling `firedrake-update`. In cases wher PETSc has been updated, this update may take up to an hour. Note that this will also update thetis repository. If you have checked out any feature branches in thetis or other firedrake components, it's advisable to first checkout the master branch before updating.

## Installing missing python modules

Thetis may depend on some python packages that are not installed by default (only master branch dependencies are automatically satisfied by the install script). In the firedrake environment you can install missing packages with `pip3`:

```bash
pip3 install netCDF4 uptide pyproj
```

## Notes

Check infiniband hardware:

```
$lspci | grep Mellanox
02:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
```

```
$lspci -vv -s 02:00.0
02:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
        Subsystem: Mellanox Technologies Device 0022
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fac00000 (64-bit, non-prefetchable) [size=1M]
        Region 2: Memory at f8800000 (64-bit, prefetchable) [size=8M]
        Capabilities: <access denied>
        Kernel driver in use: mlx4_core
        Kernel modules: mlx4_core
```

```
$ibv_devinfo
hca_id: mlx4_0
        transport:                      InfiniBand (0)
        fw_ver:                         2.9.1000
        node_guid:                      0002:c903:0059:ba5c
        sys_image_guid:                 0002:c903:0059:ba5f
        vendor_id:                      0x02c9
        vendor_part_id:                 26428
        hw_ver:                         0xB0
        board_id:                       MT_0D90110009
        phys_port_cnt:                  1
                port:   1
                        state:                  PORT_ACTIVE (4)
                        max_mtu:                4096 (5)
                        active_mtu:             4096 (5)
                        sm_lid:                 7
                        port_lid:               7
                        port_lmc:               0x00
                        link_layer:             InfiniBand
```

```
$ibstat
CA 'mlx4_0'
        CA type: MT26428
        Number of ports: 1
        Firmware version: 2.9.1000
        Hardware version: b0
        Node GUID: 0x0002c9030059ba5c
        System image GUID: 0x0002c9030059ba5f
        Port 1:
                State: Active
                Physical state: LinkUp
                Rate: 40
                Base lid: 7
                LMC: 0
                SM lid: 7
                Capability mask: 0x0251086a
                Port GUID: 0x0002c9030059ba5d
                Link layer: InfiniBand
```

See also:
https://www.mellanox.com/related-docs/user_manuals/ConnectX-2_EN_user_manual.pdf
