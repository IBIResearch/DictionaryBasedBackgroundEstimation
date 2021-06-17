##################################
# Load Packages and Activate Env #
##################################
using Pkg 
Pkg.activate(".")
Pkg.instantiate()

using MPIReco, Plots, LazyArtifacts

# Download data
datadir = artifact"data"
store = MDFDatasetStore(datadir)

##############
# Parameters #
##############

# Dataset store handling
study = getStudies(store, "BGDrift")[1]
exp = getExperiment(study, 1)

# Measurement data
filenameMeas = path(exp)
f = MPIFile(filenameMeas)

# System matrices
datadirSF = joinpath(calibdir(store), "1.mdf")
fSF = MPIFile(datadirSF)

# Background frames
bgFrames = 51:55

# Selected frames
frames = 131  # change this to e.g. 51:191 to reconstruct a range of frames 

# Bounds for frequency selection
minFreq = 20e3 # change this to 40e3 to exclude the excitation frequency
maxFreq = 200e3

# Use only the first receive channel
recChannels = 1:1

# Solver parameters
λ = 1.0
iterations = 20

# Parameters for the joint estimation of BG and particle concentration
beta = (1/5)^(5)
dictSize = 10

# Put all parameters into a dictionary
params = Dict{Symbol,Any}(
  :frames => frames,
  :bgFrames => bgFrames,
  :bgCorrectionInternal => true,
  :λ => λ,
  :recChannels => recChannels,
  :iterations => iterations,
  :minFreq => minFreq,
  :maxFreq => maxFreq,
  :SNRThresh => -1,
  :enforceReal => true,
  :enforcePositive => true,
  :spectralLeakageCorrection =>false
 )

##########################
# Perform reconstruction #
##########################

@info "Reconstruction with static BG correction"
paramsStatic = deepcopy(params)
cStaticCorr = reconstruction(fSF,f; paramsStatic...).data.data

@info "Reconstruction with linear interpolated BG correction"
paramsInterp = deepcopy(params)
paramsInterp[:bgFramesPost] = 201:205
cDynCorr = reconstruction(fSF,f; paramsInterp...).data.data

@info "Reconstruction with joint estimation of BG and particle distribution"
paramsJoint = deepcopy(params)
paramsJoint[:bgDictSize] = dictSize
paramsJoint[:beta] = beta
cBGEst = reconstruction(fSF,f; paramsJoint...).data.data

###########################
## Visualize the results ##
###########################

# Windowing parameters
vmin = 0.0
vmax = 0.0006

p1 = heatmap(cStaticCorr[1,:,:,1,1], clim=(vmin,vmax), c=:viridis, 
             title="Static", aspect_ratio=1 )
p2 = heatmap(cDynCorr[1,:,:,1,1], clim=(vmin,vmax), c=:viridis, 
             title="Linear", aspect_ratio=1 )
p3 = heatmap(cBGEst[1,:,:,1,1], clim=(vmin,vmax), c=:viridis, 
             title="Joint", aspect_ratio=1 )

plot(p1, p2, p3, layout = (1, 3), size=(1000,350))
