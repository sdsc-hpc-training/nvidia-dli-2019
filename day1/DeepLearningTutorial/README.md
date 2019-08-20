###  Running Jupyter Notebook on Comet


```
[etrain118@comet-30-09 ~]$ . /share/apps/compute/si2019/miniconda3/etc/profile.d/conda.sh
[etrain118@comet-30-09 ~]$ which conda
/share/apps/compute/si2019/miniconda3/condabin/conda
```
# run conda notebook manager

```
[etrain118@comet-30-09 ~]$ conda activate
```
# launch the jupyter notebook
```
(base) [etrain118@comet-30-09 ~]$ jupyter notebook --no-browser -ip='/bin/hostname'
The Jupyter HTML Notebook.

This launches a Tornado based HTML Notebook Server that serves up an
HTML5/Javascript Notebook client.

Subcommands
-----------

Subcommands are launched as `jupyter-notebook cmd [args]`. For information on
using subcommand 'cmd', do: `jupyter-notebook cmd -h`.

list
    List currently running notebook servers.
stop
    Stop currently running notebook server for a given port
password
    Set a password for the notebook server.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--debug
    set log level to logging.DEBUG (maximize logging output)
--generate-config
    generate default config file
-y
    Answer yes to any questions instead of prompting.
--no-browser
    Don't open the notebook in a browser after startup.
--pylab
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
--no-mathjax
    Disable MathJax
    
    MathJax is the javascript library Jupyter uses to render math/LaTeX. It is
    very large, so you may want to disable it if you have a slow internet
    connection, or for offline use of the notebook.
    
    When disabled, equations etc. will appear as their untransformed TeX source.
--allow-root
    Allow the notebook to be run from root user.
--script
    DEPRECATED, IGNORED
--no-script
    DEPRECATED, IGNORED
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--ip=<Unicode> (NotebookApp.ip)
    Default: 'localhost'
    The IP address the notebook server will listen on.
--port=<Int> (NotebookApp.port)
    Default: 8888
    The port the notebook server will listen on.
--port-retries=<Int> (NotebookApp.port_retries)
    Default: 50
    The number of additional ports to try if the specified port is not
    available.
--transport=<CaselessStrEnum> (KernelManager.transport)
    Default: 'tcp'
    Choices: ['tcp', 'ipc']
--keyfile=<Unicode> (NotebookApp.keyfile)
    Default: ''
    The full path to a private key file for usage with SSL/TLS.
--certfile=<Unicode> (NotebookApp.certfile)
    Default: ''
    The full path to an SSL/TLS certificate file.
--client-ca=<Unicode> (NotebookApp.client_ca)
    Default: ''
    The full path to a certificate authority certificate for SSL/TLS client
    authentication.
--notebook-dir=<Unicode> (NotebookApp.notebook_dir)
    Default: ''
    The directory to use for notebooks and kernels.
--browser=<Unicode> (NotebookApp.browser)
    Default: ''
    Specify what command to use to invoke a web browser when opening the
    notebook. If not specified, the default browser will be determined by the
    `webbrowser` standard library module, which allows setting of the BROWSER
    environment variable to override it.
--pylab=<Unicode> (NotebookApp.pylab)
    Default: 'disabled'
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
--gateway-url=<Unicode> (GatewayClient.url)
    Default: None
    The url of the Kernel or Enterprise Gateway server where kernel
    specifications are defined and kernel management takes place. If defined,
    this Notebook server acts as a proxy for all kernel management and kernel
    specification retrieval.  (JUPYTER_GATEWAY_URL env var)

To see all available configurables, use `--help-all`

Examples
--------

    jupyter notebook                       # start the notebook
    jupyter notebook --certfile=mycert.pem # use SSL/TLS certificate
    jupyter notebook password              # enter a password to protect the server

[C 15:29:07.716 NotebookApp] Bad config encountered during initialization:
[C 15:29:07.716 NotebookApp] Invalid argument: '-ip=/bin/hostname', did you mean '--ip=/bin/hostname'?
(base) [etrain118@comet-30-09 ~]$ jupyter notebook --no-browser -ip=`/bin/hostname`
The Jupyter HTML Notebook.

This launches a Tornado based HTML Notebook Server that serves up an
HTML5/Javascript Notebook client.

Subcommands
-----------

Subcommands are launched as `jupyter-notebook cmd [args]`. For information on
using subcommand 'cmd', do: `jupyter-notebook cmd -h`.

list
    List currently running notebook servers.
stop
    Stop currently running notebook server for a given port
password
    Set a password for the notebook server.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--debug
    set log level to logging.DEBUG (maximize logging output)
--generate-config
    generate default config file
-y
    Answer yes to any questions instead of prompting.
--no-browser
    Don't open the notebook in a browser after startup.
--pylab
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
--no-mathjax
    Disable MathJax
    
    MathJax is the javascript library Jupyter uses to render math/LaTeX. It is
    very large, so you may want to disable it if you have a slow internet
    connection, or for offline use of the notebook.
    
    When disabled, equations etc. will appear as their untransformed TeX source.
--allow-root
    Allow the notebook to be run from root user.
--script
    DEPRECATED, IGNORED
--no-script
    DEPRECATED, IGNORED
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--ip=<Unicode> (NotebookApp.ip)
    Default: 'localhost'
    The IP address the notebook server will listen on.
--port=<Int> (NotebookApp.port)
    Default: 8888
    The port the notebook server will listen on.
--port-retries=<Int> (NotebookApp.port_retries)
    Default: 50
    The number of additional ports to try if the specified port is not
    available.
--transport=<CaselessStrEnum> (KernelManager.transport)
    Default: 'tcp'
    Choices: ['tcp', 'ipc']
--keyfile=<Unicode> (NotebookApp.keyfile)
    Default: ''
    The full path to a private key file for usage with SSL/TLS.
--certfile=<Unicode> (NotebookApp.certfile)
    Default: ''
    The full path to an SSL/TLS certificate file.
--client-ca=<Unicode> (NotebookApp.client_ca)
    Default: ''
    The full path to a certificate authority certificate for SSL/TLS client
    authentication.
--notebook-dir=<Unicode> (NotebookApp.notebook_dir)
    Default: ''
    The directory to use for notebooks and kernels.
--browser=<Unicode> (NotebookApp.browser)
    Default: ''
    Specify what command to use to invoke a web browser when opening the
    notebook. If not specified, the default browser will be determined by the
    `webbrowser` standard library module, which allows setting of the BROWSER
    environment variable to override it.
--pylab=<Unicode> (NotebookApp.pylab)
    Default: 'disabled'
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
--gateway-url=<Unicode> (GatewayClient.url)
    Default: None
    The url of the Kernel or Enterprise Gateway server where kernel
    specifications are defined and kernel management takes place. If defined,
    this Notebook server acts as a proxy for all kernel management and kernel
    specification retrieval.  (JUPYTER_GATEWAY_URL env var)

To see all available configurables, use `--help-all`

Examples
--------

    jupyter notebook                       # start the notebook
    jupyter notebook --certfile=mycert.pem # use SSL/TLS certificate
    jupyter notebook password              # enter a password to protect the server

[C 15:29:18.841 NotebookApp] Bad config encountered during initialization:
[C 15:29:18.841 NotebookApp] Invalid argument: '-ip=comet-30-09.sdsc.edu', did you mean '--ip=comet-30-09.sdsc.edu'?
(base) [etrain118@comet-30-09 ~]$ jupyter notebook --no-browser --ip=`/bin/hostname`
[I 15:29:41.465 NotebookApp] Writing notebook server cookie secret to /home/etrain118/.local/share/jupyter/runtime/notebook_cookie_secret
[I 15:29:41.689 NotebookApp] The port 8888 is already in use, trying another port.
[I 15:29:41.693 NotebookApp] Serving notebooks from local directory: /home/etrain118
[I 15:29:41.693 NotebookApp] The Jupyter Notebook is running at:
[I 15:29:41.693 NotebookApp] http://comet-30-09.sdsc.edu:8889/?token=77927d4e0146981ae3a079ea841ea9ec076b35a3aefe5351
[I 15:29:41.693 NotebookApp]  or http://127.0.0.1:8889/?token=77927d4e0146981ae3a079ea841ea9ec076b35a3aefe5351
[I 15:29:41.694 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 15:29:41.699 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/etrain118/.local/share/jupyter/runtime/nbserver-72011-open.html
    Or copy and paste one of these URLs:
        http://comet-30-09.sdsc.edu:8889/?token=####################################
     or http://127.0.0.1:8889/?token=####################################
```
