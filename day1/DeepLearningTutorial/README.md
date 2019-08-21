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
note: make sure that the argument is two dashes for "--no-browser"
```
(base) [etrain118@comet-30-09 ~]$ jupyter notebook --no-browser -ip='/bin/hostname'
The Jupyter HTML Notebook.

This launches a Tornado based HTML Notebook Server that serves up an
HTML5/Javascript Notebook client.


    To access the notebook, open this file in a browser:
        file:///home/etrain118/.local/share/jupyter/runtime/nbserver-72011-open.html
    Or copy and paste one of these URLs:
        http://comet-30-09.sdsc.edu:8889/?token=####################################
     or http://127.0.0.1:8889/?token=####################################
```
