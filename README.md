# Dictionary Based Background Estimation Example

This folder contains example code for applying a joint reconstruction of
background and particle concentration of magnetic particle imaging (MPI) data. 
The method uses a background dictionary that is setup using the background scans measured during system
matrix acquisition.

The method is described in the associated publication

T. Knopp, M. Grosser, M. Gräser, T. Gerkmann, M. Möddel, Efficient Joint Estimation of Tracer Distribution and Background Signals in Magnetic Particle Imaging using a Dictionary Approach, *IEEE Transactions on Medical Imaging*, 2021  [*arXiv:2101.12624*](https://arxiv.org/abs/2006.05741).


## Installation

In order to use this code one first has to download [Julia](https://julialang.org/) (version 1.6 or later), clone this repository and navigate to the folder in the command line. The example script automatically activates the environment and installs all necessary packages.

## Execution
After installation the example code can be executed by running `julia` and entering
```julia
include("example.jl")
```
This will first download all data and then perform a reconstruction.
Parameters of the reconstruction are documented in the Julia script and can be
changed. After the reconstruction is done, the script will open a plotting window
and show the reconstruction result. 

## Open MPI Data

The measurement data associated to this project is about 134 MB large and will be downloaded and stored automatically, when the code is executed for the first time.
It is published under a [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode) license and can be found here:

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4972124.svg)](https://doi.org/10.5281/zenodo.4972124)
