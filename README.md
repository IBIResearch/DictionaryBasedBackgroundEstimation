# Dictionary Based Background Estimation Example

This folder contains example code for applying a joint reconstruction of
background and particle concentration of magnetic particle imaging (MPI) data. 
The method uses a background dictionary that is setup using the background scans measured during system
matrix acquisition.

The method is described in the associated publication

T. Knopp, M. Grosser, M. Gräser, T. Gerkmann, M. Möddel, Efficient Joint Estimation of Tracer Distribution and Background Signals in Magnetic Particle Imaging using a Dictionary Approach, *IEEE Transactions on Medical Imaging*, 2021  [*arXiv:2101.12624*](https://arxiv.org/abs/2006.05741).


## Installation

In order to use this code one first has to download Julia (version 1.6 or later) then clone this repository and navigate to the folder in the command line. Once you are there, startup Julia with
```julia
julia --project=.
```
which will open Julia with the required packages. Then enter
Load the package by entering
```julia
using Pkg; Pkg.instantiate()
```
which will install all required packages.

## Execution
After installation the example code can be executed by entering
```julia
include("example.jl")
```
This will first download all data (about 134 MB) and then perform a reconstruction.
Parameters of the reconstruction are documented in the Julia script and can be
changed. After the reconstruction is done, the script will open a plotting window
and show the reconstruction result. 
