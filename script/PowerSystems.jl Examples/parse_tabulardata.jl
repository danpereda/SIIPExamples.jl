#' ---
#' title: Parsing Tabular Data

#' **Originally Contributed by**: Clayton Barrows

#' ## Introduction

#' An example of how to parse tabular files (CSV) files similar to the format established in 
#' the [RTS-GMLC](github.com/gridmod/rts-gmlc/RTS_Data/SourceData) and create a `System` using 
#' [PowerSystems.jl](github.com/NREL/PowerSystems.jl)

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

#' ### The tabular data format relies on a folder containing `*.csv` files and a `user_descriptors.yaml` file
#' First, we'll read the tabular data
RTS_GMLC_DIR = joinpath(base_dir,"data/RTS_GMLC");
rawsys = PSY.PowerSystemTableData(RTS_GMLC_DIR,100.0, joinpath(RTS_GMLC_DIR,"user_descriptors.yaml"))

#' Next, we'll create a `System` from the `rawsys` data. Since a `System` is predicated on a 
#' forecast resolution and the `rawsys` data includes both 5-minute and 1-hour resolution 
#' forecasts, we also need to specify which forecasts we want to include in the `Systeem`. 
#' The `forecast_resolution` kwarg filters to only include forecsats with a matching resolution.

sys = System(rawsys; forecast_resolution = Dates.Hour(1));

sys
