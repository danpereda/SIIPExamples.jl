#' ---
#' title: Parsing MATPOWER Files
#' ---

#' **Originally Contributed by**: Clayton Barrows

#' ## Introduction

#' An example of how to parse MATPOWER files and create a `System` using [PowerSystems.jl](github.com/NREL/PowerSystems.jl)

#' ### Environemnt
#' This notebook depends on the SIIPExamples.jl environment

using Pkg
Pkg.activate("../../.")


#' ### Dependencies

using PowerSystems
using TimeSeries
const PSY = PowerSystems
const IS = PSY.InfrastructureSystems;

#' ### Fetch Data
#' PowerSystems.jl links to some test data that is suitable for this example. 
#' Let's download the test data
PSY.download(PSY.TestData; branch = "master")
base_dir = dirname(dirname(pathof(PowerSystems)));

#' ### Create a `System`
sys = PSY.parse_standard_files(joinpath(base_dir, "data/matpower/RTS_GMLC.m"));

sys