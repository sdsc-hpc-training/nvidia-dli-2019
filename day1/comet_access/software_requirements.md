Running GPU Jobs on Comet:  Software Requirements

While many of the hands-on activities will be run on Comet, some sessions require that customized software be installed on your laptop. Please perform the following software installations and file downloads before you arrive. Note: several of the preparation activities will provide information and guidance on how to install the required software components.

## Contents
 * [Preparation: Install `git`](#git)
 * [Preparation: Obtain a GitHub Account](#github)
 * [Preparation: Anaconda for Jupyter Notebooks](#anaconda)
 * [Plenary session: An Introduction to Singularity](#singularity)
 * [Parallel sessions: Machine Learning Overview](#mach-learn)
 

### Preparation: Install `git` <a name="git"></a>

Throughout the course of this week, you will find presentation slides, example 
code, datasets, and other training material available via this GitHub 
repository. In some training sessions, you will likely be asked to obtain of a 
copy of the files in this repository to complete a part of your hands-on 
training. The easiest way to do this will be with [`git`](https://git-scm.com/).
As such, before you arrive at the Summer Institute, please make sure you have 
installed a copy of `git` on your laptop.

**Installing `git` on Linux:**

If you want to install `git` on a Linux-based operating system, you should be
able to do so via your operating system's standard package management tool. For
example, on any RPM-based Linux distribution, such as Fedora, RHEL, or CentOS, 
you can use `dnf`:

```
$ sudo dnf install git-all
```

Or on any Debian-based distribution, such as Ubuntu, try `apt`:

```
$ sudo apt install git-all
```

**Installing `git` on Mac OS X:**

There are several ways to install `git` on your Mac. However, probably the 
easiest way is to install the [Xcode](https://developer.apple.com/xcode/) 
Command Line Tools, which you should be able to do by simply tying to run git 
from your [Terminal](https://support.apple.com/guide/terminal/welcome/mac):

```
$ git --version
```

If it's not already installed, you should be prompted to install it.

If the above option does not work or you need a more up-to-date version of 
`git`, you can always install it via a binary installer maintained by the `git`
team, which is available for download at: 

[https://git-scm.com/download/mac](https://git-scm.com/download/mac). 

The download should start immediately.

**Installing `git` on Windows:**

There are also several ways to install `git` under Windows. The official 
binary executable is available for download on the `git` website:

[https://git-scm.com/download/win](https://git-scm.com/download/win)

However, if you've chosen to work on the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
this week, then simply follow the installation directions for Linux given above.

### Preparation: Obtain a Github Account <a name="github"></a>

If you do not currently have a [GitHub](https://github.com/) account, please
consider obtaining one prior to attending the Summer Institute. How you can 
integrate `git` and GitHub into your work will be covered in both an 
introductory and advanced training session on these tools.

### Preparation: Anaconda for Jupyter Notebooks <a name="anaconda"></a>
Some sessions and tutorials will be using Jupyter Notebooks. To learn more, see Jupyter/IPython Notebook Quick Start Guide:
[https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/index.html](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/index.html)

The Jupyter Notebook App can be installed using a scientific python distribution which also includes scientific python packages. The most common distribution is called Anaconda. To download:
[https://www.anaconda.com/download/](https://www.anaconda.com/download/)

