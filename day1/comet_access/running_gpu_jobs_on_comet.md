# Introduction to Running Jobs on Comet 

Presented by Mary Thomas (SDSC,  <mthomas@sdsc.edu> )
<hr>
In this tutorial, you will learn how to compile and run jobs on Comet, where to run them, and how to run batch jobs.
The commands below can be cut & pasted into the comet terminal window.

Requirements:
* You must have a comet account in order to access the system. 
    * To obtain a trial account:  http://www.sdsc.edu/support/user_guides/comet.html#trial_accounts
* You must be familiar with running basic Unix commands: see the following tutorials at:
    * https://github.com/marypthomas/sdsc-training/tree/master/introduction-to-running-jobs-on-comet/preparation
* Note: The `hostname` for Comet is `comet.sdsc.edu`

<em>If you have any difficulties completing these tasks, please contact SDSC Consulting group at <consult@sdsc.edu>.</em>
<hr>

<a name="top">Contents:
* [Comet Overview](#overview)
    * [Comet Architecture](#network-arch)
    * [Comet File Systems](#file-systems)

* [Getting Started - Comet System Environment](#sys-env)
    * [Comet Accounts](#comet-accounts)
    * [Logging Onto Comet](#comet-logon)
    * [Obtaining Example Code](#example-code)
    
* [Modules: Managing User Environments](#modules)
    * [Common module commands](#module-commands)
    * [Load and Check Modules and Environment](#load-and-check-module-env)
    * [Module Error: command not found](#module-error)

* [Compiling & Linking](#compilers)
    * [Supported Compiler Types](#compilers-supported)
    * [Using the Intel Compilers](#compilers-intel)
    * [Using the PGI Compilers](#compilers-pgi)
    * [Using the GNU Compilers](#compilers-gnu)
    
* [Running Jobs on Comet](#running-jobs)
    * [Command Line Jobs](#running-jobs-cmdline)
    * [Batch Jobs using SLURM](#running-jobs-slurm)
    * [Slurm Commands](#running-jobs-slurm-commands)

* [Compiling and Running GPU/CUDA Jobs](#comp-and-run-cuda-jobs)
    * [GPU Hello World (GPU) ](#hello-world-gpu)
        * [GPU Hello World: Compiling](#hello-world-gpu-compile)
        * [GPU Hello World: Batch Script Submission](#hello-world-gpu-batch-submit)
        * [GPU Hello World: Batch Job Output](#hello-world-gpu-batch-output)
    * [GPU Enumeration ](#enum-gpu)
        * [GPU Enumeration: Compiling](#enum-gpu-compile)
        * [GPU Enumeration: Batch Script Submission](#enum-gpu-batch-submit)
        * [GPU Enumeration: Batch Job Output](#enum-gpu-batch-output )
    * [CUDA Mat-Mult](#mat-mul-gpu)
        * [Matrix Mult. (GPU): Compiling](#mat-mul-gpu-compile)
        * [Matrix Mult. (GPU): Batch Script Submission](#mat-mul-gpu-batch-submit)
        * [Matrix Mult. (GPU): Batch Job Output](#mat-mul-gpu-batch-output )

[Back to Top](#top)
<hr>

## <a name="overview"></a>Comet Overview:

### HPC for the "long tail of science:"
* Designed and operated on the principle that the majority of computational research is performed at modest scale: large number jobs that run for less than 48 hours, but can be computationally intensvie and generate large amounts of data.
* An NSF-funded system available through the eXtreme Science and Engineering Discovery Environment (XSEDE) program.
* Also supports science gateways.

<img src="images/comet-rack.png" alt="Comet Rack View" width="500px" />
* ~67 TF supercomputer in a rack
* 27 single-rack supercomputers


<img src="images/comet-characteristics.png" alt="Comet System Characteristics" width="500px" />

[Back to Top](#top)
<hr>

<a name="network-arch"></a><img src="images/comet-network-arch.png" alt="Comet Network Architecture" width="500px" />

[Back to Top](#top)
<hr>

<a name="file-systems"></a><img src="images/comet-file-systems.png" alt="Comet File Systems" width="500px" />
* Lustre filesystems – Good for scalable large block I/O
    * Accessible from all compute and GPU nodes.
    * /oasis/scratch/comet - 2.5PB, peak performance: 100GB/s. Good location for storing large scale scratch data during a job.
    * /oasis/projects/nsf - 2.5PB, peak performance: 100 GB/s. Long term storage.
    * *Not good for lots of small files or small block I/O.*

* SSD filesystems
    * /scratch local to each native compute node – 210GB on regular compute nodes, 285GB on GPU, large memory nodes, 1.4TB on selected compute nodes.
    * SSD location is good for writing small files and temporary scratch files. Purged at the end of a job.

* Home directories (/home/$USER)
    * Source trees, binaries, and small input files.
    * *Not good for large scale I/O.*


[Back to Top](#top)
<hr>

## <a name="sys-env"></a>Getting Started on Comet

### <a name="comet-accounts"></a>Comet Accounts
You must have a comet account in order to access the system. 
* Obtain a trial account here:  http://www.sdsc.edu/support/user_guides/comet.html#trial_accounts
* You can use your XSEDE account.

### <a name="comet-logon"></a>Logging Onto Comet
Details about how to access Comet under different circumstances are described in the Comet User Guide:
 http://www.sdsc.edu/support/user_guides/comet.html#access

 </a><img src="images/comet-logon.png" alt="Comet Logon" width="500px" />

```
[username@gidget:~]
[username@gidget:~] ssh -Y comet.sdsc.edu
Warning: No xauth data; using fake authentication data for X11 forwarding.
Last login: Tue Jul 17 12:08:53 2018 from wireless-169-228-90-10.ucsd.edu
Rocks 6.2 (SideWinder)
Profile built 16:45 08-Feb-2016

Kickstarted 17:27 08-Feb-2016

                      WELCOME TO
      __________________  __  _______________
        -----/ ____/ __ \/  |/  / ____/_  __/
          --/ /   / / / / /|_/ / __/   / /
           / /___/ /_/ / /  / / /___  / /
           \____/\____/_/  /_/_____/ /_/

*******************************************************************************

[1] Example Scripts: /share/apps/examples

[2] Filesystems:

     (a) Lustre scratch filesystem : /oasis/scratch/comet/$USER/temp_project
         (Preferred: Scalable large block I/O)

     (b) Compute/GPU node local SSD storage: /scratch/$USER/$SLURM_JOBID
         (Meta-data intensive jobs, high IOPs)

     (c) Lustre projects filesystem: /oasis/projects/nsf

     (d) /home/$USER : Only for source files, libraries, binaries.
         *Do not* use for I/O intensive jobs.

[3] Comet User Guide: http://www.sdsc.edu/support/user_guides/comet.html
******************************************************************************
[username@comet-ln3 ~]$
```

[Back to Top](#top)
<hr>

### <a name="example-code"></a>Obtaining Example Code
* Clone the NVIDIA DLI repo:
```
[username@comet-ln3:~] git clone git@github.com:sdsc-hpc-training/nvidia-dli-2019.git
Cloning into 'nvidia-dli-2019'...
Warning: Permanently added the RSA host key for IP address '140.82.113.4' to the list of known hosts.
remote: Enumerating objects: 143, done.
remote: Counting objects: 100% (143/143), done.
remote: Compressing objects: 100% (129/129), done.
remote: Total 143 (delta 62), reused 45 (delta 8), pack-reused 0
Receiving objects: 100% (143/143), 4.43 MiB | 5.84 MiB/s, done.
Resolving deltas: 100% (62/62), done.
[username@comet-ln3:~] ll nvidia-dli-2019/
total 141
drwxr-xr-x  5 username use300    7 Aug 19 22:31 .
drwxr-x--- 43 username use300   95 Aug 19 22:31 ..
drwxr-xr-x  4 username use300    5 Aug 19 22:31 day1
drwxr-xr-x  2 username use300    3 Aug 19 22:31 day2
drwxr-xr-x  8 username use300   13 Aug 19 22:31 .git
-rw-r--r--  1 username use300   10 Aug 19 22:31 .gitignore
-rw-r--r--  1 username use300 1198 Aug 19 22:31 README.md
```
Note: You can obtain more example codes by copying the files in /share/apps/gpu

[Back to Top](#top)
<hr>

## <a name="modules"></a>Modules: Customizing Your User Environment
The Environment Modules package provides for dynamic modification of your shell environment. Module commands set, change, or delete environment variables, typically in support of a particular application. They also let the user choose between different versions of the same software or different combinations of related codes. See:
http://www.sdsc.edu/support/user_guides/comet.html#modules

### <a name="module-commands"></a>Common module commands

 
   Here are some common module commands and their descriptions:

| Command | Description | 
|---|---|
| module list | List the modules that are currently loaded| 
| module avail | List the modules that are available| 
| module display <module_name> | Show the environment variables used by <module name> and how they are affected| 
| module show  <module_name>  | Same as display| 
| module unload <module name> | Remove <module name> from the environment| 
| module load <module name> | Load <module name> into the environment| 
| module swap <module one> <module two> | Replace <module one> with <module two> in the environment| 
   
<b> A few module commands:</b>

* Default environment: `list`, `li`
```
$ module li
Currently Loaded Module files:
  1) intel/2013_sp1.2.144   2) mvapich2_ib/2.1        3) gnutools/2.69
```
* List available modules:  `available`, `avail`, `av`

```
$ module av
------------------------- /opt/modulefiles/mpi/.intel --------------------------
intelmpi/2016.3.210(default) mvapich2_ib/2.1(default)
mvapich2_gdr/2.1(default)    openmpi_ib/1.8.4(default)
mvapich2_gdr/2.2
--------------------- /opt/modulefiles/applications/.intel ---------------------
atlas/3.10.2(default)     lapack/3.6.0(default)     scalapack/2.0.2(default)
boost/1.55.0(default)     mxml/2.9(default)         slepc/3.6.2(default)
. . .
```

[Back to Top](#top)
<hr>

### <a name="load-and-check-module-env"></a>Load and Check Modules and Environment

* Load modules:
```
$ module load fftw/3.3.4 
$ module li
Currently Loaded Modulefiles:
  1) intel/2013_sp1.2.144   3) gnutools/2.69
  2) mvapich2_ib/2.1        4) fftw/3.3.4
```

Show loaded module details:
```
$ module show fftw/3.3.4
-------------------------------------------------------------------
/opt/modulefiles/applications/.intel/fftw/3.3.4:
module-whatis fftw 
module-whatis Version: 3.3.4 
module-whatis Description: fftw 
module-whatis Compiler: intel 
module-whatis MPI Flavors: mvapich2_ib openmpi_ib 
setenv FFTWHOME /opt/fftw/3.3.4/intel/mvapich2_ib 
prepend-path PATH /opt/fftw/3.3.4/intel/mvapich2_ib/bin 
prepend-path LD_LIBRARY_PATH /opt/fftw/3.3.4/intel/mvapich2_ib/lib 
prepend-path LIBPATH /opt/fftw/3.3.4/intel/mvapich2_ib/lib 
-------------------------------------------------------------------
```

Once you have loaded the modules, you can check the system variables that are available for you to use.
* To see all variable, run the <b>`env`</b> command. Typically, you will see more than 60 lines containing information such as your login name, shell, your home directory:
```
[username@comet-ln3 IBRUN]$ env
HOSTNAME=comet-ln3.sdsc.edu
INTEL_LICENSE_FILE=/opt/intel/composer_xe_2013_sp1.2.144/licenses:/opt/intel/licenses:/root/intel/licenses
TERM=xterm-256color
SHELL=/bin/bash
GDBSERVER_MIC=/opt/intel/composer_xe_2013_sp1.2.144/debugger/gdb/target/mic/bin/gdbserver
LOADEDMODULES=intel/2013_sp1.2.144:mvapich2_ib/2.1:gnutools/2.69
HOME=/home/username
MPIHOME=/opt/mvapich2/intel/ib
SDSCHOME=/opt/sdsc
PYTHONPATH=/opt/sdsc/lib:/opt/sdsc/lib/python2.6/site-packages
LOGNAME=username
SSH_CONNECTION=76.176.117.51 58589 198.202.113.252 22
MODULESHOME=/usr/share/Modules
INCLUDE=/opt/intel/composer_xe_2013_sp1.2.144/mkl/include
INTELHOME=/opt/intel/composer_xe_2013_sp1.2.144
```

To see the value for any of these variables, use the `echo` command:
```
[username@comet-ln3 IBRUN]$ echo $PATH
PATH=/opt/gnu/gcc/bin:/opt/gnu/bin:/opt/mvapich2/intel/ib/bin:/opt/intel/composer_xe_2013_sp1.2.144/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/mpirt/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/debugger/gdb/intel64_mic/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/home/username/bin
```
[Back to Top](#top)
<hr>



[Back to Top](#top)
<hr>
### <a name="module-error"></a>Module Error: command not found 

Sometimes this error is encountered when switching from one shell to another or attempting to run the module command from within a shell script or batch job. The module command may not be inherited between the shells.  To keep this from happening, execute the following command:
```
[comet-ln3:~]source /etc/profile.d/modules.sh
```
OR add this command to your shell script (including Slurm batch scripts)


[Back to Top](#top)
<hr>

## <a name="compilers"></a>Compiling & Linking

Comet provides the Intel, Portland Group (PGI), and GNU compilers along with multiple MPI implementations (MVAPICH2, MPICH2, OpenMPI). Most applications will achieve the best performance on Comet using the Intel compilers and MVAPICH2 and the majority of libraries installed on Comet have been built using this combination. 

Other compilers and versions can be installed by Comet staff on request. For more information, see the user guide:
http://www.sdsc.edu/support/user_guides/comet.html#compiling

### <a name="compilers-supported"></a>Supported Compiler Types

Comet compute nodes support several parallel programming models:
* __MPI__: Default: Intel
   * Default Intel Compiler: intel/2013_sp1.2.144; Versions 2015.2.164 and 2016.3.210 available.
   * Other options: openmpi_ib/1.8.4 (and 1.10.2), Intel MPI, mvapich2_ib/2.1
   * mvapich2_gdr: GPU direct enabled version
* __OpenMP__: All compilers (GNU, Intel, PGI) have OpenMP flags.
* __GPU nodes__: support CUDA, OpenACC.
* __Hybrid modes__ are possible.

For more information on using different compilers, see the comet user guide at http://www.sdsc.edu/support/user_guides/comet.html


## <a name="running-jobs"></a>Running Jobs on Comet

### <a name="running-jobs-cmdline"></a>Command Line Jobs
<em>Do not run on the login nodes - even for simple tests</em>.
These nodes are meant for compilation, file editing, simple data analysis, and other tasks that use minimal compute resources. Even if you could run a simple test on the command line on the login node, full tests should not be run on the login node because the performance will be adversely impacted by all the other tasks and login activities of the other users who are logged onto the same node. For example, at the moment that this note was writeen,  a `gzip` process was consuming 98% of the CPU time:
```
[username@comet-ln3 OPENMP]$ top
...
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                      
19937 XXXXX     20   0  4304  680  300 R 98.2  0.0   0:19.45 gzip
```

### <a name="running-jobs-slurm"></a>Running Jobs using SLURM

* All jobs must be run via the Slurm scheduling infrastructure. There are two types of jobs:
    * Interactive Jobs: Use `srun` command:
        ```
        srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
        ```
    * Batch Jobs: Submit batch scripts from the login nodes. Can set environment variables in the shell or in the batch script, including:
        * Partition (also call qeueing system, details on upcoming slide)
        * Time limit for a job (maximum of 48 hours; longer on request)
        * Number of nodes, tasks per node
        * Memory requirements (if any)
        * Job name, output file location
        * Email info, configuration

[Back to Top](#top)
<hr>

### <a name="slurm-batch-jobs"></a>Batch Jobs using SLURM:
Comet uses the Simple Linux Utility for Resource Management (SLURM) batch environment. For more details, see the section on Running job in the Comet User Guide:
http://www.sdsc.edu/support/user_guides/comet.html#running

### Slurm Partitions

<img src="images/comet-queue-names.png" alt="Comet Queue Names" width="500px" />

Specified using -p option in batch script. For example:
```
#SBATCH -p gpu
```
[Back to Top](#top)
<hr>

### <a name="slurm-commands"></a>Slurm Commands
Here are a few key Slurm commands. For more information, run the `man slurm` or see this page:

* To Submit jobs using the `sbatch` command:

```
$ sbatch Localscratch-slurm.sb 
Submitted batch job 8718049
```
* To check job status using the squeue command:
```
$ squeue -u $USER
             JOBID PARTITION     NAME     USER      ST       TIME  NODES  NODELIST(REASON)
           8718049   compute       localscr mahidhar   PD       0:00       1               (Priority)
```
* Once the job is running, you will see the job status change:
```
$ squeue -u $USER
             JOBID PARTITION     NAME     USER    ST       TIME  NODES  NODELIST(REASON)
           8718064     debug        localscr mahidhar   R         0:02      1           comet-14-01
```
* To cancel a job, use the `scancel` along with the `JOBID`:
    *   $scancel <jobid>


[Back to Top](#top)
<hr>

## <a name="comp-and-run-cuda-jobs"></a>Compiling and Running GPU/CUDA Jobs

Note: Comet provides both NVIDIA K80 and P100 GPU-based resources. These GPU nodes 
are allocated as separate resources. Make sure you have enough allocations and that
you are using the right account.

<b> Comet GPU Hardware: </b> <br>
<a name="gpu-hardware"></a><img src="images/comet-gpu-hardware.png" alt="Comet GPU Hardware" width="500px" />
 <p>
<b>Load the CUDA module:</b>
```
[user@comet-ln2 CUDA]$ module list
[user@comet-ln2 CUDA]$ module purge
[user@comet-ln2 CUDA]$ module load gnutools
[user@comet-ln2 CUDA]$ module load cuda
[user@comet-ln2 CUDA]$ module list
Currently Loaded Modulefiles:
  1) gnutools/2.69   2) cuda/7.0
[user@comet-ln2 CUDA]$which nvcc
/usr/local/cuda-7.0/bin/nvcc
```

[Back to Top](#top)
<hr>


### <a name="hello-world-gpu"></a>GPU/CUDA Example: Hello World
<b>Sections:</b>
* [GPU Hello World: Compiling](#hello-world-gpu-compile)
* [GPU Hello World: Interactive Job](#hello-world-gpu-interactive)
* [GPU Hello World: Batch Script Submission](#hello-world-gpu-batch-submit)
* [GPU Hello World: Batch Job Output](#hello-world-gpu-batch-output)

#### <a name="hello-world-gpu-compile"></a>GPU Hello World: Compiling
Note: You can compile on the login nodes, but to run the job you must be on a GPU node.
Simple hello runs a cuda command to get the device count
on the node that job is assigned to:
```
[comet-ln2:~/cuda/simple_hello] cat simple_hello.cu 
  1 /*
  2 * simple_hello.cu
  3 * Copyright 1993-2010 NVIDIA Corporation. 
  4 *    All right reserved
  5 */
  6 #include <stdio.h>
  7 #include <stdlib.h>
  8 int main( void )
  9 {
 10    int deviceCount;
 11    cudaGetDeviceCount( &deviceCount );
 12    printf("Hello, NVIDIA DLI Workshop! You have %d devices\n", deviceCount );
 13    return 0;
 14 }
[comet-ln2:~/cuda/simple_hello] 
```

Check your environment and use the CUDA <b>`nvcc`</b> command:
```
[comet-ln2:~/cuda/gpu_enum] module purge
[comet-ln2:~/cuda/gpu_enum] which nvcc
/usr/bin/which: no nvcc in (/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/user/bin)
[comet-ln2:~/cuda/gpu_enum] module load cuda
[comet-ln2:~/cuda/gpu_enum] which nvcc
/usr/local/cuda-7.0/bin/nvcc
[comet-ln2:~/cuda/simple_hello] nvcc -o simple_hello simple_hello.cu
[comet-ln2:~/cuda/simple_hello] ll simple_hello 
-rwxr-xr-x 1 user use300 517437 Apr 10 19:35 simple_hello
-rw-r--r-- 1 user use300    304 Apr 10 19:35 simple_hello.cu
[comet-ln2:~/cuda/simple_hello] 

```

### GPU Hello World: Interactive Job<a name="hello-world-gpu-interactive"></a>
GPU nodes can be accessed via either the "gpu" or the "gpu-shared" partitions. To obtain an interactive node, use the `srun` command:
```
srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
```
if you have a reserved queue (as you will have during this workshop, use the reserve queue name):
```
srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 \
     --gres=gpu:k80:1 --reservation=RESERVATION_NAME --pty --wait=0 /bin/bash
```     

Once you have obtained your interactive node, load the CUDA and PGI compiler modules
```
[username@comet-30-04:~] module purge
[username@comet-30-04:~] module load gnutools
[username@comet-30-04:~] module load cuda
[username@comet-30-04:~] module load pgi
[username@comet-30-04:~] module list
Currently Loaded Modulefiles:
  1) gnutools/2.69   2) cuda/7.0        3) pgi/17.5

```
Check nvcc compiler version
```
[username@comet-30-04:~] nvcc --version
[username@comet-30-04:~] nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2015 NVIDIA Corporation
Built on Mon_Feb_16_22:59:02_CST_2015
Cuda compilation tools, release 7.0, V7.0.2
```
Check installed GPUs with NVIDIA System Management Interface (nvidia-smi)
```
[username@comet-30-04:~] nvidia-smi
Mon Aug 19 17:35:46 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 396.26                 Driver Version: 396.26                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla K80           On   | 00000000:05:00.0 Off |                  Off |
| N/A   35C    P8    26W / 149W |      0MiB / 12206MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla K80           On   | 00000000:06:00.0 Off |                  Off |
| N/A   35C    P8    29W / 149W |      0MiB / 12206MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   2  Tesla K80           On   | 00000000:85:00.0 Off |                  Off |
| N/A   36C    P8    26W / 149W |      0MiB / 12206MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   3  Tesla K80           On   | 00000000:86:00.0 Off |                  Off |
| N/A   30C    P8    27W / 149W |      0MiB / 12206MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```
You have verified that you are on an interactive node and that the node contains 1 or more GPU devices. You can now run the cuda code from the command line.
```
[username@comet-30-04:~/cuda] cd simple_hello/
[username@comet-30-04:~/cuda/simple_hello] ll
total 333
drwxr-xr-x 2 username use300      7 Aug 19 17:41 .
drwxr-xr-x 6 username use300      6 Aug 19 17:39 ..
-rwxr-xr-x 1 username use300 516216 Aug 19 17:40 simple_hello
-rw-r--r-- 1 username use300    184 Apr 11 00:09 simple_hello.22532827.comet-33-06.out
-rw-r--r-- 1 username use300    306 Aug 19 17:39 simple_hello.cu
-rw-r--r-- 1 username use300    245 Apr 10 18:29 simple_hello_kernel.cu
-rw-r--r-- 1 username use300    519 Apr 10 23:38 simple_hello.sb
[username@comet-30-04:~/cuda/simple_hello] ./simple_hello 
Hello, NVIDIA DLI Workshop! You have 1 devices
```
Move the to gpu-enum directory, and run the enum code:
```
Last login: Mon Aug 19 11:40:20 on ttys006
(base) quantum:~ mthomas$ cd dev/
(base) quantum:dev mthomas$ ll
total 2136
drwxr-xr-x  21 mthomas  staff      672 Aug 19 15:09 .
drwxr-xr-x+ 46 mthomas  staff     1472 Aug 19 15:32 ..
-rw-r--r--@  1 mthomas  staff     6148 Aug 19 10:20 .DS_Store
drwxrwxrwx   6 mthomas  staff      192 Jun 25 17:03 atomtestdir
drwxr-xr-x  28 mthomas  staff      896 Aug 16 12:07 dashboards
-rw-r--r--@  1 mthomas  staff  1082252 Jul  9 15:24 git_tutorial.zip
drwxr-xr-x   5 mthomas  staff      160 Jul 11 09:42 gitimmersion-dev
drwxr-xr-x   3 mthomas  staff       96 Jul  9 15:25 gitimmersion.com
drwxr-xr-x   4 mthomas  staff      128 Aug  5 10:59 mkandes.git.galyeo
drwxr-xr-x   7 mthomas  staff      224 Aug 19 15:31 nvidia-dli-2019
drwxr-xr-x   6 mthomas  staff      192 Jul 11 17:54 python
drwxrwxrwx   3 mthomas  staff       96 Jun 30 19:18 pytst
drwxr-xr-x   5 mthomas  staff      160 Aug 16 17:18 sdsc-hpc-students
drwxr-xr-x  10 mthomas  staff      320 Aug 19 10:40 sdsc-hpc-training.github.io
drwxr-xr-x  24 mthomas  staff      768 Jul  9 15:10 sdsc-summer-institute-2018
drwxr-xr-x  24 mthomas  staff      768 Aug  5 16:56 sdsc-summer-institute-2019
drwxr-xr-x  16 mthomas  staff      512 Aug 19 10:40 sdsc-training.github.io
drwxr-xr-x   4 mthomas  staff      128 Aug 16 10:23 singularity
drwxr-xr-x   3 mthomas  staff       96 Jul  2 11:34 sinkovits.github
drwxr-xr-x   8 mthomas  staff      256 Aug  4 23:08 webinars
drwxr-xr-x  32 mthomas  staff     1024 Aug  4 22:46 website-summer-institute-2019
(base) quantum:dev mthomas$ cd sdsc-summer-institute-2019
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 8
drwxr-xr-x  24 mthomas  staff  768 Aug  5 16:56 .
drwxr-xr-x  21 mthomas  staff  672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff  480 Aug  5 16:56 .git
drwxr-xr-x   7 mthomas  staff  224 Aug  5 16:56 0_preparation
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 1_lightning_round
drwxr-xr-x   4 mthomas  staff  128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff  192 Aug  5 16:56 3_running_jobs_on_comet
drwxr-xr-x   3 mthomas  staff   96 Aug  5 16:56 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff  224 Aug  5 16:56 6_software_performance
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 7_science_gateways
drwxr-xr-x   4 mthomas  staff  128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff  352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  10 mthomas  staff  320 Aug  4 23:05 datasci2_machine_learning
drwxr-xr-x   5 mthomas  staff  160 Aug  4 23:05 datasci3_scalable_machine_learning
drwxr-xr-x   5 mthomas  staff  160 Aug  4 23:05 datasci4_deep_learning
drwxr-xr-x  12 mthomas  staff  384 Aug  4 23:05 hpc0_python_hpc
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 hpc3_gpu_cuda
drwxr-xr-x   3 mthomas  staff   96 Aug  4 23:05 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ git pull
remote: Enumerating objects: 123, done.
remote: Counting objects: 100% (123/123), done.
remote: Compressing objects: 100% (54/54), done.
remote: Total 515 (delta 84), reused 66 (delta 66), pack-reused 392
Receiving objects: 100% (515/515), 154.53 MiB | 4.48 MiB/s, done.
Resolving deltas: 100% (191/191), completed with 10 local objects.
From github.com:sdsc/sdsc-summer-institute-2019
   5b3433d..0d75d31  master           -> origin/master
 * [new branch]      mahidhar-patch-1 -> origin/mahidhar-patch-1
Updating 5b3433d..0d75d31
Fast-forward
 10-seedmelab                                           |     1 +
 10_SeedMeLab/1-SeedMeLab - Intro.pdf                   |   Bin 0 -> 2252527 bytes
 10_SeedMeLab/2-FolderShare-intro.pdf                   |   Bin 0 -> 5459433 bytes
 10_SeedMeLab/3-Foldershare_commandline.pdf             |   Bin 0 -> 6327371 bytes
 10_SeedMeLab/4-Foldershare_settings_overview.pdf       |   Bin 0 -> 17724249 bytes
 10_SeedMeLab/README.md                                 |     1 +
 1_lightning_round/Jared.Brzenski.pdf                   |   Bin 0 -> 944649 bytes
 1_lightning_round/Jose.MartinezLomeli.pdf              |   Bin 0 -> 553655 bytes
 1_lightning_round/README.md                            |    38 +
 1_lightning_round/Wenbin.luo.pdf                       |   Bin 0 -> 109377 bytes
 1_lightning_round/Yanqing.Su.pdf                       |   Bin 0 -> 1214861 bytes
 1_lightning_round/block.pptx.pdf                       |   Bin 0 -> 135517 bytes
 1_lightning_round/concatenated_reduced.pdf             |   Bin 0 -> 6253182 bytes
 1_lightning_round/cyd.burrows.pdf                      |   Bin 0 -> 47556 bytes
 1_lightning_round/devontae.baxter.pdf                  |   Bin 0 -> 193794 bytes
 1_lightning_round/diego.casanova.pdf                   |   Bin 0 -> 2025923 bytes
 1_lightning_round/ellie.kitanidis.pdf                  |   Bin 0 -> 10502837 bytes
 1_lightning_round/guillaume.shippee.pdf                |   Bin 0 -> 2520014 bytes
 1_lightning_round/jagath.vithanage.pdf                 |   Bin 0 -> 3857472 bytes
 1_lightning_round/jinsoung.yoo.pdf                     |   Bin 0 -> 190083 bytes
 1_lightning_round/john.daniels.pdf                     |   Bin 0 -> 90332 bytes
 1_lightning_round/juancarlos.villasenorderbez.pdf      |   Bin 0 -> 387179 bytes
 1_lightning_round/kai.chen.pdf                         |   Bin 0 -> 2425468 bytes
 1_lightning_round/luis.martinezlomeli.pdf              |   Bin 0 -> 342846 bytes
 1_lightning_round/mdshahrier.Hasan.pdf                 |   Bin 0 -> 26862 bytes
 1_lightning_round/mike.boyle.pdf                       |   Bin 0 -> 339386 bytes
 1_lightning_round/minglang.yin.pdf                     |   Bin 0 -> 1918679 bytes
 1_lightning_round/omarzintan.mwinila-yuori .pdf        |   Bin 0 -> 166599 bytes
 1_lightning_round/pierre.kawak2.pdf                    |   Bin 0 -> 529105 bytes
 1_lightning_round/rachel.anderson.pdf                  |   Bin 0 -> 243885 bytes
 1_lightning_round/roman.gerasimov.pdf                  |   Bin 0 -> 362141 bytes
 1_lightning_round/ryan.avery.pdf                       |   Bin 0 -> 2462040 bytes
 1_lightning_round/sharon.tettegah.pdf                  |   Bin 0 -> 243249 bytes
 1_lightning_round/stephanie.labou.pdf                  |   Bin 0 -> 102130 bytes
 1_lightning_round/template.ppt                         |   Bin 0 -> 96256 bytes
 1_lightning_round/tian.ni.pdf                          |   Bin 0 -> 10911 bytes
 1_lightning_round/tianyang.chen.pdf                    |   Bin 0 -> 223471 bytes
 1_lightning_round/tomas.chor.pdf                       |   Bin 0 -> 1081177 bytes
 1_lightning_round/tongge.wu.pdf                        |   Bin 0 -> 1680358 bytes
 1_lightning_round/vania.wang.pdf                       |   Bin 0 -> 528261 bytes
 1_lightning_round/xiang.zhao.pdf                       |   Bin 0 -> 170909 bytes
 1_lightning_round/ye.zou.pdf                           |   Bin 0 -> 792857 bytes
 1_lightning_round/yohn.parra.pdf                       |   Bin 0 -> 196428 bytes
 1_lightning_round/zheng.fang.pdf                       |   Bin 0 -> 1682264 bytes
 .../introduction-to-git/images/bad-version-control.png |   Bin 0 -> 157162 bytes
 .../images/creating-different-versions.png             |   Bin 0 -> 8183 bytes
 .../images/dropbox_view_version_history.png            |   Bin 0 -> 59861 bytes
 .../images/git-add-and-commit-modified-file.png        |   Bin 0 -> 114004 bytes
 .../images/git-add-and-commit-more-new-files.png       |   Bin 0 -> 175684 bytes
 .../images/git-add-github-remote-and-push.png          |   Bin 0 -> 161378 bytes
 .../introduction-to-git/images/git-add.png             |   Bin 0 -> 88799 bytes
 .../images/git-adding-more-files-and-some-changes.png  |   Bin 0 -> 116194 bytes
 .../introduction-to-git/images/git-after-commit.png    |   Bin 0 -> 105116 bytes
 .../introduction-to-git/images/git-areas.png           |   Bin 0 -> 18502 bytes
 .../images/git-branch-and-checkout.png                 |   Bin 0 -> 150086 bytes
 .../images/git-branch-compare-with-master.png          |   Bin 0 -> 103886 bytes
 .../images/git-branch-modifying-earth-on-master.png    |   Bin 0 -> 113401 bytes
 .../images/git-clone-github-repo-to-comet.png          |   Bin 0 -> 138649 bytes
 .../introduction-to-git/images/git-commit-message.png  |   Bin 0 -> 53032 bytes
 .../introduction-to-git/images/git-diff.png            |   Bin 0 -> 88504 bytes
 .../introduction-to-git/images/git-file-lifecycle.png  |   Bin 0 -> 13727 bytes
 .../images/git-freshly-made-github-repo.png            |   Bin 0 -> 38566 bytes
 .../introduction-to-git/images/git-init.png            |   Bin 0 -> 134849 bytes
 .../introduction-to-git/images/git-logo.png            |   Bin 0 -> 34774 bytes
 .../images/git-merge-with-conflict-part1.png           |   Bin 0 -> 112850 bytes
 .../images/git-merge-with-conflict-part2.png           |   Bin 0 -> 100001 bytes
 .../images/git-merge-with-conflict-part3.png           |   Bin 0 -> 134365 bytes
 .../introduction-to-git/images/git-mv.png              |   Bin 0 -> 129090 bytes
 .../introduction-to-git/images/git-push-from-comet.png |   Bin 0 -> 168915 bytes
 .../introduction-to-git/images/git-rm.png              |   Bin 0 -> 126438 bytes
 .../introduction-to-git/images/git-staging-area.png    |   Bin 0 -> 28150 bytes
 .../introduction-to-git/images/git-untracked-file.png  |   Bin 0 -> 106453 bytes
 .../introduction-to-git/images/gitflow-model.png       |   Bin 0 -> 124925 bytes
 .../images/github-after-push-from-comet.png            |   Bin 0 -> 109425 bytes
 .../images/github-create-new-repo.png                  |   Bin 0 -> 90727 bytes
 .../images/github-how-to-setup-new-repo.png            |   Bin 0 -> 106164 bytes
 .../introduction-to-git/images/github-logo.jpg         |   Bin 0 -> 25447 bytes
 .../images/github-repo-after-first-push-diagram.png    |   Bin 0 -> 58682 bytes
 .../images/github-repo-after-first-push-web.png        |   Bin 0 -> 109227 bytes
 .../images/github-repo-after-first-push.svg            |   483 +
 .../images/good-version-control.png                    |   Bin 0 -> 153300 bytes
 .../images/hands-on-tutorial-by-masterss.jpg           |   Bin 0 -> 60537 bytes
 .../images/hands-on-tutorial-by-souortiz.png           |   Bin 0 -> 390873 bytes
 .../images/how-to-use-git-cartoon.png                  |   Bin 0 -> 48767 bytes
 .../macos-high-sierra-time-machine-documents.jpg       |   Bin 0 -> 463271 bytes
 .../introduction-to-git/images/merging-changes.png     |   Bin 0 -> 8486 bytes
 .../images/ms-word-track-changes.jpg                   |   Bin 0 -> 125920 bytes
 .../introduction-to-git/images/my-github-repo.png      |   Bin 0 -> 120824 bytes
 .../introduction-to-git/images/play-changes.png        |   Bin 0 -> 2184 bytes
 .../introduction-to-git/images/question-mark-sign.jpg  |   Bin 0 -> 21321 bytes
 .../images/revision-history-wikipedia.png              |   Bin 0 -> 198492 bytes
 .../images/shared-vs-distributed-repository-layout.png |   Bin 0 -> 23207 bytes
 .../introduction-to-git/images/total-recall.jpg        |   Bin 0 -> 138037 bytes
 .../images/version-control-phdcomics.png               |   Bin 0 -> 83783 bytes
 .../images/version-control-simply-explained.jpg        |   Bin 0 -> 261552 bytes
 .../images/version-control-wikipedia.png               |   Bin 0 -> 195416 bytes
 .../images/version-control-xkcd.jpg                    |   Bin 0 -> 87255 bytes
 .../introduction-to-git/introduction-to-git.pdf        |   Bin 0 -> 4763710 bytes
 .../introduction-to-git/introduction-to-git.tex        |  1020 ++
 7_science_gateways/SG_SI19.pdf                         |   Bin 0 -> 2406082 bytes
 .../introduction-to-singularity/examples/run-meep.sh   |    26 +
 .../examples/run-tensorflow-gpu.slurm                  |    25 +
 .../09AUG2019_SDSC_SI_2019.pdf                         |   Bin 0 -> 16092651 bytes
 datasci2_machine_learning/ML1-Intro.pdf                |   Bin 0 -> 11733997 bytes
 datasci2_machine_learning/ML2-DataExploration.pdf      |   Bin 0 -> 15876361 bytes
 datasci2_machine_learning/ML4-Classification.pdf       |   Bin 0 -> 11355708 bytes
 datasci2_machine_learning/data-dictionary-weather.txt  |    73 +
 datasci2_machine_learning/weather-classif.Rmd          |   142 +
 datasci2_machine_learning/weather-classif.html         |   770 +
 datasci2_machine_learning/weather-eda-soln.Rmd         |   184 +
 datasci2_machine_learning/weather-eda-soln.html        |   861 ++
 datasci2_machine_learning/weather-eda.Rmd              |   184 +
 datasci2_machine_learning/weather-orig.rds             |   Bin 0 -> 12197 bytes
 datasci3_scalable_machine_learning/SML2-Spark.pdf      |   Bin 0 -> 1029176 bytes
 .../SML3-pyspark-Hands-on.pdf                          |   Bin 0 -> 2197934 bytes
 .../SML4-sparkR-Hands-on.pdf                           |   Bin 0 -> 2756588 bytes
 .../spark/pyspark/clustering.ipynb                     |   344 +
 .../pyspark/complete_notebooks/clustering-soln.html    | 14024 +++++++++++++++++
 .../pyspark/complete_notebooks/clustering-soln.ipynb   |   751 +
 .../complete_notebooks/data-exploration-soln.html      | 13763 +++++++++++++++++
 .../complete_notebooks/data-exploration-soln.ipynb     |   534 +
 .../spark/pyspark/data-exploration.ipynb               |   217 +
 .../spark/pyspark/spark.slrm                           |    26 +
 .../spark/pyspark/utils.py                             |    61 +
 datasci3_scalable_machine_learning/spark/spark.slrm    |    26 +
 .../complete_notebooks/data-exploration-R-soln.html    | 17080 +++++++++++++++++++++
 .../complete_notebooks/data-exploration-R-soln.ipynb   |   597 +
 .../spark/sparkR/complete_notebooks/wine-R-soln.html   | 13742 +++++++++++++++++
 .../spark/sparkR/complete_notebooks/wine-R-soln.ipynb  |   720 +
 .../spark/sparkR/data-exploration-R.ipynb              |   215 +
 .../spark/sparkR/sparkR.slrm                           |    26 +
 .../spark/sparkR/wine-R.ipynb                          |   244 +
 datasci4_deep_learning/DL3a-transferLearning.pdf       |   Bin 0 -> 1850153 bytes
 .../DL3b-transferLearning-Hands-on.pdf                 |   Bin 0 -> 1244513 bytes
 datasci4_deep_learning/DL5-UNet-LSTM.pdf               |   Bin 0 -> 6069489 bytes
 .../DeepLearningTutorial/LabMNIST_SI2019_v1.ipynb      |   651 +
 datasci4_deep_learning/DeepLearningTutorial/X_test.npy |   Bin 0 -> 7840080 bytes
 .../DeepLearningTutorial/X_train1k.npy                 |   Bin 0 -> 784080 bytes
 .../DeepLearningTutorial/X_train5k.npy                 |   Bin 0 -> 3920080 bytes
 .../DeepLearningTutorial/Xtrain_num0_cat_5.jpeg        |   Bin 0 -> 610 bytes
 .../DeepLearningTutorial/Xtrain_num1_cat_0.jpeg        |   Bin 0 -> 582 bytes
 datasci4_deep_learning/DeepLearningTutorial/Y_test.npy |   Bin 0 -> 10080 bytes
 .../DeepLearningTutorial/Y_train1k.npy                 |   Bin 0 -> 1080 bytes
 .../DeepLearningTutorial/Y_train5k.npy                 |   Bin 0 -> 5080 bytes
 .../completed_notebooks/features-soln.html             | 13906 +++++++++++++++++
 .../completed_notebooks/features-soln.ipynb            |   643 +
 .../completed_notebooks/finetune-soln.html             | 13872 +++++++++++++++++
 .../completed_notebooks/finetune-soln.ipynb            |   587 +
 datasci4_deep_learning/features.ipynb                  |   397 +
 datasci4_deep_learning/finetune.ipynb                  |   388 +
 datasci4_deep_learning/keras.slrm                      |    26 +
 .../keras/completed_notebooks/features-soln.html       | 13906 +++++++++++++++++
 .../keras/completed_notebooks/features-soln.ipynb      |   643 +
 .../keras/completed_notebooks/finetune-soln.html       | 13872 +++++++++++++++++
 .../keras/completed_notebooks/finetune-soln.ipynb      |   587 +
 datasci4_deep_learning/keras/features.ipynb            |   397 +
 datasci4_deep_learning/keras/finetune.ipynb            |   388 +
 datasci4_deep_learning/keras/keras.slrm                |    26 +
 hpc0_python_hpc/{1_dask_array => }/dask.delayed.ipynb  |     0
 hpc0_python_hpc/dask_slurm/README.md                   |    27 +
 hpc0_python_hpc/dask_slurm/dask_workers.slrm           |     2 +
 hpc0_python_hpc/notebook_singularity.slrm              |     2 +
 hpc0_python_hpc/{1_dask_array => }/processes.ipynb     |     0
 hpc0_python_hpc/{1_dask_array => }/threads.ipynb       |     0
 .../SI2019 Optimization tutorial.pdf                   |   Bin 0 -> 17594815 bytes
 .../SI2019 Optimzation blank.pptx                      |   Bin 0 -> 67849 bytes
 hpc1_performance_optimization/blocking.f               |    92 +
 hpc1_performance_optimization/commands                 |    96 +
 hpc1_performance_optimization/disttest.c               |    60 +
 hpc1_performance_optimization/dmadd_bad.f              |    73 +
 hpc1_performance_optimization/dmadd_good.f             |    73 +
 hpc1_performance_optimization/fusion.f                 |    68 +
 hpc1_performance_optimization/gprof_ex1.f              |    77 +
 hpc1_performance_optimization/lineq_mkl.c              |    64 +
 hpc1_performance_optimization/lineq_nomkl.c            |    63 +
 hpc1_performance_optimization/logsum.c                 |    81 +
 hpc1_performance_optimization/matmul.f                 |   101 +
 .../GPU_Computing_SI2019_Goetz_compressed.pdf          |   Bin 0 -> 3375422 bytes
 hpc3_gpu_cuda/README.md                                |    99 +
 hpc3_gpu_cuda/cuda-samples/1d_stencil/1d_stencil.cu    |   145 +
 .../cuda-samples/1d_stencil/exercise/1d_stencil.cu     |   123 +
 hpc3_gpu_cuda/cuda-samples/README                      |    63 +
 hpc3_gpu_cuda/cuda-samples/addition/add_gpu.cu         |    57 +
 .../cuda-samples/addition/exercise/vector_add_gpu2.cu  |    98 +
 hpc3_gpu_cuda/cuda-samples/addition/vector_add_gpu.cu  |    91 +
 hpc3_gpu_cuda/cuda-samples/addition/vector_add_gpu2.cu |    94 +
 .../cuda-samples/hello_world/hello_world_cpu.c         |    13 +
 .../cuda-samples/hello_world/hello_world_cpu.cu        |    18 +
 .../cuda-samples/hello_world/hello_world_device.cu     |    20 +
 .../cuda-samples/square_array/exercise/square_array.cu |    94 +
 .../cuda-samples/square_array/square_array.cu          |    92 +
 hpc3_gpu_cuda/openacc-samples/README                   |    67 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/README        |    55 +
 .../openacc-samples/laplace-2d/jacobi-acc-v1.f90       |    71 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-acc.c  |    84 +
 .../openacc-samples/laplace-2d/jacobi-acc.f90          |    73 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-omp.c  |    83 +
 .../openacc-samples/laplace-2d/jacobi-omp.f90          |    73 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi.c      |    81 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi.f90    |    67 +
 hpc3_gpu_cuda/openacc-samples/laplace-2d/timer.h       |    67 +
 hpc3_gpu_cuda/openacc-samples/saxpy/saxpy.c            |    36 +
 hpc4_mpi_openmp/SI2019_Parallel_Computing.pdf          |   Bin 0 -> 3850640 bytes
 203 files changed, 129110 insertions(+)
 create mode 100644 10-seedmelab
 create mode 100644 10_SeedMeLab/1-SeedMeLab - Intro.pdf
 create mode 100644 10_SeedMeLab/2-FolderShare-intro.pdf
 create mode 100644 10_SeedMeLab/3-Foldershare_commandline.pdf
 create mode 100644 10_SeedMeLab/4-Foldershare_settings_overview.pdf
 create mode 100644 10_SeedMeLab/README.md
 create mode 100644 1_lightning_round/Jared.Brzenski.pdf
 create mode 100644 1_lightning_round/Jose.MartinezLomeli.pdf
 create mode 100644 1_lightning_round/Wenbin.luo.pdf
 create mode 100644 1_lightning_round/Yanqing.Su.pdf
 create mode 100644 1_lightning_round/block.pptx.pdf
 create mode 100644 1_lightning_round/concatenated_reduced.pdf
 create mode 100644 1_lightning_round/cyd.burrows.pdf
 create mode 100644 1_lightning_round/devontae.baxter.pdf
 create mode 100644 1_lightning_round/diego.casanova.pdf
 create mode 100644 1_lightning_round/ellie.kitanidis.pdf
 create mode 100644 1_lightning_round/guillaume.shippee.pdf
 create mode 100644 1_lightning_round/jagath.vithanage.pdf
 create mode 100644 1_lightning_round/jinsoung.yoo.pdf
 create mode 100644 1_lightning_round/john.daniels.pdf
 create mode 100644 1_lightning_round/juancarlos.villasenorderbez.pdf
 create mode 100644 1_lightning_round/kai.chen.pdf
 create mode 100644 1_lightning_round/luis.martinezlomeli.pdf
 create mode 100644 1_lightning_round/mdshahrier.Hasan.pdf
 create mode 100644 1_lightning_round/mike.boyle.pdf
 create mode 100644 1_lightning_round/minglang.yin.pdf
 create mode 100644 1_lightning_round/omarzintan.mwinila-yuori .pdf
 create mode 100644 1_lightning_round/pierre.kawak2.pdf
 create mode 100644 1_lightning_round/rachel.anderson.pdf
 create mode 100644 1_lightning_round/roman.gerasimov.pdf
 create mode 100644 1_lightning_round/ryan.avery.pdf
 create mode 100644 1_lightning_round/sharon.tettegah.pdf
 create mode 100644 1_lightning_round/stephanie.labou.pdf
 create mode 100644 1_lightning_round/template.ppt
 create mode 100644 1_lightning_round/tian.ni.pdf
 create mode 100644 1_lightning_round/tianyang.chen.pdf
 create mode 100644 1_lightning_round/tomas.chor.pdf
 create mode 100644 1_lightning_round/tongge.wu.pdf
 create mode 100644 1_lightning_round/vania.wang.pdf
 create mode 100644 1_lightning_round/xiang.zhao.pdf
 create mode 100644 1_lightning_round/ye.zou.pdf
 create mode 100644 1_lightning_round/yohn.parra.pdf
 create mode 100644 1_lightning_round/zheng.fang.pdf
 create mode 100644 4_version_control_git_github/introduction-to-git/images/bad-version-control.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/creating-different-versions.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/dropbox_view_version_history.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-add-and-commit-modified-file.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-add-and-commit-more-new-files.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-add-github-remote-and-push.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-add.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-adding-more-files-and-some-changes.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-after-commit.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-areas.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-branch-and-checkout.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-branch-compare-with-master.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-branch-modifying-earth-on-master.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-clone-github-repo-to-comet.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-commit-message.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-diff.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-file-lifecycle.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-freshly-made-github-repo.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-init.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-logo.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-merge-with-conflict-part1.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-merge-with-conflict-part2.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-merge-with-conflict-part3.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-mv.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-push-from-comet.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-rm.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-staging-area.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/git-untracked-file.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/gitflow-model.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-after-push-from-comet.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-create-new-repo.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-how-to-setup-new-repo.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-logo.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-repo-after-first-push-diagram.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-repo-after-first-push-web.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/github-repo-after-first-push.svg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/good-version-control.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/hands-on-tutorial-by-masterss.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/hands-on-tutorial-by-souortiz.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/how-to-use-git-cartoon.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/macos-high-sierra-time-machine-documents.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/merging-changes.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/ms-word-track-changes.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/my-github-repo.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/play-changes.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/question-mark-sign.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/revision-history-wikipedia.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/shared-vs-distributed-repository-layout.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/total-recall.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/version-control-phdcomics.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/version-control-simply-explained.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/images/version-control-wikipedia.png
 create mode 100644 4_version_control_git_github/introduction-to-git/images/version-control-xkcd.jpg
 create mode 100644 4_version_control_git_github/introduction-to-git/introduction-to-git.pdf
 create mode 100644 4_version_control_git_github/introduction-to-git/introduction-to-git.tex
 create mode 100644 7_science_gateways/SG_SI19.pdf
 create mode 100644 8_singularity_comet/introduction-to-singularity/examples/run-meep.sh
 create mode 100644 8_singularity_comet/introduction-to-singularity/examples/run-tensorflow-gpu.slurm
 create mode 100644 9_data_management_globus_seedme2/09AUG2019_SDSC_SI_2019.pdf
 create mode 100644 datasci2_machine_learning/ML1-Intro.pdf
 create mode 100644 datasci2_machine_learning/ML2-DataExploration.pdf
 create mode 100644 datasci2_machine_learning/ML4-Classification.pdf
 create mode 100644 datasci2_machine_learning/data-dictionary-weather.txt
 create mode 100644 datasci2_machine_learning/weather-classif.Rmd
 create mode 100644 datasci2_machine_learning/weather-classif.html
 create mode 100644 datasci2_machine_learning/weather-eda-soln.Rmd
 create mode 100644 datasci2_machine_learning/weather-eda-soln.html
 create mode 100644 datasci2_machine_learning/weather-eda.Rmd
 create mode 100644 datasci2_machine_learning/weather-orig.rds
 create mode 100644 datasci3_scalable_machine_learning/SML2-Spark.pdf
 create mode 100644 datasci3_scalable_machine_learning/SML3-pyspark-Hands-on.pdf
 create mode 100644 datasci3_scalable_machine_learning/SML4-sparkR-Hands-on.pdf
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/clustering.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/complete_notebooks/clustering-soln.html
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/complete_notebooks/clustering-soln.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/complete_notebooks/data-exploration-soln.html
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/complete_notebooks/data-exploration-soln.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/data-exploration.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/spark.slrm
 create mode 100644 datasci3_scalable_machine_learning/spark/pyspark/utils.py
 create mode 100644 datasci3_scalable_machine_learning/spark/spark.slrm
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/complete_notebooks/data-exploration-R-soln.html
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/complete_notebooks/data-exploration-R-soln.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/complete_notebooks/wine-R-soln.html
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/complete_notebooks/wine-R-soln.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/data-exploration-R.ipynb
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/sparkR.slrm
 create mode 100644 datasci3_scalable_machine_learning/spark/sparkR/wine-R.ipynb
 create mode 100644 datasci4_deep_learning/DL3a-transferLearning.pdf
 create mode 100644 datasci4_deep_learning/DL3b-transferLearning-Hands-on.pdf
 create mode 100644 datasci4_deep_learning/DL5-UNet-LSTM.pdf
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/LabMNIST_SI2019_v1.ipynb
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/X_test.npy
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/X_train1k.npy
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/X_train5k.npy
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/Xtrain_num0_cat_5.jpeg
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/Xtrain_num1_cat_0.jpeg
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/Y_test.npy
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/Y_train1k.npy
 create mode 100644 datasci4_deep_learning/DeepLearningTutorial/Y_train5k.npy
 create mode 100644 datasci4_deep_learning/completed_notebooks/features-soln.html
 create mode 100644 datasci4_deep_learning/completed_notebooks/features-soln.ipynb
 create mode 100644 datasci4_deep_learning/completed_notebooks/finetune-soln.html
 create mode 100644 datasci4_deep_learning/completed_notebooks/finetune-soln.ipynb
 create mode 100644 datasci4_deep_learning/features.ipynb
 create mode 100644 datasci4_deep_learning/finetune.ipynb
 create mode 100644 datasci4_deep_learning/keras.slrm
 create mode 100644 datasci4_deep_learning/keras/completed_notebooks/features-soln.html
 create mode 100644 datasci4_deep_learning/keras/completed_notebooks/features-soln.ipynb
 create mode 100644 datasci4_deep_learning/keras/completed_notebooks/finetune-soln.html
 create mode 100644 datasci4_deep_learning/keras/completed_notebooks/finetune-soln.ipynb
 create mode 100644 datasci4_deep_learning/keras/features.ipynb
 create mode 100644 datasci4_deep_learning/keras/finetune.ipynb
 create mode 100644 datasci4_deep_learning/keras/keras.slrm
 rename hpc0_python_hpc/{1_dask_array => }/dask.delayed.ipynb (100%)
 create mode 100644 hpc0_python_hpc/dask_slurm/README.md
 rename hpc0_python_hpc/{1_dask_array => }/processes.ipynb (100%)
 rename hpc0_python_hpc/{1_dask_array => }/threads.ipynb (100%)
 create mode 100644 hpc1_performance_optimization/SI2019 Optimization tutorial.pdf
 create mode 100644 hpc1_performance_optimization/SI2019 Optimzation blank.pptx
 create mode 100644 hpc1_performance_optimization/blocking.f
 create mode 100644 hpc1_performance_optimization/commands
 create mode 100644 hpc1_performance_optimization/disttest.c
 create mode 100644 hpc1_performance_optimization/dmadd_bad.f
 create mode 100644 hpc1_performance_optimization/dmadd_good.f
 create mode 100644 hpc1_performance_optimization/fusion.f
 create mode 100644 hpc1_performance_optimization/gprof_ex1.f
 create mode 100644 hpc1_performance_optimization/lineq_mkl.c
 create mode 100644 hpc1_performance_optimization/lineq_nomkl.c
 create mode 100644 hpc1_performance_optimization/logsum.c
 create mode 100644 hpc1_performance_optimization/matmul.f
 create mode 100644 hpc3_gpu_cuda/GPU_Computing_SI2019_Goetz_compressed.pdf
 create mode 100644 hpc3_gpu_cuda/cuda-samples/1d_stencil/1d_stencil.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/1d_stencil/exercise/1d_stencil.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/README
 create mode 100644 hpc3_gpu_cuda/cuda-samples/addition/add_gpu.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/addition/exercise/vector_add_gpu2.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/addition/vector_add_gpu.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/addition/vector_add_gpu2.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/hello_world/hello_world_cpu.c
 create mode 100644 hpc3_gpu_cuda/cuda-samples/hello_world/hello_world_cpu.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/hello_world/hello_world_device.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/square_array/exercise/square_array.cu
 create mode 100644 hpc3_gpu_cuda/cuda-samples/square_array/square_array.cu
 create mode 100644 hpc3_gpu_cuda/openacc-samples/README
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/README
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-acc-v1.f90
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-acc.c
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-acc.f90
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-omp.c
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi-omp.f90
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi.c
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/jacobi.f90
 create mode 100644 hpc3_gpu_cuda/openacc-samples/laplace-2d/timer.h
 create mode 100644 hpc3_gpu_cuda/openacc-samples/saxpy/saxpy.c
 create mode 100644 hpc4_mpi_openmp/SI2019_Parallel_Computing.pdf
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 16
drwxr-xr-x  26 mthomas  staff   832 Aug 19 15:36 .
drwxr-xr-x  21 mthomas  staff   672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 .git
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 0_preparation
-rw-r--r--   1 mthomas  staff     1 Aug 19 15:36 10-seedmelab
drwxr-xr-x   7 mthomas  staff   224 Aug 19 15:36 10_SeedMeLab
drwxr-xr-x  40 mthomas  staff  1280 Aug 19 15:36 1_lightning_round
drwxr-xr-x   4 mthomas  staff   128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff   192 Aug  5 16:56 3_running_jobs_on_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 6_software_performance
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 7_science_gateways
drwxr-xr-x   4 mthomas  staff   128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff   352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  20 mthomas  staff   640 Aug 19 15:36 datasci2_machine_learning
drwxr-xr-x   9 mthomas  staff   288 Aug 19 15:36 datasci3_scalable_machine_learning
drwxr-xr-x  14 mthomas  staff   448 Aug 19 15:36 datasci4_deep_learning
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 hpc0_python_hpc
drwxr-xr-x  16 mthomas  staff   512 Aug 19 15:36 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   6 mthomas  staff   192 Aug 19 15:36 hpc3_gpu_cuda
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ cd datasci4_deep_learning/
(base) quantum:datasci4_deep_learning mthomas$ ll
total 25240
drwxr-xr-x  14 mthomas  staff      448 Aug 19 15:36 .
drwxr-xr-x  26 mthomas  staff      832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff  1850153 Aug 19 15:36 DL3a-transferLearning.pdf
-rw-r--r--   1 mthomas  staff  1244513 Aug 19 15:36 DL3b-transferLearning-Hands-on.pdf
-rw-r--r--   1 mthomas  staff  6069489 Aug 19 15:36 DL5-UNet-LSTM.pdf
drwxr-xr-x  11 mthomas  staff      352 Aug 19 15:36 DeepLearningTutorial
-rw-r--r--   1 mthomas  staff        0 Aug  4 23:05 README.md
-rw-r--r--   1 mthomas  staff  1426138 Aug  4 23:05 SI2019_deeplearning_V2_final.pdf
-rw-r--r--   1 mthomas  staff  2297285 Aug  4 23:05 SI2019_objectdetect_V2_final.pdf
drwxr-xr-x   6 mthomas  staff      192 Aug 19 15:36 completed_notebooks
-rw-r--r--   1 mthomas  staff    10606 Aug 19 15:36 features.ipynb
-rw-r--r--   1 mthomas  staff    10299 Aug 19 15:36 finetune.ipynb
drwxr-xr-x   6 mthomas  staff      192 Aug 19 15:36 keras
-rw-r--r--   1 mthomas  staff      793 Aug 19 15:36 keras.slrm
(base) quantum:datasci4_deep_learning mthomas$ ll
total 25240
drwxr-xr-x  14 mthomas  staff      448 Aug 19 15:36 .
drwxr-xr-x  26 mthomas  staff      832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff  1850153 Aug 19 15:36 DL3a-transferLearning.pdf
-rw-r--r--   1 mthomas  staff  1244513 Aug 19 15:36 DL3b-transferLearning-Hands-on.pdf
-rw-r--r--   1 mthomas  staff  6069489 Aug 19 15:36 DL5-UNet-LSTM.pdf
drwxr-xr-x  11 mthomas  staff      352 Aug 19 15:36 DeepLearningTutorial
-rw-r--r--   1 mthomas  staff        0 Aug  4 23:05 README.md
-rw-r--r--   1 mthomas  staff  1426138 Aug  4 23:05 SI2019_deeplearning_V2_final.pdf
-rw-r--r--   1 mthomas  staff  2297285 Aug  4 23:05 SI2019_objectdetect_V2_final.pdf
drwxr-xr-x   6 mthomas  staff      192 Aug 19 15:36 completed_notebooks
-rw-r--r--   1 mthomas  staff    10606 Aug 19 15:36 features.ipynb
-rw-r--r--   1 mthomas  staff    10299 Aug 19 15:36 finetune.ipynb
drwxr-xr-x   6 mthomas  staff      192 Aug 19 15:36 keras
-rw-r--r--   1 mthomas  staff      793 Aug 19 15:36 keras.slrm
(base) quantum:datasci4_deep_learning mthomas$ cp -R DeepLearningTutorial /Users/mthomas/dev/nvidia-dli-2019/day1
(base) quantum:datasci4_deep_learning mthomas$ 
(base) quantum:datasci4_deep_learning mthomas$ cd ..
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 16
drwxr-xr-x  26 mthomas  staff   832 Aug 19 15:36 .
drwxr-xr-x  21 mthomas  staff   672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 .git
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 0_preparation
-rw-r--r--   1 mthomas  staff     1 Aug 19 15:36 10-seedmelab
drwxr-xr-x   7 mthomas  staff   224 Aug 19 15:36 10_SeedMeLab
drwxr-xr-x  40 mthomas  staff  1280 Aug 19 15:36 1_lightning_round
drwxr-xr-x   4 mthomas  staff   128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff   192 Aug  5 16:56 3_running_jobs_on_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 6_software_performance
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 7_science_gateways
drwxr-xr-x   4 mthomas  staff   128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff   352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  20 mthomas  staff   640 Aug 19 15:36 datasci2_machine_learning
drwxr-xr-x   9 mthomas  staff   288 Aug 19 15:36 datasci3_scalable_machine_learning
drwxr-xr-x  14 mthomas  staff   448 Aug 19 15:36 datasci4_deep_learning
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 hpc0_python_hpc
drwxr-xr-x  16 mthomas  staff   512 Aug 19 15:36 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   6 mthomas  staff   192 Aug 19 15:36 hpc3_gpu_cuda
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll 0_preparation/
total 272
drwxr-xr-x   7 mthomas  staff     224 Aug  5 16:56 .
drwxr-xr-x  26 mthomas  staff     832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff    2116 Jul 18 11:53 README.md
-rw-r--r--   1 mthomas  staff  123754 Jul 18 11:53 RStudio_on_Comet_07-18-2018.pdf
drwxr-xr-x   4 mthomas  staff     128 Aug  5 00:06 basic_linux_skills
drwxr-xr-x   6 mthomas  staff     192 Jul 18 11:53 getting_started
-rw-r--r--   1 mthomas  staff    7116 Aug  5 16:56 software_requirements.md
(base) quantum:sdsc-summer-institute-2019 mthomas$ history
   15  echo $?
   16  echo $?
   17  jupyterhub 
   18  cd /anaconda3/
   19  ll
   20  cd etc
   21  ll
   22  cd jupyterhub/
   23  ll
   24  pwd
   25  ll
   26  ll ..
   27  ll
   28  mkdir spawners
   29  cd spawners/
   30  pip install jupyterhub-simplespawner
   31  ll
   32  ll ~
   33  ls ~/.jupyter/
   34  ls ~/.jupyter/lab
   35  ls ~/.jupyter/lab/workspaces/
   36  ls ~/.jupyter/lab/workspaces/lab-a511.jupyterlab-workspace 
   37  ls ~/.jupyter/
   38  ls ~/.jupyter/migrated 
   39  ll ~
   40  pwd
   41  git clone git@github.com:jupyterhub/simplespawner.git
   42  ll
   43  cd simplespawner/
   44  ll
   45  pip install jupyterhub-simplespawner
   46  ls /anaconda3/lib/python3.7/site-packages/
   47  ls /anaconda3/lib/python3.7/site-packages/simplespawner/
   48  pip install jupyterhub-batchspawner
   49  ll
   50  cd ..
   51  ll
   52  cd ..
   53  pwd
   54  ll
   55  vi jupyterhub_config.py 
   56  cd spawners/
   57  git clone git@github.com:jupyterhub/batchspawner.git
   58  ll
   59  cd batchspawner/
   60  ll
   61  pip install -e 
   62  pip install -e batchspawner
   63  ll
   64  pip install batchspawner
   65  pip install batchspawner -e
   66  pip install -e batchspawner 
   67  ll
   68  ll
   69  cd ..
   70  ll
   71  cd ..
   72  ll
   73  vi jupyterhub_config.py 
   74  cd spawners/
   75  ll
   76  cd batchspawner/
   77  ll
   78  ll batchspawner
   79  vi batchspawner.egg-info/
   80  vi batchspawner.py
   81  ll
   82  ll batchspawner
   83  vi batchspawner/batchspawner.py 
   84  vi batchspawner/batchspawner.py 
   85  cd ..
   86  ll
   87  cd jupyterhub-singularity-spawner/
   88  ll
   89  history | grep pip
   90  pip install batchspawner -e .
   91  ll
   92  ll
   93  cat requirements.txt 
   94  cat README.md 
   95  cd ..
   96  ll
   97  git clone https://github.com/ResearchComputing/jupyterhub-singularity-spawner.git
   98  rm -rf jupyterhub-singularity-spawner/
   99  git clone https://github.com/ResearchComputing/jupyterhub-singularity-spawner.git
  100  cd jupyterhub-singularity-spawner/
  101  ll
  102  vi README.md 
  103  pip install jupyterhub-singularity-spawner
  104  ll
  105  cat requirements.txt 
  106  pip install singularity
  107  cd
  108  vi jjill
  109  ll
  110  cd Desktop/
  111  cd ../Documents/Jupyter/rkwei-install/
  112  grep -ni exec_prefix *.py
  113  l
  114  ll
  115  vi batchspawner.py 
  116  hpc-ipnb 
  117  ll
  118  grep trait_names batchspawner.py 
  119  grep trait_names *.py
  120  grep cmd_formatted *.py
  121  grep -n cmd_formatted *.py
  122  grep -n cmd_formatted *.py
  123  vi batchspawner.py 
  124  vi jupyterhub_config.py 
  125  vi batchspawner.py 
  126  hpc-ipnb 
  127  hpc-ipnb 
  128  vi batchspawner.py 
  129  vi jupyterhub_config.py 
  130  grep -ni JUPYTERHUB_API_TOKEN *.py
  131  vi batchspawner.py 
  132  vi jupyterhub_config.py 
  133  grep -ni port jupyterhub_config.py 
  134  cd
  135  pip install bash_kernel
  136  python -m bash_kernel.install
  137  cd dev
  138  ll
  139  cd REHS19
  140  ll
  141  git pull
  142  ll */*.ipynb
  143  ll
  144  cd mary
  145  ll
  146  cp ../alisha/systemControls.ipynb test_bash.ipynb
  147  opwd
  148  pwd
  149  git status
  150  ll
  151  git add test_bash.ipynb 
  152  git commit -m 'uploading example of working within a bash kernel.'
  153  git push
  154  git add test_bash.ipynb 
  155  git commit -m 'uploading example of working within a bash kernel.'
  156  git push
  157  git pull
  158  hpc-ipnb 
  159  hpc-ipnb 
  160  hpc-ipnb 
  161  hpc-ipnb 
  162  alias hpc-ipnb
  163  comet
  164  cat ~/.accts/jupyterhub.accounts 
  165  hpc-ipnb 
  166  comet
  167  comet
  168  comet
  169  ipython notebook
  170  jupyter notebook
  171  cd
  172  cd dev/REHS19
  173  jupyter notebook
  174  comet
  175  comet
  176  PS1='[PEXP\[\]ECT_PROMPT>' PS2='[PEXP\[\]ECT_PROMPT+' PROMPT_COMMAND=''
  177  export PAGER=cat
  178  display () {     TMPFILE=$(mktemp ${TMPDIR-/tmp}/bash_kernel.XXXXXXXXXX);     cat > $TMPFILE;     echo "bash_kernel: saved image data to: $TMPFILE" >&2; }
  179  ssh username@comet.sdsc.edu
  180  cd dev
  181  git clone git@github.com:sdsc/website-summer-institute-2019.git
  182  ll
  183  cd sdsc-summer-institute-2019
  184  ll
  185  cd ..
  186  ll
  187  cd website-summer-institute-2019/
  188  ll
  189  vi instructors.html 
  190  ll
  191  ll section*
  192  ll */section*
  193  ll
  194  grep -ni thomas *
  195  grep -ni thomas */*
  196  cat _speakers/thomas.md 
  197  ll
  198  ll _sections/
  199  grep -ni basics *
  200  grep -ni basics */*
  201  grep -ni basics */*
  202  git status
  203  git pull
  204  ll
  205  cd ..
  206  ll
  207  d sdsc-summer-institute-2019
  208  cd sdsc-summer-institute-2019
  209  git pull
  210  ll
  211  cd 3_running_jobs_on_comet/
  212  ll
  213  grep -ni src= README.md 
  214  pwd
  215  ll
  216  pwd
  217  ll
  218  pwd
  219  ll
  220  git rm Comet_Launching_Jobs*
  221  ll
  222  mv Webinar-Running-Jobs-on-Comet.pdf Running-Jobs-on-Comet.pdf 
  223  ll
  224  ll
  225  ll ..
  226  ll ../0_preparation/
  227  ll ../0_preparation/ll
  228  ll
  229  git pull
  230  git status
  231  git add Running-Jobs-on-Comet.pdf images running-jobs.md 
  232  git commit -m 'updating running jobs material
  233  '
  234  git push
  235  cd ..
  236  ll
  237  cd 0_preparation/
  238  ll
  239  cd basic_linux_skills/
  240  ll
  241  pwd
  242  ll
  243  mv systemControls.ipynb basic_linux_skills.ipynb
  244  hpc-ipnb 
  245  cd dev/
  246  ll
  247  rm -rf REHS19-TMP
  248  ll
  249  git clone git@github.com:sdsc-training/webinars.git
  250  ll
  251  cd webinars/
  252  ll
  253  cd introduction-to-running-jobs-on-comet/
  254  ll
  255  diff running-jobs.md /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet/README.md 
  256  diff -y running-jobs.md /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet/README.md 
  257  diff -y running-jobs.md /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet/README.md  | more
  258  ll
  259  cat README.md 
  260  pwd
  261  pwd
  262  ls
  263  cp running-jobs.md /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet
  264  cp Webinar-Running-Jobs-on-Comet.pdf /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet
  265  mv Webinar-Running-Jobs-on-Comet.pdf Running-Jobs-on-Comet.pdf 
  266  ll
  267  pwd
  268  ll images/
  269  cp images/* /Users/mthomas/dev/sdsc-summer-institute-2019/3_running_jobs_on_comet/images/
  270  pwd
  271  ll
  272  cd
  273  cd dev/
  274  ll
  275  cd sdsc-summer-institute-2018/
  276  ll
  277  cd hpc0_python_hpc/
  278  ll
  279  cat notebook_singularity.slrm 
  280  cd digits_of_pi/
  281  ll
  282  cd ..
  283  ll
  284  cd ..
  285  l
  286  ll
  287  cd ..
  288  ll
  289  cd REHS19/
  290  git pull
  291  ll alisha/
  292  ll
  293  cd alisha/
  294  ll
  295  scp systemControls.ipynb /Users/mthomas/dev/sdsc-summer-institute-2019/0_preparation/basic_linux_skills
  296  hpc-ipnb
  297  hpc-ipnb 
  298  comet
  299  history
  300  git remote add origin https://github.com/marypthomas/planets
  301  git remote add origin https://github.com/marypthomas/planets.gut
  302  git remote add origin https://github.com/marypthomas/planets.git
  303  git remote add origin https://github.com/marypthomas/planets.git
  304  git push origin master
  305  ll
  306  rm -rf .git
  307  git init
  308  ll
  309  git status
  310  git add earth.txt mars.txt pluto.txt 
  311  git remote add origin https://github.com/marypthomas/planets.git
  312  git add earth.txt mars.txt pluto.txt git push origin master
  313  git add earth.txt mars.txt pluto.txt git push origin master
  314  git add earth.txt mars.txt pluto.txt git 
  315  git status
  316  git add earth.txt 
  317  git status
  318  git commet -m 'create new repo'
  319  git commit -m 'create new repo'
  320  git push origin master
  321  git remote add origin https://github.com/marypthomas/planets.git
  322  git remote add origin git@github.com:marypthomas/planets.git
  323  git push -u origin master
  324  vi ~/.gitconfig 
  325  ll
  326  vi .git/.gitconfig
  327  vi .git/.gitconfig
  328  git remote add origin git@github.com:marypthomas/planets.git
  329  git push -u origin master
  330  vi ~/.gitconfig 
  331  git remote set-url origin git@github.com:marypthomas/planets.git
  332  git push -u origin master
  333  hpc-ipnb 
  334  L
  335  ll
  336  hpc-ipnb 
  337  hpc-ipnb 
  338  comet
  339  hpc-ipnb 
  340  comet
  341  cd dev/
  342  ll
  343  cd sdsc-summer-institute-2019
  344  ll
  345  cd 8_singularity_comet/
  346  ll
  347  git pull
  348  ll
  349  comet
  350  Utilizing SDSC Comet for Machine Learning and Data Science
  351  which singularity
  352  singularity --version
  353  singularity -help
  354  pwd
  355  ll
  356  cd sdsc-summer-institute-2019/8_singularity_comet/
  357  ll
  358  cd introduction-to-singularity/
  359  ll
  360  singularity --version
  361  cd devq
  362  cd dev
  363  pwd
  364  pwd
  365  cd
  366  cd dev/
  367  ll
  368  mkdir singularity
  369  cd singularity/
  370  ll
  371  singularity pull shub://vsoch/hello-world
  372  ll
  373   singularity pull --name hello.simg shub://vsoch/hello-world
  374  ll
  375  singularity build hello-world.simg shub://vsoch/hello-world
  376  ll
  377  singularity pull --name hello-world.simg shub://vsoch/hello-world
  378  history
  379  ll
  380  singularity pull --name hello-world.simg shub://vsoch/hello-world
  381  singularity shell hello.simg 
  382   singularity shell shub://vsoch/hello-world
  383  singularity exec hello-world.simg ls /
  384  singularity exec hello.simg ls /
  385  singularity run hello-world.simg
  386  singularity run hello.simg
  387  history
  388  $ singularity --debug run shub://GodloveD/lolcow
  389  singularity --debug run shub://GodloveD/lolcow
  390  singularity run --containall shub://GodloveD/lolcow
  391  singularity --debug run shub://GodloveD/lolcow
  392  sudo singularity --debug run shub://GodloveD/lolcow
  393  exit
  394  /anaconda3/bin/jupyter_mac.command ; exit;
  395  singularity run --containall shub://GodloveD/lolcow
  396  singularity --version
  397  singularity run --help
  398  singularity --debug run shub://GodloveD/lolcow
  399  sudo FATAL:   container creation failed: mount /proc/self/fd/3->/var/singularity/mnt/session/rootfs error: can't mount image /proc/self/fd/3: failed to mount squashfs filesystem: invalid argument
  400  sudo singularity --debug run shub://GodloveD/lolcow
  401  pwd
  402  ll
  403  rm -rf .singularity/
  404  singularity exec library://sylabsed/examples/lolcow cowsay "Fresh from the library"
  405  singularity --debug run shub://GodloveD/lolcow
  406  ll
  407  rm -rf .singularity/
  408  singularity --debug run shub://GodloveD/lolcow
  409  rm -rf .singularity/
  410  singularity run --containall shub://GodloveD/lolcow
  411  singularity run --containall shub://GodloveD/lolcowhistory
  412  history
  413  singularity run shub://GodloveD/lolcowhistory
  414  singularity -v
  415  singularity --version
  416  singularity --run shub://GodloveD/lolcowhistory
  417  singularity run --help
  418  history
  419  singularity exec library://sylabsed/examples/lolcow cowsay "Fresh from the library"
  420  locate lolcow
  421  ll /opt
  422  ll /usr
  423  ll /usr/local/
  424  ll /usr/local/Homebrew/
  425  ll /usr/local/Homebrew/Library/
  426  ll /usr/local/Homebrew/Library/Homebrew/
  427  which singularity
  428  ls /usr/local/bin/
  429  ls /usr/local/bin/run-singularity 
  430  cat /usr/local/bin/run-singularity 
  431  run-singularity shub://GodloveD/lolcowhistory
  432  history
  433  singularity run --containall shub://GodloveD/lolcow
  434  run-singularity --containall shub://GodloveD/lolcow
  435  singularity --run --containall shub://GodloveD/lolcow
  436  singularity --help
  437  singularity --help run
  438  cd dev
  439  ll
  440  cd sdsc-training.github.io/
  441  ll
  442  ll images
  443  ll
  444  cat .gitignore 
  445  cat _config.yml 
  446  ll _layouts/
  447  cp -r _layouts/ ../sdsc-hpc-training.github.io/
  448  ll
  449  ll ..
  450  ll ../sdsc-hpc-training.github.io/
  451  ll
  452  cp -R _layouts/ ../sdsc-hpc-training.github.io/
  453  ll ../sdsc-hpc-training.github.io/
  454  ll
  455  ll css
  456  ll
  457  ll */default*
  458  ll _layouts/
  459  grep -ni images *
  460  grep -ni images * | grep "SDSClogo"
  461  grep -ni images */* | grep "SDSClogo"
  462  grep -ni images */*/* | grep "SDSClogo"
  463  ll
  464  rm images/SDSClogo-plusname-red.pdf
  465  git rm rm images/SDSClogo-plusname-red.pdf
  466  git status
  467  git commit -m 'remove bad image file'
  468  git del images/SDSClogo-plusname-red.pdf
  469  git rm images/SDSClogo-plusname-red.pdf
  470  git status
  471  git commit -m 'remove bad image file'
  472  git push
  473  ll
  474  vi index.html 
  475  git add index.html 
  476  git commit -m 'tweak'
  477  git commit -m 'tweak index.html'
  478  git push
  479  cat ~/.gitconfig 
  480  ssh-add -l
  481  cat ~/.ssh/config
  482  git config --system --unset credential.helper
  483  ls /etc/gitconfig
  484  sudo git config --system --unset credential.helper
  485  git push
  486  ll
  487  git status
  488  git pull
  489  git push
  490  env | grep GIT
  491  env
  492  cd .ssh
  493  ll
  494  cp id_rsa id_rsa.quantum
  495  mv id_rsa.quantum mthomas.quantum.id_rsa
  496  ll
  497  ssh-keygen -t rsa -b 4096 -C "mthomas@sdsc.edu""
  498  ssh-keygen -t rsa -b 4096 -C "mthomas@sdsc.edu"
  499  ll
  500  cat mthomas.sdsc.edu.id_rsa.pub
  501  cd dev/
  502  ll
  503  cd sdsc-summer-institute-2019
  504  ll
  505  git pull
  506  ll
  507* cd datasci4_deep_learning
  508  ll
  509  ll
  510  cp -R DeepLearningTutorial /Users/mthomas/dev/nvidia-dli-2019/day1
  511  cd ..
  512  ll
  513  ll 0_preparation/
  514  history
(base) quantum:sdsc-summer-institute-2019 mthomas$ dn=/Users/mthomas/dev/nvidia-dli-2019/day1
(base) quantum:sdsc-summer-institute-2019 mthomas$ dd=0_preparation/
(base) quantum:sdsc-summer-institute-2019 mthomas$ dd=0_preparation
(base) quantum:sdsc-summer-institute-2019 mthomas$ cp -r $dd $dn/$dd
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 16
drwxr-xr-x  26 mthomas  staff   832 Aug 19 15:36 .
drwxr-xr-x  21 mthomas  staff   672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 .git
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 0_preparation
-rw-r--r--   1 mthomas  staff     1 Aug 19 15:36 10-seedmelab
drwxr-xr-x   7 mthomas  staff   224 Aug 19 15:36 10_SeedMeLab
drwxr-xr-x  40 mthomas  staff  1280 Aug 19 15:36 1_lightning_round
drwxr-xr-x   4 mthomas  staff   128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff   192 Aug  5 16:56 3_running_jobs_on_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 6_software_performance
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 7_science_gateways
drwxr-xr-x   4 mthomas  staff   128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff   352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  20 mthomas  staff   640 Aug 19 15:36 datasci2_machine_learning
drwxr-xr-x   9 mthomas  staff   288 Aug 19 15:36 datasci3_scalable_machine_learning
drwxr-xr-x  14 mthomas  staff   448 Aug 19 15:36 datasci4_deep_learning
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 hpc0_python_hpc
drwxr-xr-x  16 mthomas  staff   512 Aug 19 15:36 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   6 mthomas  staff   192 Aug 19 15:36 hpc3_gpu_cuda
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll 3_running_jobs_on_comet/
total 25872
drwxr-xr-x   6 mthomas  staff       192 Aug  5 16:56 .
drwxr-xr-x  26 mthomas  staff       832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff      1262 Aug  5 16:56 README.md
-rw-r--r--   1 mthomas  staff  13168611 Aug  4 23:41 Running-Jobs-on-Comet.pdf
drwxr-xr-x  10 mthomas  staff       320 Aug  4 23:42 images
-rw-r--r--   1 mthomas  staff     69772 Aug  4 23:40 running-jobs.md
(base) quantum:sdsc-summer-institute-2019 mthomas$ fn=3_running_jobs_on_comet/running-jobs.md 
(base) quantum:sdsc-summer-institute-2019 mthomas$ cp -r $dd $dn/$dd
(base) quantum:sdsc-summer-institute-2019 mthomas$ echo $dd
0_preparation
(base) quantum:sdsc-summer-institute-2019 mthomas$ echo $dn
/Users/mthomas/dev/nvidia-dli-2019/day1
(base) quantum:sdsc-summer-institute-2019 mthomas$ cp -r $fn $dn
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 16
drwxr-xr-x  26 mthomas  staff   832 Aug 19 15:36 .
drwxr-xr-x  21 mthomas  staff   672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 .git
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 0_preparation
-rw-r--r--   1 mthomas  staff     1 Aug 19 15:36 10-seedmelab
drwxr-xr-x   7 mthomas  staff   224 Aug 19 15:36 10_SeedMeLab
drwxr-xr-x  40 mthomas  staff  1280 Aug 19 15:36 1_lightning_round
drwxr-xr-x   4 mthomas  staff   128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff   192 Aug  5 16:56 3_running_jobs_on_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 6_software_performance
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 7_science_gateways
drwxr-xr-x   4 mthomas  staff   128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff   352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  20 mthomas  staff   640 Aug 19 15:36 datasci2_machine_learning
drwxr-xr-x   9 mthomas  staff   288 Aug 19 15:36 datasci3_scalable_machine_learning
drwxr-xr-x  14 mthomas  staff   448 Aug 19 15:36 datasci4_deep_learning
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 hpc0_python_hpc
drwxr-xr-x  16 mthomas  staff   512 Aug 19 15:36 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   6 mthomas  staff   192 Aug 19 15:36 hpc3_gpu_cuda
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ cd 3_running_jobs_on_comet/
(base) quantum:3_running_jobs_on_comet mthomas$ ll
total 25872
drwxr-xr-x   6 mthomas  staff       192 Aug  5 16:56 .
drwxr-xr-x  26 mthomas  staff       832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff      1262 Aug  5 16:56 README.md
-rw-r--r--   1 mthomas  staff  13168611 Aug  4 23:41 Running-Jobs-on-Comet.pdf
drwxr-xr-x  10 mthomas  staff       320 Aug  4 23:42 images
-rw-r--r--   1 mthomas  staff     69772 Aug  4 23:40 running-jobs.md
(base) quantum:3_running_jobs_on_comet mthomas$ vi running-jobs.md 
(base) quantum:3_running_jobs_on_comet mthomas$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   running-jobs.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	../0_preparation/basic_linux_skills/basic_linux_skills.ipynb
	../8_singularity_comet/introduction-to-singularity/.DS_Store

no changes added to commit (use "git add" and/or "git commit -a")
(base) quantum:3_running_jobs_on_comet mthomas$ git pull
Already up to date.
(base) quantum:3_running_jobs_on_comet mthomas$ git add running-jobs.md 
(base) quantum:3_running_jobs_on_comet mthomas$ git commit -m 'fixing date'
[master 4bd30ad] fixing date
 1 file changed, 1 insertion(+), 1 deletion(-)
(base) quantum:3_running_jobs_on_comet mthomas$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 367 bytes | 367.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:sdsc/sdsc-summer-institute-2019.git
   0d75d31..4bd30ad  master -> master
(base) quantum:3_running_jobs_on_comet mthomas$ git pull
Already up to date.
(base) quantum:3_running_jobs_on_comet mthomas$ ;;
-bash: syntax error near unexpected token `;;'
(base) quantum:3_running_jobs_on_comet mthomas$ ;;
-bash: syntax error near unexpected token `;;'
(base) quantum:3_running_jobs_on_comet mthomas$ ll
total 25872
drwxr-xr-x   6 mthomas  staff       192 Aug 19 17:07 .
drwxr-xr-x  26 mthomas  staff       832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff      1262 Aug  5 16:56 README.md
-rw-r--r--   1 mthomas  staff  13168611 Aug  4 23:41 Running-Jobs-on-Comet.pdf
drwxr-xr-x  10 mthomas  staff       320 Aug  4 23:42 images
-rw-r--r--   1 mthomas  staff     69772 Aug 19 17:07 running-jobs.md
(base) quantum:3_running_jobs_on_comet mthomas$ cp images/ /Users/mthomas/dev/nvidia-dli-2019/day1/comet_access
cp: images/ is a directory (not copied).
(base) quantum:3_running_jobs_on_comet mthomas$ cp or images /Users/mthomas/dev/nvidia-dli-2019/day1/comet_access
cp: or: No such file or directory
cp: images is a directory (not copied).
(base) quantum:3_running_jobs_on_comet mthomas$ cp -R images /Users/mthomas/dev/nvidia-dli-2019/day1/comet_access
(base) quantum:3_running_jobs_on_comet mthomas$ ll
total 25872
drwxr-xr-x   6 mthomas  staff       192 Aug 19 17:07 .
drwxr-xr-x  26 mthomas  staff       832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff      1262 Aug  5 16:56 README.md
-rw-r--r--   1 mthomas  staff  13168611 Aug  4 23:41 Running-Jobs-on-Comet.pdf
drwxr-xr-x  10 mthomas  staff       320 Aug  4 23:42 images
-rw-r--r--   1 mthomas  staff     69772 Aug 19 17:07 running-jobs.md
(base) quantum:3_running_jobs_on_comet mthomas$ cd ..
(base) quantum:sdsc-summer-institute-2019 mthomas$ ll
total 16
drwxr-xr-x  26 mthomas  staff   832 Aug 19 15:36 .
drwxr-xr-x  21 mthomas  staff   672 Aug 19 15:09 ..
drwxr-xr-x  15 mthomas  staff   480 Aug 19 17:07 .git
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 0_preparation
-rw-r--r--   1 mthomas  staff     1 Aug 19 15:36 10-seedmelab
drwxr-xr-x   7 mthomas  staff   224 Aug 19 15:36 10_SeedMeLab
drwxr-xr-x  40 mthomas  staff  1280 Aug 19 15:36 1_lightning_round
drwxr-xr-x   4 mthomas  staff   128 Aug  4 23:05 2_introduction
drwxr-xr-x   6 mthomas  staff   192 Aug 19 17:07 3_running_jobs_on_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 4_version_control_git_github
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 5_comet_filesystems
drwxr-xr-x   7 mthomas  staff   224 Aug  5 16:56 6_software_performance
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 7_science_gateways
drwxr-xr-x   4 mthomas  staff   128 Aug  5 16:56 8_singularity_comet
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 9_data_management_globus_seedme2
-rw-r--r--   1 mthomas  staff   352 Aug  5 16:56 README.md
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci0_intro_datasci
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 datasci1_information_visualization
drwxr-xr-x  20 mthomas  staff   640 Aug 19 15:36 datasci2_machine_learning
drwxr-xr-x   9 mthomas  staff   288 Aug 19 15:36 datasci3_scalable_machine_learning
drwxr-xr-x  14 mthomas  staff   448 Aug 19 15:36 datasci4_deep_learning
drwxr-xr-x  15 mthomas  staff   480 Aug 19 15:36 hpc0_python_hpc
drwxr-xr-x  16 mthomas  staff   512 Aug 19 15:36 hpc1_performance_optimization
drwxr-xr-x   3 mthomas  staff    96 Aug  4 23:05 hpc2_scientific_visualization
drwxr-xr-x   6 mthomas  staff   192 Aug 19 15:36 hpc3_gpu_cuda
drwxr-xr-x   4 mthomas  staff   128 Aug 19 15:36 hpc4_mpi_openmp
(base) quantum:sdsc-summer-institute-2019 mthomas$ cd 0_preparation/
(base) quantum:0_preparation mthomas$ ll
total 272
drwxr-xr-x   7 mthomas  staff     224 Aug  5 16:56 .
drwxr-xr-x  26 mthomas  staff     832 Aug 19 15:36 ..
-rw-r--r--   1 mthomas  staff    2116 Jul 18 11:53 README.md
-rw-r--r--   1 mthomas  staff  123754 Jul 18 11:53 RStudio_on_Comet_07-18-2018.pdf
drwxr-xr-x   4 mthomas  staff     128 Aug  5 00:06 basic_linux_skills
drwxr-xr-x   6 mthomas  staff     192 Jul 18 11:53 getting_started
-rw-r--r--   1 mthomas  staff    7116 Aug  5 16:56 software_requirements.md
(base) quantum:0_preparation mthomas$ cd basic_linux_skills/
(base) quantum:basic_linux_skills mthomas$ ll
total 80
drwxr-xr-x  4 mthomas  staff    128 Aug  5 00:06 .
drwxr-xr-x  7 mthomas  staff    224 Aug  5 16:56 ..
-rw-r--r--  1 mthomas  staff  24653 Jul 18 11:53 README.md
-rw-r--r--  1 mthomas  staff   9429 Aug  5 00:06 basic_linux_skills.ipynb
(base) quantum:basic_linux_skills mthomas$ cd ..
(base) quantum:0_preparation mthomas$ ll getting_started/
total 32
drwxr-xr-x  6 mthomas  staff   192 Jul 18 11:53 .
drwxr-xr-x  7 mthomas  staff   224 Aug  5 16:56 ..
-rw-r--r--  1 mthomas  staff   274 Jul 18 11:53 comet_user_guide.md
drwxr-xr-x  4 mthomas  staff   128 Jul 18 11:53 images
-rw-r--r--  1 mthomas  staff  6403 Jul 18 11:53 logging_onto_comet.md
-rw-r--r--  1 mthomas  staff  1022 Jul 18 11:53 using_github.md
(base) quantum:0_preparation mthomas$ cp getting_started/images/ /Users/mthomas/dev/nvidia-dli-2019/day1/comet_access
cp: getting_started/images/ is a directory (not copied).
(base) quantum:0_preparation mthomas$ cp  getting_started/images/* /Users/mthomas/dev/nvidia-dli-2019/day1/comet_access/images/
(base) quantum:0_preparation mthomas$ 
(base) quantum:0_preparation mthomas$ 
(base) quantum:0_preparation mthomas$ 
(base) quantum:0_preparation mthomas$ pwd
/Users/mthomas/dev/sdsc-summer-institute-2019/0_preparation
(base) quantum:0_preparation mthomas$ cd
(base) quantum:~ mthomas$ comet
Last login: Mon Aug 19 17:21:41 2019 from wireless-169-228-85-254.ucsd.edu
Rocks 6.2 (SideWinder)
Profile built 16:45 08-Feb-2016

Kickstarted 17:27 08-Feb-2016
                                                                       
                      WELCOME TO 
      __________________  __  _______________
        -----/ ____/ __ \/  |/  / ____/_  __/
          --/ /   / / / / /|_/ / __/   / /
           / /___/ /_/ / /  / / /___  / /
           \____/\____/_/  /_/_____/ /_/

*******************************************************************************

[1] Example Scripts: /share/apps/examples

[2] Filesystems:

     (a) Lustre scratch filesystem : /oasis/scratch/comet/$USER/temp_project
         (Preferred: Scalable large block I/O)
            *** Meant for storing data required for active simulations
            *** Not backed up and should not be used for storing data long term
            *** Periodically clear old data not required for active simulations

     (b) Compute/GPU node local SSD storage: /scratch/$USER/$SLURM_JOBID
         (Meta-data intensive jobs, high IOPs)

     (c) Lustre projects filesystem: /oasis/projects/nsf
     
     (d) /home/$USER : Only for source files, libraries, binaries.
         *Do not* use for I/O intensive jobs.

[3] Comet User Guide: http://www.sdsc.edu/support/user_guides/comet.html

******************************************************************************
ll
(base) [mthomas@comet-ln3:~] ll
total 74504
drwxr-x--- 42 mthomas use300       94 Aug 19 17:39 .
drwxr-xr-x 98 root    root          0 Aug 19 22:29 ..
-rw-r--r--  1 mthomas use300   102196 Jun  7 12:28 2019-calendar.jpg
-rw-r--r--  1 mthomas use300     1001 Jul 11 14:44 .bash_aliases
-rw-------  1 mthomas use300    52118 Aug 19 17:47 .bash_history
-rw-r--r--  1 mthomas use300       18 Jun 19  2017 .bash_logout
-rw-r--r--  1 mthomas use300      214 Aug  5 01:07 .bash_profile
-rw-r--r--  1 mthomas use300     1193 Aug  5 01:11 .bashrc
drwxr-xr-x  2 mthomas use300        4 Apr 10 17:54 bigdatafiles
drwxr-xr-x  3 mthomas use300        3 Jun 12 20:25 .cache
drwxr-xr-x  5 mthomas use300        7 Jan  7  2019 comet-examples
drwxrwsr-x  2 mthomas use300        3 Jul 31 15:32 .conda
drwx------  5 mthomas use300        5 Aug  6 10:52 .config
drwxr-xr-x  6 mthomas use300        6 Aug 19 17:39 cuda
drwx------  3 mthomas use300        3 Jan  7  2019 .dbus
drwxr-xr-x  5 mthomas use300        5 Aug  6 08:42 dev
drwx------  2 mthomas use300        4 Aug  5 01:08 .elinks
-rw-r--r--  1 mthomas use300     1641 Jun 22  2017 .gccomrc
drwx------  2 mthomas use300        2 Jan  7  2019 .gconf
-rw-r--r--  1 mthomas use300      134 Aug  5 08:52 getnodes.si19
-rw-r--r--  1 mthomas use300      248 Aug  7  2018 .gitconfig
drwx------  3 mthomas use300        3 Jan  7  2019 .gnome2
drwx------  2 mthomas use300        2 Jan  7  2019 .gnome2_private
drwxr-xr-x  2 mthomas use300        5 Jul 31 12:06 hello-mpi
drwxr-xr-x 10 mthomas use300       11 May 31 14:46 homework
drwx------  7 mthomas use300       14 Jun 24 23:51 hpctrain
drwxr-xr-x 14 mthomas use300       15 May 31 14:40 hpc-training-spring2019
drwxr-xr-x  3 mthomas use300        3 Jun 22  2017 intel
drwxr-xr-x  5 mthomas use300        5 Jun 12 20:11 .ipython
drwxr-xr-x  3 mthomas use300        6 Aug  6 08:46 .jupyter
-rw-r--r--  1 mthomas use300      509 Jul 31 12:16 jupyterhub_slurmspawner_25345044.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:15 jupyterhub_slurmspawner_25345136.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:15 jupyterhub_slurmspawner_25345254.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:18 jupyterhub_slurmspawner_25345404.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:29 jupyterhub_slurmspawner_25345477.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:34 jupyterhub_slurmspawner_25345513.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:40 jupyterhub_slurmspawner_25345555.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:53 jupyterhub_slurmspawner_25345853.log
-rw-r--r--  1 mthomas use300      509 Jul 31 15:28 jupyterhub_slurmspawner_25350251.log
-rw-r--r--  1 mthomas use300      511 Jul 31 15:26 jupyterhub_slurmspawner_25350263.log
-rw-r--r--  1 mthomas use300     1659 Jul 31 15:45 jupyterhub_slurmspawner_25350402.log
-rw-r--r--  1 mthomas use300      653 Jul 31 16:04 jupyterhub_slurmspawner_25350589.log
-rw-r--r--  1 mthomas use300       81 Jul 31 16:13 jupyterhub_slurmspawner_25350629.log
-rw-r--r--  1 mthomas use300       81 Jul 31 16:18 jupyterhub_slurmspawner_25350666.log
-rw-r--r--  1 mthomas use300     1171 Jul 31 16:20 jupyterhub_slurmspawner_25350712.log
-rw-r--r--  1 mthomas use300      179 Jul 31 16:36 jupyterhub_slurmspawner_25351061.log
-rw-r--r--  1 mthomas use300      179 Jul 31 16:40 jupyterhub_slurmspawner_25351078.log
-rw-r--r--  1 mthomas use300     2464 Jul 31 16:42 jupyterhub_slurmspawner_25351081.log
-rw-r--r--  1 mthomas use300     2430 Jul 31 16:48 jupyterhub_slurmspawner_25351104.log
-rw-r--r--  1 mthomas use300     2431 Jul 31 16:54 jupyterhub_slurmspawner_25351149.log
-rw-r--r--  1 mthomas use300     2431 Aug  2 12:36 jupyterhub_slurmspawner_25388442.log
-rw-r--r--  1 mthomas use300     2431 Aug  5 00:49 jupyterhub_slurmspawner_25424221.log
-rw-r--r--  1 mthomas use300     2567 Aug  5 00:59 jupyterhub_slurmspawner_25425118.log
-rw-r--r--  1 mthomas use300     2821 Aug  5 01:11 jupyterhub_slurmspawner_25425151.log
-rw-r--r--  1 mthomas use300     2821 Aug  5 01:18 jupyterhub_slurmspawner_25425164.log
-rw-r--r--  1 mthomas use300     5461 Aug  5 01:25 jupyterhub_slurmspawner_25425189.log
-rw-r--r--  1 mthomas use300      550 Aug  5 01:25 jupyter_notebook_config.py
drwxr-xr-x  3 mthomas use300        5 Apr 23 21:02 KANDES
drwxr-xr-x  2 mthomas use300        3 Jun 12 20:45 .keras
-rw-r--r--  1 mthomas use300      171 Jun 19  2017 .kshrc
-rw-------  1 mthomas use300       62 Jul 31 12:46 .lesshst
-rwx------  1 mthomas use300      146 Apr 10 20:35 loadgccomgnuenv.sh
-rwx------  1 mthomas use300      122 Apr 10 20:35 loadgnuenv.sh
-rwx------  1 mthomas use300       96 Apr 10 20:35 loadgpuenv.sh
-rwx------  1 mthomas use300      169 Apr 10 20:35 loadintelenv.sh
-rwx------  1 mthomas use300      192 Apr 10 20:35 loadRenv.sh
-rw-r--r--  1 mthomas use300      164 Jul 30 11:16 load.singularity.notebook.sh
drwx------  3 mthomas use300        3 Jun 12 20:11 .local
drwxr-xr-x 57 mthomas use300       58 Jul 31 16:40 miniconda3
-rw-r--r--  1 mthomas use300 75257002 Jul 29 07:25 Miniconda3-latest-Linux-x86_64.sh
drwx------  4 mthomas use300        4 Jan  7  2019 .mozilla
-rw-------  1 mthomas use300      517 Jul  6  2017 .ncviewrc
drwx------  3 mthomas use300        3 Aug  6  2018 .nv
-rw-r--r--  1 mthomas use300     1017 Jul  6  2017 .petscconfig
drwxr-----  3 mthomas use300        3 Aug  6  2018 .pki
-rw-r--r--  1 mthomas use300      180 Sep 18  2018 .profile
drwx------  2 mthomas use300        3 Jan  7  2019 .pulse
-rw-------  1 mthomas use300      256 Jan  7  2019 .pulse-cookie
drwxr-xr-x  4 mthomas use300       28 Jul 11 12:25 PythonSeries
drwxr-xr-x  2 mthomas use300        3 Jun 26 11:16 rehs
drwxr-xr-x  3 mthomas use300        3 Aug  7  2018 .rstudio-desktop
drwxr-xr-x 23 mthomas use300       24 Aug  7  2018 sdsc-summer-institute-2018
drwxr-xr-x  4 mthomas use300        4 Aug  7  2018 si18-perf
drwxr-xr-x  4 mthomas use300        4 Jul 11 15:12 .singularity
drwxr-x---  2 mthomas use300        2 Jul  5  2017 .slurm
drwx------  3 mthomas use300       10 Jul 11 14:47 .ssh
drwxr-xr-x  2 mthomas use300        5 Jul 17  2018 testchown
drwxr-xr-x  2 mthomas use300        4 Jul 17  2018 testdir
drwxr-xr-x  2 mthomas use300        2 Aug  6  2018 testgit
drwxr-xr-x  2 mthomas use300        5 Jul  9 15:01 tools
-rw-------  1 mthomas use300     9188 Aug 19 17:39 .viminfo
-rw-r--r--  1 mthomas use300       41 Jun 27  2017 .vimrc
drwxr-xr-x  2 mthomas use300        3 Jun 10 12:17 visitdev
-rw-------  1 mthomas use300     7805 Jun 11 10:13 .Xauthority
(base) [mthomas@comet-ln3:~] cd cuda/
(base) [mthomas@comet-ln3:~/cuda] ll
total 132
drwxr-xr-x  6 mthomas use300  6 Aug 19 17:39 .
drwxr-x--- 42 mthomas use300 94 Aug 19 17:39 ..
drwxr-xr-x  2 mthomas use300  2 Apr 10 17:56 1dstencil
drwxr-xr-x  2 mthomas use300  6 Aug 19 17:41 gpu_enum
drwxr-xr-x  3 mthomas use300  4 Apr 10 18:21 phys244
drwxr-xr-x  2 mthomas use300  7 Aug 19 17:41 simple_hello
(base) [mthomas@comet-ln3:~/cuda] l gpu_enum/
-bash: l: command not found
(base) [mthomas@comet-ln3:~/cuda] ll phys244/
total 149
drwxr-xr-x 3 mthomas use300      4 Apr 10 18:21 .
drwxr-xr-x 6 mthomas use300      6 Aug 19 17:39 ..
drwxr-xr-x 6 mthomas use300      7 May  9  2018 cuda-samples
-rw-r--r-- 1 mthomas use300 103642 Mar 31 11:15 cuda-samples.tar.gz
(base) [mthomas@comet-ln3:~/cuda] ll phys244/cuda-samples
total 50
drwxr-xr-x 6 mthomas use300    7 May  9  2018 .
drwxr-xr-x 3 mthomas use300    4 Apr 10 18:21 ..
drwxr-xr-x 3 mthomas use300    4 Apr 10 18:21 1d_stencil
drwxr-xr-x 3 mthomas use300    5 May  9  2018 addition
drwxr-xr-x 2 mthomas use300    7 Apr 10 18:23 hello_world
-rw-r--r-- 1 mthomas use300 1821 May  9  2018 README
drwxr-xr-x 3 mthomas use300    5 Apr 10 18:21 square_array
(base) [mthomas@comet-ln3:~/cuda] cd
(base) [mthomas@comet-ln3:~] git clone git@github.com:sdsc-hpc-training/nvidia-dli-2019.git
Cloning into 'nvidia-dli-2019'...
Warning: Permanently added the RSA host key for IP address '140.82.113.4' to the list of known hosts.
remote: Enumerating objects: 143, done.
remote: Counting objects: 100% (143/143), done.
remote: Compressing objects: 100% (129/129), done.
remote: Total 143 (delta 62), reused 45 (delta 8), pack-reused 0
Receiving objects: 100% (143/143), 4.43 MiB | 5.84 MiB/s, done.
Resolving deltas: 100% (62/62), done.
(base) [mthomas@comet-ln3:~] ll nvidia-dli-2019/
total 141
drwxr-xr-x  5 mthomas use300    7 Aug 19 22:31 .
drwxr-x--- 43 mthomas use300   95 Aug 19 22:31 ..
drwxr-xr-x  4 mthomas use300    5 Aug 19 22:31 day1
drwxr-xr-x  2 mthomas use300    3 Aug 19 22:31 day2
drwxr-xr-x  8 mthomas use300   13 Aug 19 22:31 .git
-rw-r--r--  1 mthomas use300   10 Aug 19 22:31 .gitignore
-rw-r--r--  1 mthomas use300 1198 Aug 19 22:31 README.md
(base) [mthomas@comet-ln3:~] ll /share
total 12
drwxr-xr-x  4 root root       0 Aug 19 17:43 .
drwxr-xr-x 32 root root    4096 Aug 19 17:36 ..
drwxr-sr-x  9 root root    4096 Sep  2  2016 apps
drwxrwx---  2 root xdusage 4096 Apr 13  2018 xdusage
(base) [mthomas@comet-ln3:~] ll /share/apps/
total 40
drwxr-sr-x   9 root        root    4096 Sep  2  2016 .
drwxr-xr-x   4 root        root       0 Aug 19 17:43 ..
drwxrwxr-x 246 mahidhar    use300  4096 Aug 15 10:53 compute
drwxrwxr-x  64 mahidhar    use300  4096 Jul 28 12:42 examples
drwxrwxr-x  41 mahidhar    use300  4096 Jul  8 21:05 gpu
drwxr-sr-x   2 img-storage root    4096 Sep  2  2016 img-storage
drwxr-xr-x   2 root        root    4096 Feb  1  2016 nvidia
drwxr-sr-x   3 root        root    4096 Aug 19  2016 singularity
drwxrwsr-x  16 root        wheel  12288 May 20 16:18 sys
(base) [mthomas@comet-ln3:~] ll /share/apps/gpu
total 164
drwxrwxr-x 41 mahidhar use300   4096 Jul  8 21:05 .
drwxr-sr-x  9 root     root     4096 Sep  2  2016 ..
drwxr-xr-x  6 jpg      use300   4096 Jun  6  2017 abinit
drwxrwxr-x  3 mahidhar use300   4096 Oct 23  2015 amber
drwxr-xr-x  2 jpg      use300   4096 Jul 19  2017 bin
drwxr-xr-x  2 mahidhar use300   4096 Nov  6  2016 BKS
drwxrwxr-x  6 mahidhar use300   4096 Oct  7  2015 boost
drwxrwxr-x  5 mahidhar use300   4096 Oct  4  2016 caffe
drwxrwxr-x  5 mahidhar use300   4096 Apr 21  2016 clblas
drwxrwxr-x  3 mahidhar use300   4096 Apr 21  2016 clmagma
drwxr-xr-x  4 jpg      use300   4096 Oct  2  2017 cuda
drwxr-xr-x 16 jpg      use300   4096 Nov 18  2016 cuda-8.0
drwxrwxr-x  2 mahidhar use300   4096 Oct 15  2015 ddt
drwx------ 16 mahidhar use300   4096 Nov  7  2016 espresso
drwxr-x---  3 jpg      gaussian 4096 Apr 23  2018 gaussian
drwxr-xr-x  5 mahidhar use300   4096 Oct  4  2016 gflags
drwxr-xr-x  3 mahidhar use300   4096 Oct  4  2016 gpu
drwxr-s---  7 mahidhar sys200   4096 Oct 21  2016 GPUTESTS
drwxr-xr-x  4 mahidhar use300   4096 Jul  8 21:15 gromacs
drwxrwxr-x  6 mahidhar use300   4096 Nov  7  2014 hdf5-1.8.14-linux-centos6-x86_64-gcc447-shared
drwxrwxr-x  6 mahidhar use300   4096 Aug 19  2015 hoomd
drwxrwxr-x  6 mahidhar use300   4096 Aug 20  2015 hoomd_single
drwxrwxr-x  2 mahidhar use300   4096 Aug 23  2017 interactive
drwxrwxr-x  2 mahidhar use300   4096 Aug  3  2017 lammps
drwxr-xr-x  4 jpg      use300   4096 Jun 21  2017 magma
drwxrwxr-x  5 mahidhar use300   4096 Jul 16  2016 MAGMA
drwxrwxr-x  3 mahidhar use300   4096 Mar 25  2016 MotionCorr
drwxrwxr-x  6 mahidhar use300   4096 Oct 31  2018 mvapich2-gdr
drwxrwxr-x 10 mahidhar use300   4096 Dec 27  2018 namd
drwxrwxr-x  8 mahidhar use300   4096 Oct  4  2016 opencv
drwxr-xr-x  8 mahidhar use300   4096 Dec 15  2018 openmpi
drwx------ 13 mahidhar use300   4096 Aug  3  2017 osu-caffe
drwx------  7 mahidhar use300   4096 Oct 30  2016 peptideB
drwxr-xr-x  9 mahidhar use300   4096 Jan  7  2019 pgi
drwxr-xr-x  3 jpg      use300   4096 Nov 18  2016 python
drwxr-xr-x  5 mahidhar use300   4096 Mar 20  2018 qe
drwxr-xr-x  8 mahidhar use300   4096 Oct 11  2017 relion2
drwxr-xr-x  9 mahidhar use300   4096 Dec 11  2016 relion2-beta
drwxr-xr-x  6 mahidhar use300   4096 May 13 22:03 relion3
drwxrwxr-x  5 mahidhar use300   4096 Jul 31  2018 singularity
drwxr-x---  2 jpg      vasp     4096 Mar 29  2016 vasp
(base) [mthomas@comet-ln3:~] ll /share/apps/gpu
total 164
drwxrwxr-x 41 mahidhar use300   4096 Jul  8 21:05 .
drwxr-sr-x  9 root     root     4096 Sep  2  2016 ..
drwxr-xr-x  6 jpg      use300   4096 Jun  6  2017 abinit
drwxrwxr-x  3 mahidhar use300   4096 Oct 23  2015 amber
drwxr-xr-x  2 jpg      use300   4096 Jul 19  2017 bin
drwxr-xr-x  2 mahidhar use300   4096 Nov  6  2016 BKS
drwxrwxr-x  6 mahidhar use300   4096 Oct  7  2015 boost
drwxrwxr-x  5 mahidhar use300   4096 Oct  4  2016 caffe
drwxrwxr-x  5 mahidhar use300   4096 Apr 21  2016 clblas
drwxrwxr-x  3 mahidhar use300   4096 Apr 21  2016 clmagma
drwxr-xr-x  4 jpg      use300   4096 Oct  2  2017 cuda
drwxr-xr-x 16 jpg      use300   4096 Nov 18  2016 cuda-8.0
drwxrwxr-x  2 mahidhar use300   4096 Oct 15  2015 ddt
drwx------ 16 mahidhar use300   4096 Nov  7  2016 espresso
drwxr-x---  3 jpg      gaussian 4096 Apr 23  2018 gaussian
drwxr-xr-x  5 mahidhar use300   4096 Oct  4  2016 gflags
drwxr-xr-x  3 mahidhar use300   4096 Oct  4  2016 gpu
drwxr-s---  7 mahidhar sys200   4096 Oct 21  2016 GPUTESTS
drwxr-xr-x  4 mahidhar use300   4096 Jul  8 21:15 gromacs
drwxrwxr-x  6 mahidhar use300   4096 Nov  7  2014 hdf5-1.8.14-linux-centos6-x86_64-gcc447-shared
drwxrwxr-x  6 mahidhar use300   4096 Aug 19  2015 hoomd
drwxrwxr-x  6 mahidhar use300   4096 Aug 20  2015 hoomd_single
drwxrwxr-x  2 mahidhar use300   4096 Aug 23  2017 interactive
drwxrwxr-x  2 mahidhar use300   4096 Aug  3  2017 lammps
drwxr-xr-x  4 jpg      use300   4096 Jun 21  2017 magma
drwxrwxr-x  5 mahidhar use300   4096 Jul 16  2016 MAGMA
drwxrwxr-x  3 mahidhar use300   4096 Mar 25  2016 MotionCorr
drwxrwxr-x  6 mahidhar use300   4096 Oct 31  2018 mvapich2-gdr
drwxrwxr-x 10 mahidhar use300   4096 Dec 27  2018 namd
drwxrwxr-x  8 mahidhar use300   4096 Oct  4  2016 opencv
drwxr-xr-x  8 mahidhar use300   4096 Dec 15  2018 openmpi
drwx------ 13 mahidhar use300   4096 Aug  3  2017 osu-caffe
drwx------  7 mahidhar use300   4096 Oct 30  2016 peptideB
drwxr-xr-x  9 mahidhar use300   4096 Jan  7  2019 pgi
drwxr-xr-x  3 jpg      use300   4096 Nov 18  2016 python
drwxr-xr-x  5 mahidhar use300   4096 Mar 20  2018 qe
drwxr-xr-x  8 mahidhar use300   4096 Oct 11  2017 relion2
drwxr-xr-x  9 mahidhar use300   4096 Dec 11  2016 relion2-beta
drwxr-xr-x  6 mahidhar use300   4096 May 13 22:03 relion3
drwxrwxr-x  5 mahidhar use300   4096 Jul 31  2018 singularity
drwxr-x---  2 jpg      vasp     4096 Mar 29  2016 vasp
(base) [mthomas@comet-ln3:~] 
(base) [mthomas@comet-ln3:~] ll
total 74523
drwxr-x--- 43 mthomas use300       95 Aug 19 22:31 .
drwxr-xr-x 97 root    root          0 Aug 19 22:33 ..
-rw-r--r--  1 mthomas use300   102196 Jun  7 12:28 2019-calendar.jpg
-rw-r--r--  1 mthomas use300     1001 Jul 11 14:44 .bash_aliases
-rw-------  1 mthomas use300    52118 Aug 19 17:47 .bash_history
-rw-r--r--  1 mthomas use300       18 Jun 19  2017 .bash_logout
-rw-r--r--  1 mthomas use300      214 Aug  5 01:07 .bash_profile
-rw-r--r--  1 mthomas use300     1193 Aug  5 01:11 .bashrc
drwxr-xr-x  2 mthomas use300        4 Apr 10 17:54 bigdatafiles
drwxr-xr-x  3 mthomas use300        3 Jun 12 20:25 .cache
drwxr-xr-x  5 mthomas use300        7 Jan  7  2019 comet-examples
drwxrwsr-x  2 mthomas use300        3 Jul 31 15:32 .conda
drwx------  5 mthomas use300        5 Aug  6 10:52 .config
drwxr-xr-x  6 mthomas use300        6 Aug 19 17:39 cuda
drwx------  3 mthomas use300        3 Jan  7  2019 .dbus
drwxr-xr-x  5 mthomas use300        5 Aug  6 08:42 dev
drwx------  2 mthomas use300        4 Aug  5 01:08 .elinks
-rw-r--r--  1 mthomas use300     1641 Jun 22  2017 .gccomrc
drwx------  2 mthomas use300        2 Jan  7  2019 .gconf
-rw-r--r--  1 mthomas use300      134 Aug  5 08:52 getnodes.si19
-rw-r--r--  1 mthomas use300      248 Aug  7  2018 .gitconfig
drwx------  3 mthomas use300        3 Jan  7  2019 .gnome2
drwx------  2 mthomas use300        2 Jan  7  2019 .gnome2_private
drwxr-xr-x  2 mthomas use300        5 Jul 31 12:06 hello-mpi
drwxr-xr-x 10 mthomas use300       11 May 31 14:46 homework
drwx------  7 mthomas use300       14 Jun 24 23:51 hpctrain
drwxr-xr-x 14 mthomas use300       15 May 31 14:40 hpc-training-spring2019
drwxr-xr-x  3 mthomas use300        3 Jun 22  2017 intel
drwxr-xr-x  5 mthomas use300        5 Jun 12 20:11 .ipython
drwxr-xr-x  3 mthomas use300        6 Aug  6 08:46 .jupyter
-rw-r--r--  1 mthomas use300      509 Jul 31 12:16 jupyterhub_slurmspawner_25345044.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:15 jupyterhub_slurmspawner_25345136.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:15 jupyterhub_slurmspawner_25345254.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:18 jupyterhub_slurmspawner_25345404.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:29 jupyterhub_slurmspawner_25345477.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:34 jupyterhub_slurmspawner_25345513.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:40 jupyterhub_slurmspawner_25345555.log
-rw-r--r--  1 mthomas use300      509 Jul 31 12:53 jupyterhub_slurmspawner_25345853.log
-rw-r--r--  1 mthomas use300      509 Jul 31 15:28 jupyterhub_slurmspawner_25350251.log
-rw-r--r--  1 mthomas use300      511 Jul 31 15:26 jupyterhub_slurmspawner_25350263.log
-rw-r--r--  1 mthomas use300     1659 Jul 31 15:45 jupyterhub_slurmspawner_25350402.log
-rw-r--r--  1 mthomas use300      653 Jul 31 16:04 jupyterhub_slurmspawner_25350589.log
-rw-r--r--  1 mthomas use300       81 Jul 31 16:13 jupyterhub_slurmspawner_25350629.log
-rw-r--r--  1 mthomas use300       81 Jul 31 16:18 jupyterhub_slurmspawner_25350666.log
-rw-r--r--  1 mthomas use300     1171 Jul 31 16:20 jupyterhub_slurmspawner_25350712.log
-rw-r--r--  1 mthomas use300      179 Jul 31 16:36 jupyterhub_slurmspawner_25351061.log
-rw-r--r--  1 mthomas use300      179 Jul 31 16:40 jupyterhub_slurmspawner_25351078.log
-rw-r--r--  1 mthomas use300     2464 Jul 31 16:42 jupyterhub_slurmspawner_25351081.log
-rw-r--r--  1 mthomas use300     2430 Jul 31 16:48 jupyterhub_slurmspawner_25351104.log
-rw-r--r--  1 mthomas use300     2431 Jul 31 16:54 jupyterhub_slurmspawner_25351149.log
-rw-r--r--  1 mthomas use300     2431 Aug  2 12:36 jupyterhub_slurmspawner_25388442.log
-rw-r--r--  1 mthomas use300     2431 Aug  5 00:49 jupyterhub_slurmspawner_25424221.log
-rw-r--r--  1 mthomas use300     2567 Aug  5 00:59 jupyterhub_slurmspawner_25425118.log
-rw-r--r--  1 mthomas use300     2821 Aug  5 01:11 jupyterhub_slurmspawner_25425151.log
-rw-r--r--  1 mthomas use300     2821 Aug  5 01:18 jupyterhub_slurmspawner_25425164.log
-rw-r--r--  1 mthomas use300     5461 Aug  5 01:25 jupyterhub_slurmspawner_25425189.log
-rw-r--r--  1 mthomas use300      550 Aug  5 01:25 jupyter_notebook_config.py
drwxr-xr-x  3 mthomas use300        5 Apr 23 21:02 KANDES
drwxr-xr-x  2 mthomas use300        3 Jun 12 20:45 .keras
-rw-r--r--  1 mthomas use300      171 Jun 19  2017 .kshrc
-rw-------  1 mthomas use300       62 Jul 31 12:46 .lesshst
-rwx------  1 mthomas use300      146 Apr 10 20:35 loadgccomgnuenv.sh
-rwx------  1 mthomas use300      122 Apr 10 20:35 loadgnuenv.sh
-rwx------  1 mthomas use300       96 Apr 10 20:35 loadgpuenv.sh
-rwx------  1 mthomas use300      169 Apr 10 20:35 loadintelenv.sh
-rwx------  1 mthomas use300      192 Apr 10 20:35 loadRenv.sh
-rw-r--r--  1 mthomas use300      164 Jul 30 11:16 load.singularity.notebook.sh
drwx------  3 mthomas use300        3 Jun 12 20:11 .local
drwxr-xr-x 57 mthomas use300       58 Jul 31 16:40 miniconda3
-rw-r--r--  1 mthomas use300 75257002 Jul 29 07:25 Miniconda3-latest-Linux-x86_64.sh
drwx------  4 mthomas use300        4 Jan  7  2019 .mozilla
-rw-------  1 mthomas use300      517 Jul  6  2017 .ncviewrc
drwx------  3 mthomas use300        3 Aug  6  2018 .nv
drwxr-xr-x  5 mthomas use300        7 Aug 19 22:31 nvidia-dli-2019
-rw-r--r--  1 mthomas use300     1017 Jul  6  2017 .petscconfig
drwxr-----  3 mthomas use300        3 Aug  6  2018 .pki
-rw-r--r--  1 mthomas use300      180 Sep 18  2018 .profile
drwx------  2 mthomas use300        3 Jan  7  2019 .pulse
-rw-------  1 mthomas use300      256 Jan  7  2019 .pulse-cookie
drwxr-xr-x  4 mthomas use300       28 Jul 11 12:25 PythonSeries
drwxr-xr-x  2 mthomas use300        3 Jun 26 11:16 rehs
drwxr-xr-x  3 mthomas use300        3 Aug  7  2018 .rstudio-desktop
drwxr-xr-x 23 mthomas use300       24 Aug  7  2018 sdsc-summer-institute-2018
drwxr-xr-x  4 mthomas use300        4 Aug  7  2018 si18-perf
drwxr-xr-x  4 mthomas use300        4 Jul 11 15:12 .singularity
drwxr-x---  2 mthomas use300        2 Jul  5  2017 .slurm
drwx------  3 mthomas use300       10 Jul 11 14:47 .ssh
drwxr-xr-x  2 mthomas use300        5 Jul 17  2018 testchown
drwxr-xr-x  2 mthomas use300        4 Jul 17  2018 testdir
drwxr-xr-x  2 mthomas use300        2 Aug  6  2018 testgit
drwxr-xr-x  2 mthomas use300        5 Jul  9 15:01 tools
-rw-------  1 mthomas use300     9188 Aug 19 17:39 .viminfo
-rw-r--r--  1 mthomas use300       41 Jun 27  2017 .vimrc
drwxr-xr-x  2 mthomas use300        3 Jun 10 12:17 visitdev
-rw-------  1 mthomas use300     7805 Jun 11 10:13 .Xauthority
(base) [mthomas@comet-ln3:~] cd nvidia-dli-2019/day1
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1] ll
total 77
drwxr-xr-x 4 mthomas use300  5 Aug 19 22:31 .
drwxr-xr-x 5 mthomas use300  7 Aug 19 22:31 ..
drwxr-xr-x 5 mthomas use300  8 Aug 19 22:31 comet_access
drwxr-xr-x 2 mthomas use300 11 Aug 19 22:31 DeepLearningTutorial
-rw-r--r-- 1 mthomas use300 35 Aug 19 22:31 README.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1] cd comet_access/
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 5 mthomas use300     8 Aug 19 22:31 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] mkdir ex
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] cd ex
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] ll ~/cuda/
total 132
drwxr-xr-x  6 mthomas use300  6 Aug 19 17:39 .
drwxr-x--- 43 mthomas use300 95 Aug 19 22:31 ..
drwxr-xr-x  2 mthomas use300  2 Apr 10 17:56 1dstencil
drwxr-xr-x  2 mthomas use300  6 Aug 19 17:41 gpu_enum
drwxr-xr-x  3 mthomas use300  4 Apr 10 18:21 phys244
drwxr-xr-x  2 mthomas use300  7 Aug 19 17:41 simple_hello
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] cp -R ~/cuda/gpu_enum .
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] ll
total 20
drwxr-xr-x 3 mthomas use300 3 Aug 19 22:35 .
drwxr-xr-x 6 mthomas use300 9 Aug 19 22:34 ..
drwxr-xr-x 2 mthomas use300 6 Aug 19 22:35 gpu_enum
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] cp -R ~/cuda/simple_hello/ .
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] ll
total 39
drwxr-xr-x 4 mthomas use300 4 Aug 19 22:35 .
drwxr-xr-x 6 mthomas use300 9 Aug 19 22:34 ..
drwxr-xr-x 2 mthomas use300 6 Aug 19 22:35 gpu_enum
drwxr-xr-x 2 mthomas use300 7 Aug 19 22:35 simple_hello
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] cd gpu_enum/
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex/gpu_enum] ll
total 305
drwxr-xr-x 2 mthomas use300      6 Aug 19 22:35 .
drwxr-xr-x 4 mthomas use300      4 Aug 19 22:35 ..
-rwxr-xr-x 1 mthomas use300 517640 Aug 19 22:35 gpu_enum
-rw-r--r-- 1 mthomas use300   1201 Aug 19 22:35 gpu_enum.22532472.comet-33-06.out
-rw-r--r-- 1 mthomas use300   1813 Aug 19 22:35 gpu_enum.cu
-rw-r--r-- 1 mthomas use300    375 Aug 19 22:35 gpu_enum.sb
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex/gpu_enum] cd ..
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] ll simple_hello/
total 314
drwxr-xr-x 2 mthomas use300      7 Aug 19 22:35 .
drwxr-xr-x 4 mthomas use300      4 Aug 19 22:35 ..
-rwxr-xr-x 1 mthomas use300 516216 Aug 19 22:35 simple_hello
-rw-r--r-- 1 mthomas use300    184 Aug 19 22:35 simple_hello.22532827.comet-33-06.out
-rw-r--r-- 1 mthomas use300    306 Aug 19 22:35 simple_hello.cu
-rw-r--r-- 1 mthomas use300    245 Aug 19 22:35 simple_hello_kernel.cu
-rw-r--r-- 1 mthomas use300    519 Aug 19 22:35 simple_hello.sb
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access/ex] cd ..
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 6 mthomas use300     9 Aug 19 22:34 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 4 mthomas use300     4 Aug 19 22:35 ex
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	ex/

nothing added to commit but untracked files present (use "git add" to track)
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] git add ex
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] git commit -m 'adding cuda example code'
[master fad40fd] adding cuda example code
 9 files changed, 158 insertions(+)
 create mode 100755 day1/comet_access/ex/gpu_enum/gpu_enum
 create mode 100644 day1/comet_access/ex/gpu_enum/gpu_enum.22532472.comet-33-06.out
 create mode 100644 day1/comet_access/ex/gpu_enum/gpu_enum.cu
 create mode 100644 day1/comet_access/ex/gpu_enum/gpu_enum.sb
 create mode 100755 day1/comet_access/ex/simple_hello/simple_hello
 create mode 100644 day1/comet_access/ex/simple_hello/simple_hello.22532827.comet-33-06.out
 create mode 100644 day1/comet_access/ex/simple_hello/simple_hello.cu
 create mode 100644 day1/comet_access/ex/simple_hello/simple_hello.sb
 create mode 100644 day1/comet_access/ex/simple_hello/simple_hello_kernel.cu
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] git push
Counting objects: 16, done.
Delta compression using up to 24 threads.
Compressing objects: 100% (16/16), done.
Writing objects: 100% (16/16), 184.69 KiB | 4.20 MiB/s, done.
Total 16 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 2 local objects.
To github.com:sdsc-hpc-training/nvidia-dli-2019.git
   a05b71e..fad40fd  master -> master
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] git pull
Already up-to-date.
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 6 mthomas use300     9 Aug 19 22:34 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 4 mthomas use300     4 Aug 19 22:35 ex
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll getting_started/
total 67
drwxr-xr-x 3 mthomas use300    6 Aug 19 22:31 .
drwxr-xr-x 6 mthomas use300    9 Aug 19 22:34 ..
-rw-r--r-- 1 mthomas use300  261 Aug 19 22:31 comet_user_guide.md
drwxr-xr-x 2 mthomas use300    4 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300 6311 Aug 19 22:31 logging_onto_comet.md
-rw-r--r-- 1 mthomas use300 1009 Aug 19 22:31 using_github.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] cat getting_started/comet_user_guide.md 
# Accessing HPC Systems:  Comet User Guide

Please read the Comet user guide and familiarize yourself with the hardware, file systems, batch job submission, compilers and modules. The guide can be found here:

http://www.sdsc.edu/support/user_guides/comet.html
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 6 mthomas use300     9 Aug 19 22:34 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 4 mthomas use300     4 Aug 19 22:35 ex
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll ..
total 77
drwxr-xr-x 4 mthomas use300  5 Aug 19 22:31 .
drwxr-xr-x 5 mthomas use300  7 Aug 19 22:31 ..
drwxr-xr-x 6 mthomas use300  9 Aug 19 22:34 comet_access
drwxr-xr-x 2 mthomas use300 11 Aug 19 22:31 DeepLearningTutorial
-rw-r--r-- 1 mthomas use300 35 Aug 19 22:31 README.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ls ../..
total 141
drwxr-xr-x  5 mthomas use300    7 Aug 19 22:31 .
drwxr-x--- 43 mthomas use300   95 Aug 19 22:31 ..
drwxr-xr-x  4 mthomas use300    5 Aug 19 22:31 day1
drwxr-xr-x  2 mthomas use300    3 Aug 19 22:31 day2
drwxr-xr-x  8 mthomas use300   16 Aug 19 22:36 .git
-rw-r--r--  1 mthomas use300   10 Aug 19 22:31 .gitignore
-rw-r--r--  1 mthomas use300 1198 Aug 19 22:31 README.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] vi ../../.gitignore 
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 6 mthomas use300     9 Aug 19 22:34 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 4 mthomas use300     4 Aug 19 22:35 ex
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] ll
total 124
drwxr-xr-x 6 mthomas use300     9 Aug 19 22:34 .
drwxr-xr-x 4 mthomas use300     5 Aug 19 22:31 ..
drwxr-xr-x 2 mthomas use300     4 Aug 19 22:31 basic_linux_skills
drwxr-xr-x 4 mthomas use300     4 Aug 19 22:35 ex
drwxr-xr-x 3 mthomas use300     6 Aug 19 22:31 getting_started
drwxr-xr-x 2 mthomas use300    12 Aug 19 22:31 images
-rw-r--r-- 1 mthomas use300  2331 Aug 19 22:31 README.md
-rw-r--r-- 1 mthomas use300 73262 Aug 19 22:31 running_gpu_jobs_on_comet.md
-rw-r--r-- 1 mthomas use300  3724 Aug 19 22:31 software_requirements.md
(base) [mthomas@comet-ln3:~/nvidia-dli-2019/day1/comet_access] cd
(base) [mthomas@comet-ln3:~] cd cuda/
(base) [mthomas@comet-ln3:~/cuda] ll
total 132
drwxr-xr-x  6 mthomas use300  6 Aug 19 17:39 .
drwxr-x--- 43 mthomas use300 95 Aug 19 22:42 ..
drwxr-xr-x  2 mthomas use300  2 Apr 10 17:56 1dstencil
drwxr-xr-x  2 mthomas use300  6 Aug 19 17:41 gpu_enum
drwxr-xr-x  3 mthomas use300  4 Apr 10 18:21 phys244
drwxr-xr-x  2 mthomas use300  7 Aug 19 17:41 simple_hello
(base) [mthomas@comet-ln3:~/cuda] cd simple_hello/
(base) [mthomas@comet-ln3:~/cuda/simple_hello] ll
total 333
drwxr-xr-x 2 mthomas use300      7 Aug 19 17:41 .
drwxr-xr-x 6 mthomas use300      6 Aug 19 17:39 ..
-rwxr-xr-x 1 mthomas use300 516216 Aug 19 17:40 simple_hello
-rw-r--r-- 1 mthomas use300    184 Apr 11 00:09 simple_hello.22532827.comet-33-06.out
-rw-r--r-- 1 mthomas use300    306 Aug 19 17:39 simple_hello.cu
-rw-r--r-- 1 mthomas use300    245 Apr 10 18:29 simple_hello_kernel.cu
-rw-r--r-- 1 mthomas use300    519 Apr 10 23:38 simple_hello.sb
(base) [mthomas@comet-ln3:~/cuda/simple_hello] ./simple_hello 
Hello, NVIDIA DLI Workshop! You have 0 devices
(base) [mthomas@comet-ln3:~/cuda/simple_hello] history
    1  ./chk.login.sh 
    2  cat students_active.out
    3  cat students_active.out|wc
    4  ./chk.login.sh 
    5  cat students_active.out| more
    6   vi students_active.out 
    7  cat students_active.out 
    8  ls /home/yuz530
    9  ls /home/yuz53
   10  ls /home/yuz530/comet-examples/
   11  ls /home/yuz530/comet-examples/PHYS244/
   12  ls /home/yuz530/comet-examples/PHYS244/MPI/
   13  ls /home/yuz530/PARALLEL/
   14  ls /home/yuz530/PARALLEL/OPENMP/
   15  ls /home/yuz530
   16  ls /home/yuz530/gpu-code-examples
   17  ls /home/yuz530/gpu-code-examples/cuda-samples/
   18  cat students_active.out 
   19  ls /home/afmartin
   20  ls /home/afmartin/repos/
   21  ls /home/afmartin
   22  ls /home/afmartin/.jupyter/
   23  ls /home/afmartin
   24  echo $WORK
   25  ls /oasis/scratch/comet/afmartin/
   26  ls /oasis/scratch/comet/afmartin/temp_project/
   27  ls /home/afmartin/repos/
   28  ls /home/afmartin/repos/xsede_stats/
   29  ls /home/afmartin/repos/plotPractice/
   30  ls /home/afmartin/repos/plotPractice/WeatherPy
   31  ll
   32  vi all_students.txt 
   33  grep danelson *.out
   34  finger danelson
   35  finger ajwu
   36  ls /home/ajwu
   37  finger wxy0129
   38  yuz796 (yuqiko11)
   39  finger quz796
   40  finger yuz796
   41  finger yuqiko11
   42  finger yuz796
   43  ls /home/yuz796
   44  ls /home/yuz796/PARALLEL/
   45  ls /home/yuz796/PARALLEL/OPENMP/
   46  ls /home/yuz796/PARALLEL/OPENMP/pi_openmp
   47  /home/yuz796/PARALLEL/OPENMP/pi_openmp
   48  sid=yuz796
   49  echo $WORK
   50  lss="ls -al /oasis/scratch/comet/$sid/temp_project"
   51  lss
   52  alias lss="ls -al /oasis/scratch/comet/$sid/temp_project"
   53  lss
   54  ls /oasis/scratch/comet/$sid/temp_project
   55  ls /oasis/scratch/comet/$sid
   56  ls /oasis/scratch/comet/yuz796/temp_project/
   57  sid=rlt006
   58  ls /home/$sid
   59  ls /home/rlt006/hpc-training/
   60  finger $sid
   61  ls /home/rlt006/hpc-training/*
   62  ls /home/*/hpc-training
   63  ll
   64  grep hwk-chks/
   65  grep hwk-chks *.sh
   66  cat chk.hwk.sh 
   67  rm chk.hwk.sh
   68  ll
   69  cat chk.homedir.sh 
   70  rm chk.homedir.sh 
   71  ll
   72  vi chk.login.sh 
   73  cat all_students.txt 
   74  mv chk.login.sh chk.accounts.sh
   75  ./chk.accounts.sh 
   76  ll
   77  cat active_accounts.txt 
   78  ./chk.tree.sh 
   79  ll
   80  grep IFS *.sh
   81  cat chk.accounts.sh 
   82  mkdir tree-dir
   83  ll
   84  ./chk.tree.sh 
   85  ll
   86  ll tree-dir/
   87  ./chk.tree.sh 
   88  ll
   89  ./chk.tree.sh 
   90  ll tree-dir/
   91  cat chk.accounts.sh 
   92  ./chk.tree.sh 
   93  ll
   94  ./chk.tree.sh 
   95  ll tree-dir/
   96  ll tree-dir/yuz796.tree.out 
   97  cat tree-dir/yuz796.tree.out 
   98  ./chk.tree.sh 
   99  cat tree-dir/yuz796.tree.out 
  100  grep cnt *.sh
  101  ./chk.tree.sh 
  102  cat tree-dir/yuz796.tree.out 
  103  ./chk.tree.sh 
  104  cat tree-dir/yuz796.tree.out 
  105  ll tree-dir/
  106  ll tree-dir/rchancha.tree.out 
  107  cat tree-dir/rchancha.tree.out 
  108  ./chk.tree.sh 
  109  cat tree-dir/rchancha.tree.out 
  110  ls /home/rchancha/
  111  ls /home | grep rchancha
  112  ls /home | grep mthomas
  113  ls /home | grep  wxy0129
  114  groups
  115  ls /home/rchancha/
  116  ls /home/cseitz
  117  history | grep oasis
  118  ls /oasis/scratch/comet/cseitz/
  119  ls /oasis/scratch/comet/cseitz/temp_project/
  120  groups cseitz
  121  groups
  122  ls /oasis/scratch/comet/cseitz
  123  ls /oasis/scratch/comet/cseitz/temp_project/
  124  ls /oasis/scratch/comet/cseitz/temp_project/homework
  125  ll /home/mapodaca
  126  ll /home/mapodaca/homework/
  127  ll /home/mapodaca/homework/week8/
  128  ll /home/mapodaca/homework/week*
  129  ll /home/mapodaca/
  130  ll /home/mapodaca/src
  131  ll /home/mapodaca/src/hpc-training-spring2019/
  132  ll /home/mapodaca/src/hpc-training-spring2019/wk9-05-31-19/
  133  ll /home/mapodaca/homework/week*
  134  ll /home/mapodaca/homework/week5/
  135  ll /home/mapodaca/homework/week5/gpu-code-examples
  136  ll /home/mapodaca/homework/week5/gpu-code-examples/cuda-samples/
  137  ll /home/kwc034/
  138  ll /home/kwc034/hpc-training/
  139  ll /home/kwc034/hpc-training/week*
  140  ll /home/kwc034/hpc-training/week5
  141  ll /home/kwc034/hpc-training/week5/gpu-code-examples/
  142  ll /home/kwc034/hpc-training/week5/gpu-code-examples/README.md 
  143  cat /home/kwc034/hpc-training/week5/gpu-code-examples/README.md 
  144  cat /home/kwc034/hpc-training/week5/
  145  ll /home/kwc034/hpc-training/week5/
  146  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/
  147  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/README 
  148  cat /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/README 
  149  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/README 
  150  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/
  151  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/addition/
  152  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/addition/exercise/
  153  ll /home/kwc034/hpc-training/week6
  154  ll /home/kwc034/hpc-training/week6/hpc.mpi/
  155  ll /home/kwc034/hpc-training/week6/hpc.mpi/hello-mpi.24067214.comet-14-02.out 
  156  cat /home/kwc034/hpc-training/week6/hpc.mpi/hello-mpi.24067214.comet-14-02.out 
  157  ll /home/kwc034/hpc-training/week7
  158  ll /home/kwc034/hpc-training/week8
  159  ll /home/kwc034/hpc-training/week9
  160  ll /home/kwc034/hpc-training/week9/SI2018_effective_use/
  161  ll /home/kwc034/hpc-training/week9/SI2018_effective_use/thread_scaling.out 
  162  cat /home/kwc034/hpc-training/week9/SI2018_effective_use/thread_scaling.out 
  163  cat /home/kwc034/hpc-training/week9/SI2018_effective_use/gmon.out 
  164  cat /home/kwc034/hpc-training/week9/SI2018_effective_use/lineq.out 
  165  cat /home/kwc034/hpc-training/week10
  166  ll /home/kwc034/hpc-training/week10
  167  ll /home/kwc034/hpc-training/week10/PythonSeries/
  168  ll /home/mapodaca/
  169  ll /home/mapodaca/week*
  170  ll /home/mapodaca/homework/
  171  ll /home/mapodaca/homework/week*
  172  ll /home/mapodaca/homework/week5/gpu-code-examples
  173  ll /home/mapodaca/homework/week5/gpu-code-examples/cuda-samples/
  174  ll /home/mapodaca/homework/week5/gpu-code-examples/cuda-samples/addition/
  175  ll /home/mapodaca/homework/week5/gpu-code-examples/cuda-samples/addition//exercise/
  176  ll /home/mapodaca/homework/week*
  177  ll /home/mapodaca/homework/week5
  178  ll /home/mapodaca/homework/week5/gpu-code-examples
  179  ll /home/mapodaca/homework/week5/gpu-code-examples/openacc-samples/
  180  ll /home/mapodaca/homework/week5/gpu-code-examples/openacc-samples/saxpy/
  181  ll /home/mapodaca/homework/week5/gpu-code-examples/openacc-samples/laplace-2d/
  182  ll /home/mapodaca/homework/week6
  183  ll /home/mapodaca/homework/week4
  184  ll /home/mapodaca/homework/week4/hw 
  185  ll /home/mapodaca/homework/week4/
  186  ll /home/mapodaca/homework/week4/helloWorld/
  187  ll /home/mapodaca/homework/week4/helloWorld/paralle.22977109.comet-14-01.out 
  188  cat /home/mapodaca/homework/week4/helloWorld/paralle.22977109.comet-14-01.out 
  189  cat /home/mapodaca/homework/week4/helloWorld/hello.22976922.comet-14-03.out 
  190  ll /home/mapodaca/homework/week6
  191  ll /home/mapodaca/homework/week6/OpenMPBenchmark.23847387.comet-14-05.out
  192  cat /home/mapodaca/homework/week6/OpenMPBenchmark.23847387.comet-14-05.out
  193  cat /home/mapodaca/homework/week6/OpenMPBenchmark.23841233.comet-14-06.out
  194  ll /home/mapodaca/homework/week7
  195  ll /home/mapodaca/homework/week8
  196  ll /home/mapodaca/homework/week9
  197  ll /home/mapodaca/homework
  198  ll /home/mapodaca
  199  ll /home/mapodaca/questions.txt 
  200  cat /home/mapodaca/questions.txt 
  201  ll /home/mapodaca/src/
  202  ll /home/mapodaca/src/lgrep 
  203  grep jcampos *.*
  204  ls  /home/jcamposg 
  205  ls  /home/jcamposg/hpc-training/
  206  ls  /home/jcamposg/hpc-training/week3/
  207  ls  /home/jcamposg/hpc-training/
  208  ls  /home/jcamposg/hpc-training/NVIDIA_CUDA-7.0_Samples/
  209  sid=jcamposg
  210  history | grep oasis
  211  lss
  212  ls /oasis/scratch/comet/$sid/temp_project
  213  ls /oasis/scratch/comet/jcamposg/temp_project
  214  ls /oasis/scratch/comet/jcampos
  215  ls /oasis/scratch/comet/jcamposg
  216  ls  /home/jcamposg/
  217  ls  /home/jcamposg/ | grep -v java
  218  ls  /home/jcamposg/ | grep -v java|grep -v error
  219  ls  /home/jcamposg/comet-examples/
  220  ls  /home/jcamposg/comet-examples/PHYS244/
  221  ls  /home/jcamposg/comet-examples/PHYS244/MPI
  222  ls  /home/jcamposg/comet-examples/PHYS244/MPI/IBRUN/
  223  sid=jacobli
  224  ls /home/$sid
  225  ls /oasis/scratch/comet/$sid/temp_project
  226  ls /home/jacobli
  227  ls /home/jacobli/homework/
  228  ls /home/jacobli/homework/*
  229  ls /home/jacobli
  230  ls /home/jacobli/comet-examples/
  231  ls /home/jacobli/comet-examples/PHYS244/
  232  ls /home/jacobli/comet-examples/PHYS244/MPI/
  233  ls /home/jacobli/comet-examples/PHYS244/MPI/IBRUN/
  234  ls /home/jacobli/comet-examples/PHYS244/MPI/MPIRUN_RSH/
  235  ls /home/jacobli/comet-examples/PHYS244/
  236  ls /home/jacobli/comet-examples/PHYS244/OPENMP/
  237  ls /home/jacobli/comet-examples/PHYS244/*/*.out
  238  ls /home/jacobli/wk5
  239  ls /home/jacobli/wk5/gpu-code-examples
  240  ls /home/jacobli/wk5/gpu-code-examples/*
  241  ls /home/jacobli/wk5/gpu-code-examples/openacc-samples/laplace-2d/
  242  ls /home/jacobli/wk5/gpu-code-examples/openacc-samples/saxpy/
  243  ls /home/jacobli/wk5/gpu-code-examples/
  244  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/
  245  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/addition/
  246  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/addition/exercise/
  247  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/hello_world/
  248  ls /home/jacobli/wk5
  249  ls /home/jacobli/wk5/gpu-code-examples
  250  ls /home/jacobli/wk5/gpu-code-examples/*
  251  ls /home/jacobli/wk5/gpu-code-examples/*/* | more
  252  ls /home/jacobli/wk5/gpu-code-examples/*/*/* | more
  253  ls /home/jacobli/wk5/gpu-code-examples/*/*/*/* | more
  254  ls /home/jacobli/wk5/gpu-code-examples/*/*/*/*/* | more
  255  ls /home/jacobli/
  256  ls /home/jacobli/PARALLEL/
  257  ls /home/jacobli/PARALLEL/OPENMP/
  258  ls /home/jacobli/PARALLEL/SIMPLE/
  259  ls /home/jacobli/PARALLEL/SIMPLE/pi_mpi.18444874.comet-10-72.out 
  260  cat /home/jacobli/PARALLEL/SIMPLE/pi_mpi.18444874.comet-10-72.out 
  261  ls /home/jacobli/PARALLEL/SIMPLE/
  262  ls /home/jacobli/PARALLEL/
  263  ls /home/jacobli/
  264  ls /home/jacobli/workdir/
  265  ls /home/jacobli/my-code/
  266  ls /home/jacobli/my-code/MT_Factors/
  267  ls /home/jacobli/laplace-2d/
  268  ll
  269  ls /home/jacobli/
  270  ls /home/jacobli/NVIDIA_CUDA-7.0_Samples/
  271  ls /home/jacobli/NVIDIA_CUDA-7.0_Samples/0_Simple/
  272  ls /home/jacobli/NVIDIA_CUDA-7.0_Samples/0_Simple/*
  273  ls /home/jacobli/
  274  ls /home/jacobli/hpc-training-spring2019-master/
  275  ls /home/jacobli/hpc-training-spring2019-master/homework/
  276  ls /home/jacobli/homework/
  277  ls /home/jacobli/
  278  ls /home/jacobli/comet-examples/
  279  ls /home/jacobli/comet-examples/PHYS244/
  280  ls /home/jacobli/comet-examples/PHYS244/CUDA/
  281  ls /home/jacobli/comet-examples/PHYS244/CUDA/CUDA.8718375.comet-30-08.out 
  282  cat /home/jacobli/comet-examples/PHYS244/CUDA/CUDA.8718375.comet-30-08.out 
  283  ls /home/jacobli
  284  ls /home/jacobli/workdir/
  285  ls /home/jacobli
  286  echo $work
  287  echo $WORK
  288  ls /oasis/scratch/comet/jacobli/
  289  ls /oasis/scratch/comet/jacobli/temp_project/
  290  ll /home/dtyoung/
  291  ll /home/dtyoung/homework/
  292  ll /home/dtyoung/homework/week*
  293  ll /home/dtyoung/homework/week9/submission.txt 
  294  cat /home/dtyoung/homework/week9/submission.txt 
  295  ll /home/dtyoung/homework/week*
  296  ll /home/dtyoung/homework/week6/hpc.mpi/
  297  ll /home/dtyoung/homework/week5/gpu-code-examples
  298  ll /home/dtyoung/homework/week5/gpu-code-examples/*
  299  ll /home/dtyoung/homework/week5/gpu-code-examples/*/*
  300  ll /home/dtyoung/homework/week5/gpu-code-examples/*/*/*
  301  cat /home/dtyoung/homework/week5/gpu-code-examples/cuda-samples/hello_world/
  302  cat /home/dtyoung/homework/week5/gpu-code-examples/cuda-samples/hello_world/a.out|more
  303  cat /home/dtyoung/homework/week5/gpu-code-examples/openacc-samples/laplace-2d/README
  304  ll /home/dtyoung/homework/week5/gpu-code-examples/*/*/*
  305  ll /home/dtyoung/homework/week5/gpu-code-examples/*/*/*/*
  306  ll /home/dtyoung/homework/week5/gpu-code-examples/*/*/*/*/*
  307  ll /home/dtyoung/homework/week4
  308  ll /home/dtyoung/homework/week3
  309  ll /home/dtyoung/homework/week3/*
  310  ll /home/dtyoung/homework/week6
  311  ll /home/dtyoung/homework/week6/hpc.mpi/
  312  ll /home/dtyoung/homework/week7
  313  ll /home/dtyoung/homework/week8
  314  ll /home/dtyoung/homework/week9
  315  ll /home/kwc034/
  316  ll /home/kwc034/hpc-training/
  317  ll /home/kwc034/hpc-training/week5/
  318  ll /home/kwc034/hpc-training/week5/*
  319  ll /home/kwc034/hpc-training/week5/*/*
  320  ll /home/kwc034/hpc-training/week5/*/*/*
  321  ll /home/kwc034/hpc-training/week5/*/*/*/*
  322  ll /home/kwc034/hpc-training/week5/* | grep "example.x"
  323  ll /home/kwc034/hpc-training/week5/*/* | grep "example.x"
  324  ll /home/kwc034/hpc-training/week5/*/*/* | grep "example.x"
  325  ll /home/kwc034/hpc-training/week5/*/*/*/* | grep "example.x"
  326  ll /home/kwc034/hpc-training/week5/*/*/*/*/* | grep "example.x"
  327  ll /home/kwc034/hpc-training/week5/
  328  ll /home/kwc034/hpc-training/week5/cuda-examples/
  329  ll /home/kwc034/hpc-training/week5/cuda-examples/NVIDIA_CUDA-7.0_Samples/
  330  ll /home/kwc034/hpc-training/week5/cuda-examples/
  331  ll /home/kwc034/hpc-training/week5/gpu-code-examples/
  332  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/
  333  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*
  334  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/example.cu 
  335  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/example.cu 
  336  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*/example.cu 
  337  ll /home/kwc034/hpc-training/week5/gpu-code-examples/
  338  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/
  339  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*
  340  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/*
  341  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*
  342  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*/*
  343  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/*
  344  ll /home/kwc034/hpc-training/week5/gpu-code-examples/cuda-samples/hello_world/
  345  sid=bryantc
  346  ls /home/bryantc
  347  ls /home/bryantc/hpc-training
  348  ls /home/bryantc/hpc-training-spring2019/
  349  ls /home/bryantc/hpc-training-spring2019/homework/
  350  ls /home/bryantc/hpc-training
  351  ls /home/bryantc
  352  ls /home/bryantc/hpc-training
  353  ls /home/bryantc/hpc-training/week*
  354  ls /home/bryantc/hpc-training/week3/PHYS244/
  355  ls /home/bryantc/hpc-training/week3/PHYS244/MPI/
  356  ls /home/bryantc/hpc-training/week3/PHYS244/*/*.out
  357  ls /home/bryantc/hpc-training/week*
  358  ls /home/bryantc/hpc-training/week6/hpc.mpi/
  359  ls /home/bryantc/hpc-training/week*
  360  ls /home/bryantc/hpc-training/week5/gpu-code-examples
  361  ls /home/bryantc/hpc-training/week5/gpu-code-examples/gpuget 
  362  lk /home/bryantc/hpc-training/week5/gpu-code-examples/gpuget 
  363  ll /home/bryantc/hpc-training/week5/gpu-code-examples/gpuget 
  364  cat /home/bryantc/hpc-training/week5/gpu-code-examples/gpuget 
  365  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/
  366  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*
  367  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*/*
  368  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*
  369  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*/*
  370  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*
  371  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*/*
  372  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*
  373  ll /home/bryantc/hpc-training/week5/gpu-code-examples/cuda-samples/*l
  374  ll /oasis/scratch/bryantc/
  375  echo $WORK
  376  ll /oasis/scratch/comet/bryantc/
  377  ll /oasis/scratch/comet/bryantc/temp_project/
  378  ll /oasis/scratch/comet/bryantc/temp_project/hwks/
  379  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/
  380  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples
  381  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/openacc-samples/
  382  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/openacc-samples/*
  383  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/openacc-samples/*/*
  384  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/openacc-samples/*/*/*
  385  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/openacc-samples/*/*
  386  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/cuda-samples/
  387  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/cuda-samples/*
  388  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/cuda-samples/*/*
  389  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/cuda-samples/*/*/*
  390  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week5/gpu-code-examples/cuda-samples/*/*/*/*
  391  ll /oasis/scratch/comet/bryantc/temp_project/hwks/
  392  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week8
  393  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week9
  394  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week10
  395  ll /oasis/scratch/comet/bryantc/temp_project/hwks/week7
  396  ls /home/jacobli/
  397  ls /home/jacobli/homework/
  398  ls /home/jacobli/homework/week7
  399  ls /home/jacobli/homework/week8
  400  ls /home/jacobli/homework
  401  ls /home/jacobli
  402  ls /home/jacobli/workdir/
  403  ls /home/jacobli/
  404  ls /home/jacobli/PARALLEL/
  405  ls /home/jacobli/PARALLEL/OPENMP/
  406  ls /home/jacobli/PARALLEL/
  407  ls /home/jacobli/
  408  ls /home/jacobli/comet-examples/
  409  ls /home/jacobli/comet-examples/PHYS244/
  410  ls /home/jacobli/
  411  ls /home/jacobli/wk5
  412  ls /home/jacobli/wk5/gpu-code-examples
  413  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/
  414  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/square_array/
  415  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/square_array/exercise/
  416  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/*
  417  ls /home/jacobli/wk5/gpu-code-examples/cuda-samples/*/*
  418  ls /oasis/
  419  ls /oasis/scratch/comet/jacobli/
  420  ls /oasis/scratch/comet/jacobli/temp_project/
  421  ls /home/jacobli
  422  ls /home/jacobli/homework/
  423  ls /home/jacobli/homework/week8
  424  ls /home/jacobli/homework/week7
  425  ls /home/jacobli/homework/week6
  426  ls /home/jacobli/homework/week5
  427  ls /home/jacobli/
  428  ls /home/jacobli/workdir/
  429  ls /home/jacobli/my-code/
  430  ls /home/jacobli/my-code/intro-mpi/
  431  ls /home/jacobli/sp 
  432  cat /home/jacobli/sp 
  433  ls /export
  434  ll
  435  cat /home/jacobli/
  436  ll /home/jacobli
  437  ll /home/jacobli/.nv/
  438  ll /home/jacobli/my-code/
  439  ll /home/jacobli/my-code/MT_Factors/
  440  ll /home/jacobli/my-code/intro-mpi/
  441  ll /home/jacobli/intel/
  442  ll /home/jacobli/intel/ism/
  443  ll /home/jacobli/intel/ism/rm/
  444  ll /home/jacobli/finger 
  445  finger jacobli
  446  /oasis/scratch/comet/brhatton/temp_project/homework 
  447  ls /oasis/scratch/comet/brhatton/temp_project/homework 
  448  ls /oasis/scratch/comet/brhatton/temp_project/homework/week*
  449  ls /oasis/scratch/comet/brhatton/temp_project/homework/week2/testdir/
  450  ls /oasis/scratch/comet/brhatton/temp_project/homework/week2/
  451  ls /oasis/scratch/comet/brhatton/temp_project/homework/week2/README.txt 
  452  cat /oasis/scratch/comet/brhatton/temp_project/homework/week2/README.txt 
  453  cat /oasis/scratch/comet/brhatton/temp_project/homework/week2/comet-examples/
  454  ls /home/tic173
  455  ls /home/tic173/comet-examples/
  456  ls /home/tic173/comet-examples/OPENMP
  457  ls /home/tic173/comet-examples/
  458  ls /home/tic173/
  459  ls /home/tic173/intel/
  460  ls /home/tic173/testdir/
  461  ls /oasis/scratch/comet/tic173
  462  ls /oasis/scratch/comet/tic173/temp_project/
  463  ll /home/tkahn
  464  ll /home/tkhan
  465  ll /oasis/scratch/comet/tkhan
  466  ll /oasis/scratch/comet/tkhan/
  467  ll /oasis/scratch/comet/tkhan/temp_project/hwks/
  468  ll /oasis/scratch/comet/tkhan/temp_project/
  469  ll /oasis/scratch/comet/tkhan/temp_project/hwks/
  470  ll /home/tkhan
  471  ll /home/tkhan/PARALLEL/
  472  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/
  473  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/
  474  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/
  475  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/profile_gp 
  476  cat /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/profile_gp 
  477  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/
  478  cat /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/profile_lineq 
  479  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/
  480  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/lineq.c 
  481  cat /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/lineq.c 
  482  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/
  483  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/
  484  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week9/SI2018_effective_use/
  485  ll /oasis/scratch/comet/wxy0129/temp_project/hwks/week8
  486  ls /y1gao
  487  ls /home/y1gao
  488  ls /home/y1gao/hpc-tasks/
  489  ls /home/y1gao/hpc-tasks/week10/
  490  ls /home/y1gao/hpc-tasks/week10/*
  491  ls /home/y1gao/hpc-tasks/week10/
  492  ls /home/y1gao/hpc-tasks/week10/ML_Tensorflow/
  493  ls /home/y1gao/hpc-tasks/week10/PythonSeries/
  494  ls /home/y1gao/hpc-tasks/week9
  495  ls /home/y1gao/hpc-tasks/week9/SI2018_effective_use/
  496  ls /home/y1gao/hpc-tasks/week8
  497  ls /home/y1gao/hpc-tasks
  498  ls /home/y1gao/hpc-tasks/week6
  499  ls /home/y1gao/hpc-tasks/week6/hello-cpuid.24195344.comet-14-01.out
  500  cat /home/y1gao/hpc-tasks/week6/hello-cpuid.24195344.comet-14-01.out
  501  ls /home/y1gao/hpc-tasks/week6
  502  ls /home/y1gao/hpc-tasks/week5
  503  ls /home/y1gao/hpc-tasks/
  504  ls /home/y1gao/hpc-tasks/w6
  505  ls /home/y1gao/hpc-tasks/week66
  506  ls /home/y1gao/hpc-tasks/week6
  507  ls /home/y1gao/hpc-tasks/week4
  508  ls /home/y1gao/hpc-tasks/week4/a.24194974.comet-06-57.out 
  509  cat /home/y1gao/hpc-tasks/week4/a.24194974.comet-06-57.out 
  510  ls /home/y1gao/hpc-tasks/week3
  511  ls /home/y1gao/hpc-tasks/week5
  512  ls /home/yih307
  513  ls /home/yih307/PARALLEL/
  514  ls /home/yih307/PARALLEL/*
  515  ls /home/yih307
  516  ls /home/yuz530
  517  ls /home/yuz530/comet-examples/
  518  ls /home/yuz530/comet-examples/PHYS244/
  519  ls /home/yuz530/comet-examples/PHYS244/MPI/
  520  ls /home/yuz530/comet-examples/PHYS244/MPI/*
  521  ls /home/yuz530/comet-examples/PHYS244/
  522  ls /home/yuz530/comet-examples/PHYS244/OPENMP/
  523  ls /home/yuz530/comet-examples/PHYS244/OPENMP/hello_openmp.22961725.comet-23-32.out
  524  cat /home/yuz530/comet-examples/PHYS244/OPENMP/hello_openmp.22961725.comet-23-32.out
  525  ll
  526  ls /home/yuz530/comet-examples/PHYS244/OPENMP/
  527  ls /home/yuz530/comet-examples/PHYS244/
  528  ls /home/yuz530/comet-examples/PHYS244/CUDA/
  529  ls /home/yuz530/comet-examples/PHYS244/CUDA/CUDA.8718375.comet-30-08.out
  530  cat /home/yuz530/comet-examples/PHYS244/CUDA/CUDA.8718375.comet-30-08.out
  531  ls /home/yuz530/comet-examples/PHYS244/CUDA/
  532  ls /home/yuz530/comet-examples/PHYS244/
  533  ls /home/yuz530/
  534  ls /home/yuz530/PARALLEL/
  535  ls /home/yuz530/PARALLEL/OPENMP/
  536  ls /home/yuz530/cuda/
  537  ls /home/yuz530/cuda/gpu_enum/
  538  ls /home/yuz530/cuda/gpu_enum/gpu_enum.22961908.comet-33-05.out
  539  cat /home/yuz530/cuda/gpu_enum/gpu_enum.22961908.comet-33-05.out
  540  ls /home/yuz530/cuda/gpu_enum/
  541  ls /home/yuz530/cuda/
  542  ls /home/yuz530/cuda/simple_hello/
  543  cat  /home/yuz530/cuda/simple_hello/simple_hello.22961900.comet-33-04.out 
  544  cat  /home/yuz530/
  545  ll  /home/yuz530/
  546  ll  /home/yuz530/gpu-code-examples
  547  ll  /home/yuz530/gpu-code-examples/cuda-samples/
  548  ll  /home/yuz530/gpu-code-examples/cuda-samples/*
  549  ll  /home/yuz530/gpu-code-examples/cuda-samples/*/*
  550  ll  /home/yuz530/
  551  ll  /oasis/scratch/comet/yuz530/
  552  ll  /oasis/scratch/comet/yuz530/temp_project/
  553  ls /home/yupan
  554  ls /home/yupan/
  555  ls /home/yupan/homework/
  556  ls /home/yupan/homework/hw3
  557  ls /home/yupan/homework/hw3/comet-examples/
  558  ls /home/yupan/homework/hw3/comet-examples/PHYS244/
  559  ls /home/yupan/homework/hw3/comet-examples/PHYS244/MKL
  560  ls /home/yupan/homework/hw4
  561  ls /home/yupan/homework
  562  ls /home/yupan/homework/hw4
  563  ls /home/yupan/homework/hw3/comet-examples/PHYS244/
  564  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OPENMP/
  565  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/
  566  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/OpenACC.8718094.comet-30-11.out 
  567  cat /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/OpenACC.8718094.comet-30-11.out 
  568  ls /home/yupan/homework/hw3/comet-examples/PHYS244/
  569  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OPENMP/
  570  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/
  571  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/README.txt 
  572  cat /home/yupan/homework/hw3/comet-examples/PHYS244/OpenACC/README.txt 
  573  cat /home/yupan/homework/hw3/comet-examples/PHYS244/OPENMP/
  574  ls /home/yupan/homework/hw3/comet-examples/PHYS244/OPENMP/
  575  ls /home/yupan/homework/hw5
  576  ls /home/yupan/
  577  ls /home/yupan/comet-examples/
  578  ls /home/yupan/comet-examples/PHYS244/
  579  ls /home/yupan/comet-examples/PHYS244/OPENMP/
  580  ls /home/yupan/comet-examples/PHYS244/MKL
  581  ls /home/yupan/comet-examples/PHYS244/MKL/compile.txt 
  582  cat /home/yupan/comet-examples/PHYS244/MKL/compile.txt 
  583  cat /home/yupan/comet-examples/PHYS244/MKL/pdpttr.c
  584  ll
  585  grep -ni pragma /home/yupan/comet-examples/PHYS244/*
  586  grep -ni pragma /home/yupan/comet-examples/PHYS244/*/*
  587  grep -ni pragma /home/yupan/homework/wk10
  588  grep -ni pragma /home/yupan/homework/
  589  ls /home/yupan/homework/
  590  ls /home/yupan/homework/hw9/
  591  ls /home/yupan/homework/hw9/SI2018_effective_use/
  592  locate profile_lineq
  593  ls /home/brhatton/
  594  ls /home/brhatton/hpc-training/
  595  ls /home/brhatton/hpc-training/week8
  596  ls /home/brhatton/hpc-training/week9
  597  ls /oasis/scratch/comet/brhatton/temp_project/homework/
  598  ls /oasis/scratch/comet/brhatton/temp_project/homework/week9
  599  ls /oasis/scratch/comet/brhatton/temp_project/homework/week9/SI2018_effective_use/
  600  ls ls /home/yupan/homework/hw9/SI2018_effective_use/
  601  ls ls /home/yupan/homework/hw9/SI2018_effective_use/profile_lineq 
  602  diff -y /oasis/scratch/comet/brhatton/temp_project/homework/week9/SI2018_effective_use/profile_lineq /home/yupan/homework/hw9/SI2018_effective_use/profile_lineq 
  603  ll
  604  ls /home/yupan/homework/hw9/SI2018_effective_use/
  605  ls /home/yupan/homework/hw10
  606  ls /home/yupan/homework/hw10/snapshots*
  607  ls /home/yupan/homework/hw5/
  608  ls /home/yupan/homework/hw5/gpu-code-examples
  609  ls /home/yupan/homework/hw5/gpu-code-examples/cuda-samples/
  610  ls /home/yupan/homework/hw5/gpu-code-examples/cuda-samples/*/
  611  ls /home/yupan/homework/hw5/gpu-code-examples/cuda-samples/square_array/exercise/
  612  ls /home/yupan/homework/hw5/gpu-code-examples/cuda-samples/*/
  613  ls /home/yupan/homework/hw5/gpu-code-examples/cuda-samples/*/*
  614  ls /home/yupan/homework/hw6
  615  ls /home/ischeink
  616  ls /home/ischeink/PARALLEL/
  617  ls /home/ischeink/PARALLEL/OPENMP/
  618  ls /home/ischeink/PARALLEL/*
  619  ls /home/ischeink/PARALLEL/
  620  ls /home/ischeink/PARALLEL/SIMPLE/
  621  ls /home/ischeink/PARALLEL/SIMPLE/pi_mpi.23265441.comet-01-38.out
  622  cat /home/ischeink/PARALLEL/SIMPLE/pi_mpi.23265441.comet-01-38.out
  623  cat /home/ischeink/PARALLEL/SIMPLE/pi_mpi.23265441.comet-01-38.outl
  624  ls /home/brhatton/
  625  ls /home/*/PARALLEL
  626  ls /home/jacobli/PARALLEL
  627  ls /home/jacobli/PARALLEL/SIMPLE/
  628  cat /home/ischeink/PARALLEL/SIMPLE/
  629  ll /home/ischeink/PARALLEL/SIMPLE/
  630  ll /home/ischeink/
  631  ll /home/tic173/
  632  ll /home/rchancha/homework/hpc-training/
  633  ll /home/rchancha
  634  ll /home | grep rchancha
  635  ll /home/rchancha
  636  ls -al /home | grep rchancha
  637  groups
  638  ls /oasis/scratch/comet/cseitz
  639  ls /oasis/scratch/comet/cseitz/temp_project/
  640  groups cseitz
  641  ls /home/cseitz
  642  ls /home | grep cseitz
  643  ls /home/cseitz/hpc-training
  644  exit
  645  top
  646  who
  647  who |wc
  648  squeu
  649  squeue
  650  squeue| wc
  651  exit
  652  ls /home/rchancha
  653  ls /home/rchancha/homework/hpc-training/
  654  ll week10
  655  ls /home/rchancha/homework/hpc-training/week10
  656  ls /home/rchancha/homework/hpc-training/week10/PythonSeries/
  657  ls /home/rchancha/homework/hpc-training/week10/mach.learn/
  658  ls /home/rchancha/homework/hpc-training/week10/mach.learn/ML_Tensorflow/
  659  ls /home/rchancha/homework/hpc-training/week10/PythonSeries/
  660  ls /home/rchancha/homework/hpc-training/week9
  661  ls /home/rchancha/homework/hpc-training/week9/SI2018_effective_use/
  662  ls /home/rchancha/homework/hpc-training/week8
  663  ls /home/rchancha/homework/hpc-training/week8/Homework.txt 
  664  cat /home/rchancha/homework/hpc-training/week8/Homework.txt 
  665  ls /home/rchancha/homework/hpc-training/week6
  666  ls /home/rchancha/homework/hpc-training/week6/matMult_mpi.23959456.comet-15-49.out 
  667  cat /home/rchancha/homework/hpc-training/week6/matMult_mpi.23959456.comet-15-49.out 
  668  ls /home/rchancha/homework/hpc-training/week6
  669  ls /home/rchancha/homework/hpc-training/week6/MPI/
  670  ls /home/rchancha/homework/hpc-training/week5
  671  ls /home/rchancha/homework/hpc-training/week4
  672  ls /home/rchancha/homework/hpc-training/week4/OPENMP_DUP/
  673  ls /home/rchancha/homework/hpc-training/wee3
  674  ls /home/rchancha/homework/hpc-training/week3
  675  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/
  676  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/
  677  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/hello_world/
  678  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/
  679  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/*
  680  ls /home/rchancha/homework/hpc-training/week3
  681  ls /home/rchancha/homework/hpc-training/week5
  682  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/
  683  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/
  684  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/*
  685  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/*/* | more
  686  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/* | more
  687  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/cuda-samples/*/*/*/* | more
  688  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/
  689  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/openacc-samples/
  690  ls /home/rchancha/homework/hpc-training/week5/gpu-code-examples/openacc-samples/saxpy/
  691  ls
  692  a;oas
  693  alias comet
  694  ssh -l mthomas comet.sdsc.edu
  695  top
  696  ls
  697  cd
  698  ls
  699  exit
  700  cat /proc/que'
  701  cat /proc/cpuinfo
  702  echo "hello world"
  703  env
  704  echo "hello world"
  705  jupyter notebook --no-browser --port=8889
  706  module avail
  707  module avail | grep jupyter
  708  python --v
  709  python -V
  710  module load jupyter
  711  module list python
  712  module avail python
  713  module avail anaconda
  714  exit
  715  show_accounts
  716  show_accounts sds173
  717  show_accounts -h
  718  show_user
  719  ll
  720  ll tools
  721  man show_accounts
  722  show_accounts
  723  grep sds173 /etc/passwd
  724  cat /etc/passwd | grep sds173
  725  cat /etc/passwd 
  726  cat /etc/group | grep sds173
  727  top
  728  finger rkwei
  729  exit
  730  ls /home/cseitz
  731  ls /oasis/scratch/comet/cseitz
  732  ls /oasis/scratch/comet/cseitz/temp_project/
  733  ls /oasis/projects/nsf/csd373/cseitz
  734  ls /oasis/projects/nsf/csd373/
  735  ls /oasis/projects/nsf/csd373/cseitz
  736  groups
  737  cat /etc/group | grep sds173
  738  mkdir junk
  739  ll
  740  chgrp -R sds173
  741  chgrp -R sds173 junk
  742  ll
  743  ls /home | grep cseitz
  744  cat /etc/group | grep use300
  745  chmod -R 750 junk
  746  ll junk
  747  cd junk
  748  ll
  749  mkdir d2 d1
  750  ll
  751  cd ..
  752  ll | grep junk
  753  tree | grep junk
  754  ll junk
  755  tree 
  756  tree junk
  757  tree -h
  758  tree --help
  759  tree -sD
  760  tree -sD -L3
  761  tree -sD -L 3
  762  tree -sD -L 3 junk
  763  tree --help
  764  tree -sDp -L 3 junk
  765  tree -sD-gp -L 3 junk
  766  tree -sDgp -L 3 junk
  767  tree -ugpsD -L 3 junk
  768  chgrp -R sds173 junk
  769  tree -ugpsD -L 3 junk
  770  history | chgrp
  771  ls /home/cseitz
  772  ls /oasis/scratch/comet/cseitz
  773  ls /oasis/scratch/comet/cseitz/temp_project/
  774  ls /oasis/projects/nsf/csd373/cseitz
  775  ls /oasis/projects/nsf/csd373/
  776  ls /oasis/projects/nsf/csd373/cseitz
  777  groups
  778  cat /etc/group | grep sds173
  779  mkdir junk
  780  ll
  781  chgrp -R sds173
  782  chgrp -R sds173 junk
  783  ll
  784  ls /home | grep cseitz
  785  cat /etc/group | grep use300
  786  chmod -R 750 junk
  787  ll junk
  788  cd junk
  789  ll
  790  mkdir d2 d1
  791  ll
  792  cd ..
  793  ll | grep junk
  794  tree | grep junk
  795  ll junk
  796  tree 
  797  tree junk
  798  tree -h
  799  tree --help
  800  tree -sD
  801  tree -sD -L3
  802  tree -sD -L 3
  803  tree -sD -L 3 junk
  804  tree --help
  805  tree -sDp -L 3 junk
  806  tree -sD-gp -L 3 junk
  807  tree -sDgp -L 3 junk
  808  tree -ugpsD -L 3 junk
  809  chgrp -R sds173 junk
  810  tree -ugpsD -L 3 junk
  811  history | chgrp
  812  history |grep chgrp
  813  ll /home | grep cseitz
  814  ls /home/yikaihao
  815  finger hao
  816  finger yikai
  817  ls /home/yih307
  818  ls /home/yih307/PARALLEL/
  819  ls /home/yih307
  820  finger yih307
  821  exit
  822  ls /home/akoganti
  823  show_accounts akoganti
  824  show_accounts alishac
  825  finger alishac
  826  finger Keganti
  827  finger rkwei
  828  finger moezzi
  829  finger Chakraboity
  830  finger alishac
  831  ls /home/alishac
  832  finger Anjali
  833  ll
  834  s=jbay27
  835  ls /home/$s
  836  s=alishac
  837  ls /home/$s
  838  ls /home/akoganti
  839  ls /home/msoezzi
  840  finger msoezzi
  841  finger moezzi
  842  ls /home/smoezzi 
  843  finger msoezzi
  844  ls /home/smoezzi
  845  finger Keganti
  846  history
  847  finger jbay27
  848  ls /home/jbay27
  849  date
  850  finger alishac
  851  ls /home/alishac
  852  finger rkwei
  853  ls /home/rkwei
  854  finger moezzi
  855  ls /home/moezzi
  856  ls /home/smoezzi
  857  finger akoganti
  858  ls /home/akoganti
  859  exit
  860  ls /home/jbay27
  861  ls /home/msoezzi
  862  ls /alishac
  863  show_accounts alishac
  864  show_accounts jbay
  865  show_accountsjbay27
  866  show_accounts jbay27
  867  ls /home/jbay27/
  868  mkdir rehs
  869  cd rehs
  870  vi student.accts.txt
  871  unalias vi
  872  vi student.accts.txt
  873  cd
  874  ls /home/cseitz
  875  ls /home/cseitz/hpctraining
  876  ll /home/cseitz/hpc-training
  877  ll /home | grep cseitz
  878  ls /tmp
  879    
  880  mkdir /tmp/mthomas
  881  ls /tmp/mthomas
  882  chgrp sds173 /tmp/mthomas/
  883  ls /tmp/mthomas
  884  chmod 777 /tmp/mthomas/
  885  ls /tmp/mthomas/
  886  cp /home/cseitz/hpc-training/* /tmp/mthomas
  887  ls /tmp/mthomas/
  888  ls /home/cseitz/hpc-training/
  889  exit
  890  ls /tmp
  891  ls /tmp/mary
  892  ls /tmp/mthomas
  893  cd
  894  mkdir SEITZ
  895  chmod 770 SEITZ
  896  ll 
  897  chgrp sds173 SEITZ
  898  ll
  899  cd SEITZ/
  900  pwd
  901  touch junk
  902  ll
  903  chgrp sds173 /home/mthomas/SEITZ/*
  904  ll
  905  chmod 777 /home/mthomas/SEITZ/*
  906  ll
  907  rm junk
  908  exit
  909  who
  910  who | wc
  911  ls
  912  exit
  913  who
  914  whoami
  915  history
  916  history | grep jupyter
  917  module load jupyter
  918  history | grep launch
  919  exit
  920  history | grep srun
  921  history
  922  history | grep srun
  923  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  924  cat README.md 
  925  ll
  926  ipython notebook --no-browser --ip=`/bin/hostname`
  927  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  928  history
  929  module load jupyter
  930  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  931  module load jupyter
  932  exit
  933  module load singularity
  934  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
  935  exit
  936  ll
  937  rm junk
  938  git clone git clone git@github.com:sinkovit/PythonSeries.git
  939  git clone git@github.com:sinkovit/PythonSeries.git
  940  ll
  941  cd PythonSeries/
  942  ll
  943  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  944  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
  945  exit
  946  vi student.accts.txt
  947  ll ~/tool
  948  ll ~/tools
  949  vi ~/tools/how.to.run.jupyternotebooks.txt 
  950  ipython notebook --no-browser --ip=`/bin/hostname` 
  951  ls
  952  ls cat Xapt.txt 
  953  cat Xapt.txt 
  954  cat Xenvironment.yml 
  955  cat Xrequirements.txt 
  956  grep requirements *.ipynb
  957  ll
  958  grep Xreq *
  959  cat .git
  960  cat .gitignore 
  961  ll
  962  cd
  963  ls /home/cseitz
  964  exit
  965  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
  966  history
  967  module load singularity
  968  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
  969  cd
  970  ls /home/cseitz
  971  ll /home/cseitz/hpc-training
  972  ll /home/cseitz/
  973  exit
  974  cd PythonSeries/
  975  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
  976  cd
  977  exit
  978  cd PythonSeries/
  979  ll
  980  cat Dockerfile 
  981  exit
  982  ls /home/moezzi
  983  ls /home/* | grep wei
  984  finger wei
  985  finger moezzi
  986  finger ryan wei
  987  ll /home/rkwei
  988  ll
  989  cd hpctrain/
  990  ll
  991  cat all_students.txt 
  992  cat all_students.txt | grep wei
  993  ll
  994  cd ..
  995  ll
  996  cd rehs/
  997  ll
  998  cat student.accts.txt 
  999  ll
 1000  cd
 1001  cd .ssh
 1002  ll
 1003  vi mthomas.quantum.id_rsa.pub
 1004  cat mthomas.quantum.id_rsa.pub 
 1005  cat authorized_keys 
 1006  vi authorized_keys 
 1007  ll
 1008  cat mthomas.quantum.id_rsa.pub >> authorized_keys 
 1009  exit
 1010  cd .ssh
 1011  ll
 1012  vi mthomas.quantum.id_rsa.pub 
 1013  cat authorized_keys 
 1014  cat ~/.alias
 1015  cat .bash_profile
 1016  cd
 1017  cat .bash_profile
 1018  ll
 1019  grep alias .*
 1020  ll
 1021  cat .bashrd
 1022  cat .bashrc
 1023  grep bash_ .bash*
 1024  mv .alias .bash_alias
 1025  mv .bash_alias .bash_aliases
 1026  vi .bash_aliases 
 1027  source .bash_aliases 
 1028  grep alias .*
 1029  grep alias .b*
 1030  grep alias .b* | grep -v history
 1031  cat .bash_profile 
 1032  cat .bashrc
 1033  vi .bashrc
 1034  exit
 1035  vi .bashrc
 1036  alias
 1037  vi .bash_aliases 
 1038  exit
 1039  cat .gitconfig 
 1040  mkdir JUNK
 1041  cd JUNK/
 1042  git clone git@github.com:sinkovit/PythonSeries.git
 1043  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1044  cd tools
 1045  ll
 1046  cd ..
 1047  ll 
 1048  cd .ssh
 1049  ll
 1050  cat authorized_keys 
 1051  ll
 1052  ll *.log
 1053  ll SEITZ/
 1054  rm -rf SEITZ/
 1055  ll
 1056  l PythonSeries/
 1057  rm junk JUNK/
 1058  rm -rf junk JUNK/
 1059  ll
 1060  ll intel/
 1061  ll intel/ism/rm/
 1062  ll .jupyter/
 1063  ll .jupyter/migrated 
 1064  cat .jupyter/migrated 
 1065  ll .ipython/
 1066  ll .ipython/*
 1067  ll .ipython/profile_default/
 1068  ll .ipython/profile_default/log/
 1069  ll .ipython/profile_default/*
 1070  ll .ipython/profile_default/startup/README 
 1071  cat .ipython/profile_default/startup/README 
 1072  exit
 1073  ll
 1074  ll tools
 1075  mv tools
 1076  mv tools tools.tmp
 1077  tar xvf tools.tar 
 1078  ll
 1079  ll tools
 1080  ll tools.tmp
 1081  mv tools.tmp/* tools
 1082  rmdir tools.tmp tools.tar 
 1083  ll
 1084  rm tools.tar 
 1085  ll
 1086  exit
 1087  ll
 1088  cat .profile 
 1089  cat .bash_profile 
 1090  cat .bashrc
 1091  cat .bash_profile 
 1092  ll .profile 
 1093  cat .profile 
 1094  exit
 1095  ipython notebook --no-browser --ip=`/bin/hostname`
 1096  module list
 1097  env
 1098  exit
 1099  modules list
 1100  module list
 1101  ll
 1102  ls ~
 1103  ls *.sh
 1104  cat loadgccomgnuenv.sh 
 1105  ll
 1106  ls *.sh
 1107  cat loadintelenv.sh 
 1108  cat loadgpuenv.sh 
 1109  hostname
 1110  exit
 1111  who
 1112  who|wc
 1113  who
 1114  who | sort
 1115  who | wc
 1116  who | grep z
 1117  who | grep -v z
 1118  which ruby
 1119  which rubya
 1120  exit
 1121  ls *.sh
 1122  env
 1123  hostname
 1124  exit
 1125  env
 1126  module list
 1127  ipython notebook --no-browser --ip=`/bin/hostname`
 1128  exit
 1129  module list
 1130  module load singularity
 1131  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
 1132  module lis
 1133  module liss
 1134  module list
 1135  env
 1136  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
 1137  exit
 1138  cd PythonSeries/
 1139  ls
 1140  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1141  exit
 1142  ls *.sh
 1143  cat loadgnuenv.sh 
 1144  exit
 1145  vi .bash_aliases 
 1146  source .bash_aliases 
 1147  ll
 1148  exit
 1149  alias
 1150  hpc-ipnb 
 1151  ssh-copy-id hpc-ipnb.sdsc.edu
 1152  hpc-ipnb 
 1153  cd
 1154  cd .ssh
 1155  ll
 1156  vi mthomas.hpc-ipnb.id_rsa.pub
 1157  cat mthomas.hpc-ipnb.id_rsa.pub >> authorized_keys 
 1158  source ~/.bash_aliases
 1159  cat mthomas.comet.id_rsa.pub
 1160  alias
 1161  hpc-ipnb 
 1162  exit
 1163  cd .ssh
 1164  ll
 1165  rm mthomas.sdsc-loaner.id_rsa.pub 
 1166  vi authorized_keys 
 1167  ll
 1168  exit
 1169  history
 1170  ll /share/apps/gpu/singularity/
 1171  module ad singularity
 1172  module add singularity
 1173  singularity -h
 1174  singularity run docker://tensorflow/tensorflow:latest
 1175  history | grep -ni singularity
 1176  ll
 1177  mkdir dev
 1178  cd dev/
 1179  mkdir singularity
 1180  cd singularity/
 1181  singularity pull shub://GodloveD/lolcow:latest
 1182  which singularity
 1183  module list
 1184  singularity pull shub://GodloveD/lolcow
 1185  singularity -v pull shub://GodloveD/lolcow
 1186  singularity -v pull shub://GodloveD/lolcow:latest
 1187  exit
 1188  ll
 1189  cd hpc
 1190  hpctrain/
 1191  ll
 1192  cd hpctrain/
 1193  ll
 1194  cat all_students.txt 
 1195  finger hbz001@ucsd.edu
 1196  finger hbz001
 1197  finger zhang | more
 1198  ls /share
 1199  ls /share/apps/
 1200  ls /share/apps/singularity/
 1201  ls /share/apps/singularity/mahidhar/
 1202  ls /share/apps/
 1203  ls /share/apps/img-storage/
 1204  ls /share/apps/compute/
 1205  ls /share/apps/compute/*/*.ipnb
 1206  ls /share/apps/compute/*/*/*.ipnb
 1207  ls /share/apps/compute/*/*.ipynb
 1208  ls /share/apps/compute/*/*/*.ipynb
 1209  ls /share/apps/compute/*/*/*/*.ipynb
 1210  ls /home/ | grep sink*
 1211  ls /home/ | grep sink
 1212  finger sinkovit
 1213  ls /home/sinkovit/
 1214  ls /home/sinkovit/jupyterhub-deploy-*
 1215  exit
 1216  ls /share/
 1217  ls /share/apps
 1218  ls /share/apps/examples/
 1219  /bin/ls /share/apps/examples/
 1220  ll
 1221  ll dev
 1222  cd dev
 1223  ll
 1224  git clone git@github.com:sdsc-hpc-students/REHS19.git
 1225  ll
 1226  cd REHS19/
 1227  ll
 1228  ll alisha/
 1229  module list
 1230  ipython notebook --no-browser --ip=`/bin/hostname`
 1231  exit
 1232  module load singularity
 1233  module list
 1234  ! singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
 1235  who
 1236  exit
 1237  who
 1238  history
 1239  module list
 1240  module load singularity
 1241  module list
 1242   
 1243  exit
 1244  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1245  who
 1246  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1247  exit
 1248  ll
 1249  cd rehs
 1250  ll
 1251  cd
 1252  cd dev
 1253  ll
 1254  cd REHS19/
 1255  ll
 1256  git update
 1257  git pull
 1258  exit
 1259  ll
 1260  cat hello_mpi.sb 
 1261  ibrun -np 4 ../hello_mpi 
 1262  srun -np 4 hello_mpi
 1263  srun -n 4 hello_mpi
 1264  ./hello_mpi
 1265  srun -n 9 hello_mpi
 1266  squeue
 1267  cat hello_mpi.sb 
 1268  vi hello_mpi.sb 
 1269  sbatch hello_mpi.sb 
 1270  squeue | grep mthomas
 1271  ll
 1272  squeue | grep mthomas
 1273  ll
 1274  date
 1275  cat hello_mpi.25059285.comet-16-45.out
 1276  mkdir /tmp/rkwei
 1277  cp hello_mpi.f90 /tmp/rkwei/
 1278  ll
 1279  cp hello_mpi.sb /tmp/rkwei/
 1280  cp hello_mpi /tmp/rkwei/
 1281  ll /tmp/rkwei/
 1282  srun -n 2 ./hello_mpi
 1283  exit
 1284  hostname
 1285  srun hostname
 1286  ll
 1287  hostname
 1288  ls
 1289  cd comet-examples/
 1290  ll
 1291  cd PHYS244/
 1292  ll
 1293  cd MPI/
 1294  ll
 1295  cat hello_mpi.f90 
 1296  ll
 1297  ./hello_mpi
 1298  cat hello_mpi.sb
 1299  sbatch hello_mpi.sb; 
 1300  squeue
 1301  squeue | grep mthomas
 1302  l
 1303  ll
 1304  cat hello_mpi.25058701.comet-14-19.out 
 1305  ll
 1306  srun hello_mpi.sb 
 1307  man srun
 1308  which srun
 1309  more /usr/bin/srun
 1310  srun hello_mpi.sb 
 1311  history
 1312  history| grep srun
 1313  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1314  history
 1315  mkdir /tmp/rkwei
 1316  cp hello_mpi /tmp/rkwei/
 1317  cp hello_mpi.f90 /tmp/rkwei/
 1318  cp hello_mpi.sb /tmp/rkwei/
 1319  ll /tmp/rkwei/
 1320  ll /tmp
 1321  ll /tmp/rkwei/
 1322  ll
 1323  ./hello_mpi
 1324  srun -n 2 ./hello_mpi
 1325  cat hello_mpi.sb 
 1326  ls /share/
 1327  ls /share/apps/
 1328  cd /share/apps/
 1329  ll
 1330  ll */* | grep -i linpack
 1331  ll gpu/
 1332  locate linpack
 1333  history | grep sinularity
 1334  ll
 1335  exit
 1336  ls
 1337  cd hpctrain/
 1338  ll
 1339  cd ..
 1340  cd comet-examples/
 1341  ll
 1342  cd PHYS244
 1343  ll
 1344  cd MPI
 1345  ll
 1346  cat hello_mpi.f90 
 1347  ls
 1348  ./hello_mpi
 1349  cat hello_mpi.sb 
 1350  vi hello_mpi.sb 
 1351  squeue
 1352  history | qrep queue
 1353  history | grep queue
 1354  which squeue
 1355  module list
 1356  pwd
 1357  exit
 1358  history | grep singularity
 1359  vi load.singularity.notebook.sh
 1360  history | grep notebook
 1361  vi load.singularity.notebook.sh
 1362  modules list
 1363  module list
 1364  module load singularity
 1365  module list
 1366  which ipython
 1367  ll
 1368  history
 1369  cat load.singularity.notebook.sh 
 1370  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
 1371  which ipython
 1372  which squeue
 1373  squeue
 1374  ls ~/*.sh
 1375  cat ~/loadintelenv.sh 
 1376  cat ~/loadgpuenv.sh 
 1377  module -h
 1378  man module
 1379  cd /home/mthomas/comet-examples/PHYS244/MPI
 1380  ll
 1381  module list
 1382  cat ~/loadintelenv.sh 
 1383  ~/loadintelenv.sh 
 1384  module list
 1385  squeue
 1386  squeue | grep mthomas
 1387  ls
 1388  sbatch hello_mpi.sb 
 1389  squeue | grep mthomas
 1390  ll
 1391  squeue | grep mthomas
 1392  squeue | wc
 1393  squeue 
 1394  squeue | grep PD
 1395  squeue | grep mthomas
 1396  ls
 1397  cat hello_mpi.25059285.comet-16-45.out
 1398  exit
 1399  which ipython
 1400  ipython notebook --no-browser --ip=`/bin/hostname`
 1401  exit
 1402  cat load.singularity.notebook.sh 
 1403  module list
 1404  which jupyter
 1405  which ipython
 1406  module load singularity
 1407  singularity shell /share/apps/gpu/singularity/sdsc_ubuntu_tf1.1_keras_R.img
 1408  exit
 1409  squeue | grep mthomas
 1410  history
 1411  cat load.singularity.notebook.sh 
 1412  history
 1413  history | srun
 1414  history | grep srun
 1415  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1416  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1417  ll
 1418  exit
 1419  clear
 1420  exit
 1421  ll
 1422  date
 1423  mkdir hello-mpi
 1424  ll comet-examples/PHYS244
 1425  ll comet-examples/PHYS244/MPI
 1426  cp comet-examples/PHYS244/MPI/hello_mpi.f90 hello-mpi/
 1427  cp comet-examples/PHYS244/MPI/hello_mpi.sb hello-mpi/
 1428  cp comet-examples/PHYS244/MPI/hello_mp hello-mpi/
 1429  cp comet-examples/PHYS244/MPI/hello_mpi hello-mpi/
 1430  ll *.out
 1431  squeue | grep mthomas
 1432  ll
 1433  squeue | grep mthomas
 1434  skill
 1435  skill 25344992
 1436  skill 25345044
 1437  squeue | grep mthomas
 1438  squeue -h -j 25345254 -o '%T %B'
 1439  squeue | grep mthomas
 1440  squeue -h -j 25344992 -o '%T %B'
 1441  squeue | grep mthomas
 1442  squeue -h -j 25345404 -o '%T %B'
 1443  ll *.out
 1444  ll
 1445  cat jupyterhub_slurmspawner_25345*.log
 1446  ll
 1447  cat jupyterhub_slurmspawner_25345555.lo
 1448  cat jupyterhub_slurmspawner_25345555.log
 1449  squeue -h
 1450  man squeue
 1451  sleep 2
 1452  squeue -h
 1453  squeue | grep mthomas
 1454  which history
 1455  history
 1456  ls /bin/hist*
 1457  find history
 1458  squeue
 1459  squeue | grep mthomas
 1460  ll 
 1461  ls *.log
 1462  cat jupyterhub_slurmspawner_25350024.log
 1463  ll *25350024*
 1464  squeue | grep mthomas
 1465  ll *.log
 1466  squeue | grep mthomas
 1467  sdel 25350175
 1468  skill 25350175
 1469  squeue | grep mthomas
 1470  ll *.log
 1471  squeue | grep mthomas
 1472  ll
 1473  which jupyter
 1474  which ipython
 1475  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
 1476  bash Miniconda3-latest-Linux-x86_64.sh 
 1477  exit
 1478  which conda
 1479  conda install jupyter
 1480  which ipython
 1481  ipython notebook
 1482  jupyter notebook
 1483  ll
 1484  ls *.sh
 1485  cat load.singularity.notebook.sh 
 1486  ipython notebook --no-browser --ip=`/bin/hostname`
 1487  jupyter notebook --no-browser --ip=`/bin/hostname`
 1488  squeue | grep mthomas
 1489  squeue | grep debug
 1490  squeue | grep mthomas
 1491  squeue | grep debug
 1492  squeue | grep mthomas
 1493  ll *.log
 1494  squeue | grep mthomas
 1495  ll *.log
 1496  ll
 1497  ll *.log
 1498  cat 
 1499  cat jupyterhub_slurmspawner_25350402.log
 1500  ll
 1501  ll *.log
 1502  cat jupyterhub_slurmspawner_25350589.log
 1503  ll *.log
 1504  squeue | grep mthomas
 1505  ll *.log
 1506  cat jupyterhub_slurmspawner_25350589.log
 1507  squeue | grep debug
 1508  ll *.log
 1509  squeue | grep mthomas
 1510  squeue | grep debug
 1511  ll *.log
 1512  cat jupyterhub_slurmspawner_25350629.log
 1513  squeue | grep debug
 1514  p=25350636
 1515  cat jupyterhub_slurmspawner_$p.log
 1516  ll *.log
 1517  squeue | grep debug
 1518  ll
 1519  ll *.log
 1520  cat jupyterhub_slurmspawner_25350666.log
 1521  ll *.log
 1522  cat jupyterhub_slurmspawner_25350666.log
 1523  ll *.log
 1524  cat jupyterhub_slurmspawner_25350712.log 
 1525  man jupyter
 1526  jupyter -h
 1527  conda install jupyterhub-singleuser
 1528  which jupyterhub-singleuser
 1529  exit
 1530  squeue | grep debug
 1531  ll *.log
 1532  which jupyterhub-singleuser
 1533  ll *.log
 1534  squeue | grep debug
 1535  ll *.log
 1536  cat jupyterhub_slurmspawner_25351061.log
 1537  history | grep conda
 1538  conda install notebook
 1539  conda install -c conda-forge jupyterhub
 1540  ll *.log
 1541  cat jupyterhub_slurmspawner_25351078.log
 1542  which jupyterhub-singleuser
 1543  ll *.log
 1544  squeue | grep debug
 1545  squeue | grep mthomas
 1546  ll *.log
 1547  cat jupyterhub_slurmspawner_25351081.log
 1548  locate jupyter_config
 1549  ls /home/mthomas/.jupyter/
 1550  ll *.log
 1551  squeue | grep mthomas
 1552  squeue | grep compute |wc
 1553  squeue | grep compute | grep PD | wc
 1554  ll *.log
 1555  cat jupyterhub_slurmspawner_25351104.log
 1556  ll
 1557  ll *.log
 1558  cat jupyterhub_slurmspawner_25351149.log
 1559  module list
 1560  which pip
 1561  history
 1562  history | grep install
 1563  which pip
 1564  which conda
 1565  which notebook
 1566  which ipython
 1567  python --version
 1568  squeue | grep compute
 1569  exit
 1570  ll *.sh
 1571  cat load.singularity.notebook.sh 
 1572  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1573  ll
 1574  ll *.log
 1575  ll jupyterhub_slurmspawner_25388442.log 
 1576  cat jupyterhub_slurmspawner_25388442.log 
 1577  ll
 1578  ll *.log
 1579  ll .vim*
 1580  cat .vimrc 
 1581  source .vimrc
 1582  ll
 1583  ll *.lot
 1584  ll *.log
 1585  cat jupyterhub_slurmspawner_25388442.log
 1586  jupyterhub token mthomas
 1587  openssl rand -hex 32
 1588  squeue | grep mthomas
 1589  ll
 1590  ll *.lot
 1591  ll *.log
 1592  cat jupyterhub_slurmspawner_25424221.log
 1593  locate jupyter_config.py
 1594  cd .jupyter/
 1595  ll
 1596  cat migrated 
 1597  ll
 1598  ll ..
 1599  ll ../.miniconda3
 1600  ll ../.mini
 1601  ll 
 1602  cd ../..
 1603  ll
 1604  cd
 1605  ll 
 1606  ll miniconda3/
 1607  cd .jupyter/
 1608   jupyter notebook --generate-config
 1609  ct jupyter_notebook_config.py 
 1610  cat jupyter_notebook_config.py 
 1611  ll
 1612  cd
 1613  ll *.log
 1614  squeue
 1615  squeue|grep mthomas
 1616  ll
 1617  squeue|grep mthomas
 1618  ll *.log
 1619  cat jupyterhub_slurmspawner_25425118.log
 1620  jupyter -paths
 1621  jupyter paths
 1622  jupyter --paths
 1623  vi .bash_profile 
 1624  cd .jupyter/
 1625  vi jupyter_config.py
 1626  jupyter notebook
 1627  history | grep notebook
 1628  jupyter notebook --no-browser --ip=`/bin/hostname`
 1629  ll
 1630  ll ~/.bash*
 1631  cat ~/.bashrc 
 1632  cat ~/.bash_profile 
 1633  vi /home/mthomas/.bashrc 
 1634  squeue | grep mthoma
 1635  ll
 1636  cd
 1637  ll *.log
 1638  cat jupyterhub_slurmspawner_25425151.log
 1639  squeue | grep mthoma
 1640  squeue | grep mthomas;ls *.log
 1641  cat jupyterhub_slurmspawner_25425164.log
 1642  cat ./bashrc
 1643  squeue | grep mthomas;ls *.log
 1644  squeue | grep mthomas;
 1645  squeue | grep mthomas;ls *.log
 1646  cat  jupyterhub_slurmspawner_25425189.log
 1647  ll
 1648  ll miniconda3/
 1649  ll .jupyter/
 1650  ll
 1651  cat  jupyterhub_slurmspawner_25425189.log
 1652  ll
 1653  cd comet-examples/
 1654  ll
 1655  cd PHYS244/
 1656  ll
 1657  cd MPI
 1658  ll
 1659  mpif90 hello_mpi.f90 
 1660  vi hello_mpi.f90 
 1661  mpif90 hello_mpi.f90 
 1662  cd ..
 1663  cd MPI/
 1664  ll
 1665  ll MPIRUN_RSH/
 1666  dir hello_mpi.sb MPIRUN_RSH/hellompirunrsh-slurm.sb 
 1667  rm -rf MPIRUN_RSH/
 1668  ll
 1669  ll IBRUN/
 1670  cd ..
 1671  ll
 1672  cd OPENMP/
 1673  l
 1674  ll
 1675  cd ..
 1676  ll
 1677  cd MPI
 1678  ll
 1679  cp hello_mpi.sb hello_mpi_SI19.sb
 1680  vi hello_mpi_SI19.sb 
 1681  sbatch hello_mpi_SI19.sb 
 1682  squeue | grep mthomas
 1683  ll
 1684  squeue | grep mthomas
 1685  sbatch hello_mpi.sb
 1686  squeue | grep mthomas
 1687  cat hello_mpi.sb 
 1688  squeue | grep mthomas
 1689  sdel 25430368
 1690  squeue | grep mthomas
 1691  which sdel
 1692  man sdel
 1693  skill
 1694  squeue | grep mthomas
 1695  scancel 25430368
 1696  modules list
 1697  module list
 1698  module avail
 1699  module load amber
 1700  module list
 1701  cd
 1702  ll *.sh
 1703  cat loadintelenv.sh 
 1704  ./loadintelenv.sh 
 1705  module list
 1706  exit
 1707  vi getnodes.si19
 1708  cat getnodes.si19 
 1709  getcpu[1]
 1710  history srun
 1711  history | grep  srun
 1712  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1713  srun --pty srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1714  srun --pty --nodes=1 --res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1715  srun --pty --nodes=1 -res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1716  srun --pty --nodes=1 --res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1717  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1718  exit
 1719  module list
 1720  module load fftw/3.3.4 
 1721  module list
 1722  env
 1723  which module
 1724  which ls
 1725  which mpif90
 1726  module list
 1727  ./loadgpuenv.sh 
 1728  cat loadgpuenv.sh 
 1729  module list
 1730  module purge
 1731  module list
 1732  module load gnutools
 1733  module load cuda
 1734  module list
 1735  exit
 1736  ls
 1737  ./pdpttr.exe 
 1738  exit
 1739  cd ~/comet-examples/PHYS244/MKL
 1740  ll
 1741  cat compile.txt
 1742  cat scalapack.8718437.comet-14-01.out
 1743  mpicc -o pdpttr.exe pdpttr.c  -I$MKL_ROOT/include ${MKL_ROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKL_ROOT}/lib/intel64/libmkl_intel_lp64.a ${MKL_ROOT}/lib/intel64/libmkl_core.a ${MKL_ROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group ${MKL_ROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -lpthread -lm
 1744  ll
 1745  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1746  squeue
 1747  squeue | wc
 1748  cd ../
 1749  cd MPI
 1750  ll
 1751  cat hello_mpi.f90 
 1752  ll
 1753  mpif90 hello_mpi.f90 
 1754  ll
 1755  sbatch hello_mpi.sb
 1756  squeue | grep mthomas
 1757  ll
 1758  cat hello_mpi.25430368.comet-28-25.out
 1759  cat hello_mpi.sb 
 1760  squeue | grep mthomas
 1761  scancel 25431737
 1762  squeue | grep mthomas
 1763  cd
 1764  ll
 1765  cd rehs/
 1766  ll
 1767  cd ..
 1768  exit
 1769  ll *.log
 1770  cat Let me know ASAP, so we can get them tomorrow/thursday.
 1771  cat jupyterhub_slurmspawner_25425189.log 
 1772  exit
 1773  module load singularity
 1774  exit
 1775  top
 1776  exit
 1777  cd dev/
 1778  ll
 1779  git clone git@github.com:sdsc/sdsc-summer-institute-2019.git
 1780  cd sdsc-summer-institute-2019/
 1781  ll
 1782  cd hpc0_python_hpc/
 1783  ll
 1784  sbatch notebook_singularity.slrm 
 1785  cat notebook_singularity.slrm 
 1786  vi notebook_singularity.slrm 
 1787  sbatch notebook_singularity.slrm 
 1788  cat notebook_singularity.slrm 
 1789  squeue -u mthomas
 1790  ll
 1791  cat jupyter-notebook.25452621.comet-06-26.out
 1792  git pull
 1793  sbatch -u mthomas
 1794  squeue -u mthomas
 1795  squeue -u zonca
 1796  ll
 1797  cat notebook_singularity.slrm 
 1798  ll
 1799  ll 0_dask_tutorial/
 1800  squeue -u zonca
 1801  squeue | grep jupyter
 1802  squeue | grep jupyter|wc
 1803  ssh mthomas@comet-06-26
 1804  ll
 1805  cd dask_slurm/
 1806  ll
 1807  cat dask_workers.slrm 
 1808  sbatch dask_workers.slrm 
 1809  squeue -u mthomas
 1810  ll
 1811  cat dask_workers.slrm 
 1812  squeue -u mthomas
 1813  cat launch_worker.sh 
 1814  ll ~/.dask_scheduler.json 
 1815  cat ~/.dask_scheduler.json 
 1816  squeue -u mthomas
 1817  cat ~/.dask_scheduler.json 
 1818  ll
 1819  vi dask_workers.slrm 
 1820  squeue -u mthomas
 1821  scancel 25458523
 1822  sbatch dask_workers.slrm 
 1823  squeue -u mthomas
 1824  vi dask_workers.slrm 
 1825  sbatch dask_workers.slrm 
 1826  squeue -u mthomas
 1827  scancel 25458884
 1828  squeue -u mthomas
 1829  scancel 25458710
 1830  squeue -u mthomas
 1831  sbatch dask_workers.slrm 
 1832  squeue -u mthomas
 1833  ll
 1834  cat dask_workers.slrm 
 1835  squeue -u mthomas
 1836  vi dask_workers.slrm 
 1837  squeue -u mthomas
 1838  sbatch dask_workers.slrm 
 1839  squeue -u mthomas
 1840  scancel 25459363
 1841  squeue -u mthomas
 1842  vi dask_workers.slrm 
 1843  ll
 1844  python GIL_counter.py 
 1845  python GIL_counter.py  2
 1846  python GIL_counter.py  10
 1847  top
 1848  ll
 1849  cd dask_slurm/
 1850  ll
 1851  vash launch_scheduler.sh 
 1852  bash launch_scheduler.sh 
 1853  ___
 1854  ll
 1855  singularity --version
 1856  module avail
 1857  module avail | sing
 1858  module info singularity
 1859  module avail singularity
 1860  module load singularity
 1861  singularity --version
 1862  ll /share/apps/examples/SI2017/
 1863  ll /share/apps/examples/SI2019
 1864  ll /share/apps/examples/
 1865  ll /share/apps/examples/SI2018
 1866  ll /share/apps/examples/SI2018/Singularity/
 1867  ll /share/apps/examples/SI2018/Singularity/singularity-hello-world/
 1868  cd dev/
 1869  ll
 1870  cd singularity/
 1871  ll
 1872  cp 
 1873  cp /share/apps/examples/SI2018/Singularity/singularity-hello-world/ .
 1874  ll
 1875  cp -r /share/apps/examples/SI2018/Singularity/singularity-hello-world/ .
 1876  ll
 1877  cd singularity-hello-world/
 1878  ll
 1879  cat README.md 
 1880  module load singularity 
 1881  ./hello.sh 
 1882  singularity shell centos7.img
 1883  ./hello.sh 
 1884  ll
 1885  exit
 1886  singularity pull shub://vsoch/hello-world
 1887  module load singularity
 1888  cd dev
 1889  cd singularity/
 1890  ll
 1891  cd singularity-hello-world/
 1892  ll
 1893  cd ..
 1894  mkdir lbl.sing
 1895  cd lbl.sing/
 1896  singularity pull shub://vsoch/hello-world
 1897  singularity --debug run shub://GodloveD/lolcow
 1898  singularity run --containall shub://GodloveD/lolcow
 1899  singularity --debug run shub://GodloveD/lolcowwhc
 1900  which singularity
 1901  which run-singularity
 1902  cat run-singularity
 1903  cat /opt/singularity/bin/run-singularity
 1904  run-singularity shub://GodloveD/lolcowwhc
 1905  run-singularity --debug shub://GodloveD/lolcowwhc
 1906  singularity run shub://GodloveD/lolcowwhc
 1907  singularity --debug run shub://GodloveD/lolcowwhc
 1908  history
 1909  singularity run --containall shub://GodloveD/lolcow
 1910  cd ..
 1911  ll
 1912  cd ..
 1913  ll
 1914  ll singularity/
 1915  rm -rf singularity/lbl.sing/
 1916  exit
 1917  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1918  exit
 1919  history | grep srun
 1920  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1921  gpu1
 1922  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
 1923  history
 1924  module purge
 1925  module load gnutools
 1926  module load cuda
 1927  module load pgi
 1928  nvcc --version
 1929  module list
 1930  nvidia-smi
 1931  ll
 1932  cd comet-examples/
 1933  ll
 1934  cd PHYS244/
 1935  cd CUDA/
 1936  ll
 1937  rm junk
 1938  ll
 1939  cd
 1940  locate hello_world.cu
 1941  ll
 1942  ll hello-mpi/
 1943  cd cuda
 1944  ll
 1945  cd helloworld/
 1946  ll
 1947  cd ..
 1948  ll simple_hello/
 1949  rm -rf helloworld/
 1950  cd simple_hello/
 1951  vi simple_hello.cu 
 1952  nvcc -o simple_hello simple_hello.cu 
 1953  ./simple_hello 
 1954  cd ../gpu_enum/
 1955  ll
 1956  nvcc -o gpu_enum gpu_enum.cu 
 1957  diff simple_hello.cu ../simple_hello/simple_hello.cu
 1958  diff -y simple_hello.cu ../simple_hello/simple_hello.cu
 1959  ll
 1960  mv simple_hello.cu ../simple_hello/simple_hello_kernel.cu
 1961  rm simple_hello 
 1962  ll
 1963  nvcc -o gpu_enum gpu_enum.cu
 1964  ./gpu_enum 
 1965  ll
 1966  qbatch gpu_enum.sb 
 1967  cat gpu_enum.22532472.comet-33-06.out 
 1968  cd ../simple_hello/
 1969  ll
 1970  cat simple_hello.cu
 1971  /*
 1972  * simple_hello.cu
 1973  * Copyright 1993-2010 NVIDIA Corporation. 
 1974  *    All right reserved
 1975  */
 1976  #include <stdio.h> 
 1977  #include <stdlib.h>
 1978  int main( void ) 
 1979  {     int deviceCount;    cudaGetDeviceCount( &deviceCount ); 
 1980     printf("Hello, NVIDIA DLI Workshop! You have %d devices\n", deviceCount ); 
 1981     return 0;
 1982  }exit
 1983  exit
 1984  ll *.sh
 1985  cat loadgpuenv.sh 
 1986  ./loadgpuenv.sh 
 1987  which nvcc
 1988  cat loadgpuenv.sh 
 1989  module list
 1990  source /etc/profile.d/modules.sh
 1991  module list
 1992  module purge
 1993  module list
 1994  module load gnutools
 1995  module load cuda
 1996  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6      --gres=gpu:k80:1 --reservation=SI2019DAY4 --pty --wait=0 /bin/bash
 1997  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
 1998  ll
 1999  exit
 2000  ll
 2001  cd cuda/
 2002  ll
 2003  l gpu_enum/
 2004  ll phys244/
 2005  ll phys244/cuda-samples
 2006  cd
 2007  git clone git@github.com:sdsc-hpc-training/nvidia-dli-2019.git
 2008  ll nvidia-dli-2019/
 2009  ll /share
 2010  ll /share/apps/
 2011  ll /share/apps/gpu
 2012  ll
 2013  cd nvidia-dli-2019/day1
 2014  ll
 2015  cd comet_access/
 2016  ll
 2017  mkdir ex
 2018  cd ex
 2019  ll ~/cuda/
 2020  cp -R ~/cuda/gpu_enum .
 2021  ll
 2022  cp -R ~/cuda/simple_hello/ .
 2023  ll
 2024  cd gpu_enum/
 2025  ll
 2026  cd ..
 2027  ll simple_hello/
 2028  cd ..
 2029  ll
 2030  git status
 2031  git add ex
 2032  git commit -m 'adding cuda example code'
 2033  git push
 2034  git pull
 2035  ll
 2036  ll getting_started/
 2037  cat getting_started/comet_user_guide.md 
 2038  ll
 2039  ll ..
 2040  ls ../..
 2041  vi ../../.gitignore 
 2042  ll
 2043  cd
 2044  cd cuda/
 2045  ll
 2046  cd simple_hello/
 2047  ll
 2048  ./simple_hello 
 2049  history
(base) [mthomas@comet-ln3:~/cuda/simple_hello] history|srun
srun: fatal: No command given to execute.
(base) [mthomas@comet-ln3:~/cuda/simple_hello] history| grep srun
  920  history | grep srun
  922  history | grep srun
  923  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  927  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  930  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  943  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
  944  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
  965  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
  975  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1043  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1140  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1244  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1246  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1262  srun -np 4 hello_mpi
 1263  srun -n 4 hello_mpi
 1265  srun -n 9 hello_mpi
 1282  srun -n 2 ./hello_mpi
 1285  srun hostname
 1306  srun hello_mpi.sb 
 1307  man srun
 1308  which srun
 1309  more /usr/bin/srun
 1310  srun hello_mpi.sb 
 1312  history| grep srun
 1313  ! srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1324  srun -n 2 ./hello_mpi
 1413  history | srun
 1414  history | grep srun
 1415  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 02:00:00 --wait 0 /bin/bash
 1416  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1572  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1710  history srun
 1711  history | grep  srun
 1712  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1713  srun --pty srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1714  srun --pty --nodes=1 --res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1715  srun --pty --nodes=1 -res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1716  srun --pty --nodes=1 --res=SI2019DAY1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1717  srun --pty --nodes=1 --ntasks-per-node=24 -p compute -t 00:30:00 --wait 0 /bin/bash
 1745  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1917  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1919  history | grep srun
 1920  srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
 1922  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
 1996  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6      --gres=gpu:k80:1 --reservation=SI2019DAY4 --pty --wait=0 /bin/bash
 1997  srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
 2050  history|srun
 2051  history| grep srun
(base) [mthomas@comet-ln3:~/cuda/simple_hello] !1997
srun -t 01:00:00 --partition=gpu-shared --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1  --pty --wait=0 /bin/bash
srun: job 25861706 queued and waiting for resources
. . . 
srun: job 25861706 has been allocated resources
[username@comet-30-04:~/cuda/simple_hello] ./simple_hello 
Hello, NVIDIA DLI Workshop! You have 1 devices
[usernames@comet-30-04:~/cuda/simple_hello] cd
[username@comet-30-04:~] cd cuda/gpu_enum/
[username@comet-30-04:~/cuda/gpu_enum] ll
total 323
drwxr-xr-x 2 username use300      6 Aug 19 17:41 .
drwxr-xr-x 6 username use300      6 Aug 19 17:39 ..
-rwxr-xr-x 1 username use300 517640 Aug 19 17:41 gpu_enum
-rw-r--r-- 1 username use300   1201 Apr 10 23:26 gpu_enum.22532472.comet-33-06.out
-rw-r--r-- 1 username use300   1813 Apr 10 18:43 gpu_enum.cu
-rw-r--r-- 1 username use300    375 Apr 11 15:20 gpu_enum.sb
[username@comet-30-04:~/cuda/gpu_enum] ./gpu_enum 
 --- Obtaining General Information for CUDA devices  ---
 --- General Information for device 0 ---
Name: Tesla K80
Compute capability: 3.7
Clock rate: 823500
Device copy overlap: Enabled
Kernel execution timeout : Disabled
 --- Memory Information for device 0 ---
Total global mem: 12799574016
Total constant Mem: 65536
Max mem pitch: 2147483647
Texture Alignment: 512
 --- MP Information for device 0 ---
Multiprocessor count: 13
Shared mem per mp: 49152
Registers per mp: 65536
Threads in warp: 32
Max threads per block: 1024
Max thread dimensions: (1024, 1024, 64)
Max grid dimensions: (2147483647, 65535, 65535)

[username@comet-30-04:~/cuda/gpu_enum] 
```

### <a name="hello-world-gpu-batch-submit"></a>GPU Hello World: Batch Script Submit

GPU nodes can be accessed via either the "gpu" or the "gpu-shared" partitions:
```
#SBATCH -p gpu           
```
or
```
#SBATCH -p gpu-shared 
```

In addition to the partition namei (required), the type of gpui (optional) and the individual GPUs are scheduled as a resource.
```
#SBATCH --gres=gpu[:type]:n 
```

GPUs will be allocated on a first available, first schedule basis, unless specified with the [type] option, where type can be <b>`k80`</b> or <b>`p100`</b> Note: type is case sensitive.
```
#SBATCH --gres=gpu:4     #first available gpu node 
#SBATCH --gres=gpu:k80:4 #only k80 nodes 
#SBATCH --gres=gpu:p100:4 #only p100 nodes
```

<b>Contents of the Slurm script</b>
```
[user@comet-ln2:~/cuda/simple_hello] cat simple_hello.sb 
#!/bin/bash
#SBATCH --job-name="simple_hello"
#SBATCH --output="simple_hello.%j.%N.out"
#SBATCH --partition=gpu-shared          # define GPU partition
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
####SBATCH --gres=gpu:1         # define type of GPU
#SBATCH --gres=gpu:2         # first available
#SBATCH -t 00:05:00

#Load the cuda module
echo "loading cuda module"
module load cuda

#print device information via command line
echo "calling nvcc-smi"
nvcc-smi

#Run the job
echo "calling simple hello"
./simple_hello

[user@comet-ln2:~/cuda/simple_hello]
```

<b>Submit the job</b> <br>

To run the job, type the batch script submission command:
```
[user@comet-ln2:~/cuda/simple_hello] sbatch simple_hello.sb 
Submitted batch job 22532827
[user@comet-ln2:~/cuda/simple_hello]

```

<b>Monitor the job until it is finished:</b>
```
[user@comet-ln2:~/cuda/simple_hello] squeue -u user
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          22532827 gpu-share simple_h  user PD       0:00      1 (Resources)
[user@comet-ln2:~/cuda/simple_hello] 

```


<hr>

#### <a name="hello-world-gpu-batch-output"></a>GPU Hello World: Batch Job Output
```
[user@comet-ln2:~/cuda/simple_hello] cat simple_hello.22532827.comet-33-06.out 
loading cuda module

Hello, NVIDIA DLI Workshop! You have 2 devices

[user@comet-ln2:~/cuda/simple_hello]

```
<hr>

### <a name="enum-gpu"></a>GPU/CUDA Example: Enumeration 

Sections:
* [GPU Enumeration: Compiling](#enum-gpu-compile)
* [GPU Enumeration: Batch Script Submission](#enum-gpu-batch-submit)
* [GPU Enumeration: Batch Job Output](#enum-gpu-batch-output )

<hr>

#### <a name="enum-gpu-compile"></a>GPU Enumeration: Compiling

<b>GPU Enumeration Code:</b>
This code accesses the cudaDeviceProp object and returns information about the devices on the node. The list below is only some of the information that you can look for. The property values can be used to dynamically allocate or distribute your compute threads accross the GPU hardware in response to the GPU type. 
```
[user@comet-ln2:~/cuda/gpu_enum] cat gpu_enum.cu 
#include <stdio.h>

int main( void ) {
   cudaDeviceProp prop;
   int count;
   printf( " --- Obtaining General Information for CUDA devices  ---\n" ); 
   cudaGetDeviceCount( &count ) ;
   for (int i=0; i< count; i++) {
      cudaGetDeviceProperties( &prop, i ) ;
      printf( " --- General Information for device %d ---\n", i ); 
      printf( "Name: %s\n", prop.name );
   
      printf( "Compute capability: %d.%d\n", prop.major, prop.minor ); 
      printf( "Clock rate: %d\n", prop.clockRate );
      printf( "Device copy overlap: " );
   
      if (prop.deviceOverlap)
       printf( "Enabled\n" ); 
      else
       printf( "Disabled\n");
     
      printf( "Kernel execution timeout : " ); 

      if (prop.kernelExecTimeoutEnabled)
         printf( "Enabled\n" ); 
      else
         printf( "Disabled\n" );

      printf( " --- Memory Information for device %d ---\n", i ); 
      printf( "Total global mem: %ld\n", prop.totalGlobalMem ); 
      printf( "Total constant Mem: %ld\n", prop.totalConstMem ); 
      printf( "Max mem pitch: %ld\n", prop.memPitch );
      printf( "Texture Alignment: %ld\n", prop.textureAlignment ); 
      printf( " --- MP Information for device %d ---\n", i ); 
      printf( "Multiprocessor count: %d\n", prop.multiProcessorCount );
      printf( "Shared mem per mp: %ld\n", prop.sharedMemPerBlock ); 
      printf( "Registers per mp: %d\n", prop.regsPerBlock ); 
      printf( "Threads in warp: %d\n", prop.warpSize );
      printf( "Max threads per block: %d\n", prop.maxThreadsPerBlock );
      printf( "Max thread dimensions: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2] );
      printf( "Max grid dimensions: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2] ); 
      printf( "\n" );
   } 
}
```

To compile: check your environment and use the CUDA <b>`nvcc`</b> command:
```
[comet-ln2:~/cuda/gpu_enum] module purge
[comet-ln2:~/cuda/gpu_enum] which nvcc
/usr/bin/which: no nvcc in (/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/user/bin)
[comet-ln2:~/cuda/gpu_enum] module load cuda
[comet-ln2:~/cuda/gpu_enum] which nvcc
/usr/local/cuda-7.0/bin/nvcc
[comet-ln2:~/cuda/gpu_enum] nvcc -o gpu_enum -I.  gpu_enum.cu
[comet-ln2:~/cuda/gpu_enum] ll gpu_enum 
-rwxr-xr-x 1 user use300 517632 Apr 10 18:39 gpu_enum
[comet-ln2:~/cuda/gpu_enum] 
```
<hr>

#### <a name="enum-gpu-batch-submit"></a>GPU Enumeration: Batch Script Submission
<b>Contents of the Slurm script </b>

```[comet-ln2: ~/cuda/gpu_enum] cat gpu_enum.sb 
#!/bin/bash
#SBATCH --job-name="gpu_enum"
#SBATCH --output="gpu_enum.%j.%N.out"
#SBATCH --partition=gpu-shared          # define GPU partition
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --gres=gpu:1         # define type of GPU
#SBATCH -t 00:10:00

#Load the cuda module
module load cuda

#Run the job
./gpu_enum

```

<b>Submit the job </b>
To run the job, type the batch script submission command:
```
[comet-ln2:~/cuda/gpu_enum] sbatch gpu_enum.sb 
Submitted batch job 22527745
[comet-ln2:~/cuda/gpu_enum] 
```
<b>Monitor the job </b>
Monitor the job until it is finished
```
[user@comet-ln2:~/cuda/gpu_enum] sbatch gpu_enum.sb
Submitted batch job 22527745
[user@comet-ln2:~/cuda/gpu_enum] squeue -u user
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          22527745 gpu-share gpu_enum  user PD       0:00      1 (None)

```

#### <a name="enum-gpu-batch-output"></a>GPU Enumeration: Batch Job Output 
Output from script is for one device, which is what was specified in script.

```
[user@comet-ln2:~/cuda/gpu_enum] cat gpu_enum.22527745.comet-31-10.out
 --- Obtaining General Information for CUDA devices  ---
 --- General Information for device 0 ---
Name: Tesla K80
Compute capability: 3.7
Clock rate: 823500
Device copy overlap: Enabled
Kernel execution timeout : Disabled
 --- Memory Information for device 0 ---
Total global mem: 11996954624
Total constant Mem: 65536
Max mem pitch: 2147483647
Texture Alignment: 512
 --- MP Information for device 0 ---
Multiprocessor count: 13
Shared mem per mp: 49152
Registers per mp: 65536
Threads in warp: 32
Max threads per block: 1024
Max thread dimensions: (1024, 1024, 64)
Max grid dimensions: (2147483647, 65535, 65535)
```
If we change the batch script to ask for 2 devices (see line 8):
```
 1 #!/bin/bash
  2 #SBATCH --job-name="gpu_enum"
  3 #SBATCH --output="gpu_enum.%j.%N.out"
  4 #SBATCH --partition=gpu-shared          # define GPU partition
  5 #SBATCH --nodes=1
  6 #SBATCH --ntasks-per-node=6
  7 ####SBATCH --gres=gpu:1         # define type of GPU
  8 #SBATCH --gres=gpu:2         # first available
  9 #SBATCH -t 00:05:00
 10 
 11 #Load the cuda module
 12 module load cuda
 13 
 14 #Run the job
 15 ./gpu_enum
```

The output looks like this:
```
[user@comet-ln2:~/cuda/gpu_enum] cat gpu_enum.22528598.comet-33-09.out 
 --- Obtaining General Information for CUDA devices  ---
 --- General Information for device 0 ---
Name: Tesla P100-PCIE-16GB
Compute capability: 6.0
Clock rate: 1328500
Device copy overlap: Enabled
Kernel execution timeout : Disabled
 --- Memory Information for device 0 ---
Total global mem: 17071734784
Total constant Mem: 65536
Max mem pitch: 2147483647
Texture Alignment: 512
 --- MP Information for device 0 ---
Multiprocessor count: 56
Shared mem per mp: 49152
Registers per mp: 65536
Threads in warp: 32
Max threads per block: 1024
Max thread dimensions: (1024, 1024, 64)
Max grid dimensions: (2147483647, 65535, 65535)

 --- General Information for device 1 ---
Name: Tesla P100-PCIE-16GB
Compute capability: 6.0
Clock rate: 1328500
Device copy overlap: Enabled
Kernel execution timeout : Disabled
 --- Memory Information for device 1 ---
Total global mem: 17071734784
Total constant Mem: 65536
Max mem pitch: 2147483647
Texture Alignment: 512
 --- MP Information for device 1 ---
Multiprocessor count: 56
Shared mem per mp: 49152
Registers per mp: 65536
Threads in warp: 32
Max threads per block: 1024
Max thread dimensions: (1024, 1024, 64)
Max grid dimensions: (2147483647, 65535, 65535)
```

[Back to GPU/CUDA Jobs](#comp-and-run-cuda-jobs) <br>
[Back to Top](#top)
<hr>

### <a name="mat-mul-gpu"></a>GPU/CUDA Example: Mattrix-Multiplication
Sections:
* [Matrix Mult. (GPU): Compiling](#mat-mul-gpu-compile)
* [Matrix Mult. (GPU): Batch Script Submission](#mat-mul-gpu-batch-submit)
* [Matrix Mult. (GPU): Batch Job Output](#mat-mul-gpu-batch-output )

#### <a name="mat-mul-gpu"></a>CUDA Example: Matrix-Multiplication
<b>Change to the CUDA Matrix-Multiplication example directory:</b>
```
[user@comet-ln2/comet-examples/PHYS244]$ cd /home/user/comet-examples/PHYS244/CUDA
[user@comet-ln2 CUDA]$ ls -al
total 427
drwxr-xr-x  2 user user300     11 Aug  5 19:02 .
drwxr-xr-x 16 user user300     16 Aug  5 19:02 ..
-rw-r--r--  1 user user300    446 Aug  5 19:02 CUDA.8718375.comet-30-08.out
-rw-r--r--  1 user user300    253 Aug  5 19:02 cuda.sb
-rw-r--r--  1 user user300   5106 Aug  5 19:02 exception.h
-rw-r--r--  1 user user300   1168 Aug  5 19:02 helper_functions.h
-rw-r--r--  1 user user300  29011 Aug  5 19:02 helper_image.h
-rw-r--r--  1 user user300  23960 Aug  5 19:02 helper_string.h
-rw-r--r--  1 user user300  15414 Aug  5 19:02 helper_timer.h
-rwxr-xr-x  1 user user300 533168 Aug  5 19:02 matmul
-rw-r--r--  1 user user300  13482 Aug  5 19:02 matrixMul.cu
```


#### <a name="mat-mul-gpu-compile"></a>Compiling CUDA Example (GPU)

<b> Compile the code:</b>
```
[user@comet-ln2 CUDA]$ nvcc -o matmul -I.  matrixMul.cu
[user@comet-ln2 CUDA]$ ll
total 172
drwxr-xr-x  2 user user300     13 Aug  6 00:53 .
drwxr-xr-x 16 user user300     16 Aug  5 19:02 ..
-rw-r--r--  1 user user300    458 Aug  6 00:35 CUDA.18347152.comet-33-02.out
-rw-r--r--  1 user user300    458 Aug  6 00:37 CUDA.18347157.comet-33-02.out
-rw-r--r--  1 user user300    446 Aug  5 19:02 CUDA.8718375.comet-30-08.out
-rw-r--r--  1 user user300    253 Aug  5 19:02 cuda.sb
-rw-r--r--  1 user user300   5106 Aug  5 19:02 exception.h
-rw-r--r--  1 user user300   1168 Aug  5 19:02 helper_functions.h
-rw-r--r--  1 user user300  29011 Aug  5 19:02 helper_image.h
-rw-r--r--  1 user user300  23960 Aug  5 19:02 helper_string.h
-rw-r--r--  1 user user300  15414 Aug  5 19:02 helper_timer.h
-rwxr-xr-x  1 user user300 533168 Aug  6 00:53 matmul
-rw-r--r--  1 user user300  13482 Aug  6 00:50 matrixMul.cu
 ```

<hr>

#### <a name="mat-mul-gpu-batch-submit"></a>Matrix Mult. (GPU): Batch Script Submission

<b>Contents of the slurm script:</b>
```
[user@comet-ln2 CUDA]$ cat cuda.sb
#!/bin/bash
#SBATCH --job-name="matmul"
#SBATCH --output="matmul.%j.%N.out"
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --gres=gpu:1
#SBATCH -t 01:00:00

#Load the cuda module
module load cuda

#Run the job
./matmul
```
<b> Submit the job:</b>
```
[user@comet-ln2 CUDA]$ sbatch cuda.sb
Submitted batch job 18347288
[user@comet-ln2 CUDA]$

```
<b>Monitor the job:</b>
```
[user@comet-ln2 CUDA]$squeue -u user 
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          18347288 gpu-share     matmul  user PD       0:00      1 (None)
[user@comet-ln2 CUDA]$
```


<hr>

#### <a name="mat-mul-gpu-batch-output"></a>Matrix Mult. (GPU): Batch Job Output

```
[user@comet-ln2 CUDA]$ cat matmul.18347288.comet-33-01.out
[Matrix Multiply Using CUDA] - Starting...
[Matrix Multiply Using CUDA] - Welcome SI18 Attendees...

GPU Device 0: "Tesla P100-PCIE-16GB" with compute capability 6.0

MatrixA(320,320), MatrixB(640,320)
Computing result using CUDA Kernel...
done
Performance= 1703.30 GFlop/s, Time= 0.077 msec, Size= 131072000 Ops, WorkgroupSize= 1024 threads/block
Checking computed result for correctness: Result = PASS

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.

```


[Back to GPU/CUDA Jobs](#comp-and-run-cuda-jobs) <br>
[Back to Top](#top)
<hr>


